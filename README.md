Scheduled Azure Search ReplicaCount Change by using Automation
==============================================================

            

Azure Search does not provide autoscale or scheduled-scale functionality.


In order to achieve scheduled ReplicaCount for Azure Search, this script can be a solution to work with Azure Automation.


- Requirements: Azure Automation account and Azure Search resource.


- Parameters: (1) Azure Subscription Id, (2) resourcegroup name of AzSearch resource, (3) resource name of AzSearch resource, (4) ReplicaCount


- How to use


  *  Create Azure Automation account 
  *  Create Azure Powershell runbook and import this script 
  *  Set parameters and just run it to test. 
  *  Make your own schedules to run. 

- Reference: https://docs.microsoft.com/en-us/azure/search/search-manage-powershell


 


 

 

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
