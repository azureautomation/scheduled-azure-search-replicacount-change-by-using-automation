<#
    .DESCRIPTION
        Scale Azure Search ReplicaCount
        AzSearch command reference; https://docs.microsoft.com/en-us/azure/search/search-manage-powershell

    .NOTES
        AUTHOR: Youngjae Kim
        LASTEDIT: June 19, 2017
#>

Param(
 [string]$SubscriptionId,
 [string]$ResourceGroupName,
 [string]$AzSearchResourceName,
 [int]$InstanceCount = 1
)


# 1. Acquire Automation account
$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found. You must have Automation account. Reference: https://docs.microsoft.com/en-us/azure/automation/automation-role-based-access-control"
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

# 2. Select subscription
Select-AzureRmSubscription -SubscriptionId $SubscriptionId

# 3. Specify Azure Search Resource
$resource = Get-AzureRmResource `
    -ResourceType "Microsoft.Search/searchServices" `
    -ResourceGroupName $ResourceGroupName `
    -ResourceName $AzSearchResourceName `
    -ApiVersion 2015-08-19
Write-Output ($resource)

# 4. Scale your service up
# Note that this will only work if you made a non "free" service
# This command will not return until the operation is finished
Write-Output ("Updating InstanceCount to " + $InstanceCount + ". This can take 15 minutes or more...")
$resource.Properties.ReplicaCount = $InstanceCount
$resource | Set-AzureRmResource -Force -Confirm:$false

# 5. Finish
Write-Output ("End of Process to set InstanceCount = " + $InstanceCount + " for " + $AzSearchResourceName)
