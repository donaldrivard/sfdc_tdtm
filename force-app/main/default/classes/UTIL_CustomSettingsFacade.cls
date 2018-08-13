/**
* @author Salesforce.org
* @date 2014
* @group Utilities
* @description Helper class that retrieves custom settings and sets defaults.
* Needs to be "without sharing" so that the Install Script can run it.
*/
public without sharing class UTIL_CustomSettingsFacade {
    private static final String DEFAULT_OPPORTUNITY_CONTACT_ROLE_DONOR = 'Donor';
    public static final String DEFAULT_OPPORTUNITY_CONTACT_ROLE_SOFT_CREDIT = 'Soft Credit';

    //storing user-level custom settings in-memory to avoid trying to isert/update them 
    //twice and thus trigger the "duplicate OwnerId" error
    static Error_Settings__c errorSettings;
    //static Batch_Data_Entry_Settings__c bdeSettings;
    
    //storing org-level custom settings in-memory to avoid slowing down the settings page
   
    static Error_Settings__c orgErrorSettings;
    //static Batch_Data_Entry_Settings__c orgBdeSettings;
    
    /*******************************************************************************************************
    * @description Resets specific Custom Settings that are updated after 
    *   Record Type Settings have been fixed.
    * @return void  
    */
    public static void reloadCustomSettingsOnRecordTypeCleanup() {
        
    }

   
    
    
    
    /*******************************************************************************************************
    * @description Returns the default Error Handling settings. 
    * @return Error_Settings__c Custom settings record for Error Handling configuration. At the org level, if no user 
    * level settings are defined. The ID field should be checked to determine if the returned record already
    * exists or doesn't exist in the database.
    */
    public static Error_Settings__c getErrorSettings() {
        if(Test.isRunningTest() && errorSettings == null) {
            errorSettings = new Error_Settings__c();
            configErrorSettings(errorSettings, null);
        } else if(errorSettings == null) {
            errorSettings = Error_Settings__c.getInstance();
            if(errorSettings.Id == null)
                errorSettings = getOrgErrorSettings();
        }    
        return errorSettings;
    }
    
    /*******************************************************************************************************
    * @description Returns the default Batch Data Entry settings. 
    * @return Batch_Data_Entry_Settings__c Custom settings record for Batch Data Entry configuration. At the org level, 
    * if no user level settings are defined. The ID field should be checked to determine if the returned record already
    * exists or doesn't exist in the database.
    
    public static Batch_Data_Entry_Settings__c getBDESettings() {
        if(Test.isRunningTest() && bdeSettings == null) {
            bdeSettings = new Batch_Data_Entry_Settings__c();
            configBDESettings(bdeSettings);
        } else if(bdeSettings == null) {
            bdeSettings = Batch_Data_Entry_Settings__c.getInstance();
            if(bdeSettings.Id == null)
                bdeSettings = getOrgBDESettings();
        }
        return bdeSettings;
    }
    */
    
    
    
    
    /*******************************************************************************************************
    * @description Returns the default Data Import settings. 
    * @return Data_Import_Settings__c Custom settings record for Data Import configuration. At the org level, if no user level
    * settings are defined. The ID field should be checked to determine if the returned record already exists or doesn't exist 
    * in the database.
   
    public static Data_Import_Settings__c getDataImportSettings() {        
        if(Test.isRunningTest() && dataImportSettings == null) {
            dataImportSettings = new Data_Import_Settings__c();
        } else if (dataImportSettings == null) {
            dataImportSettings = Data_Import_Settings__c.getInstance();
            if (dataImportSettings.Id == null) 
                dataImportSettings = getOrgDataImportSettings();
        }
        // always call config, to deal with new settings we've added
        // we'll only config those setting that are null
        configDataImportSettings(dataImportSettings);
        return dataImportSettings;
    }

    */
   
    
    
    /*******************************************************************************************************
    * @description Returns the org-level Error settings. Default org-level settings will be created 
    * if none exist. Meant to be called only from settings page and install script.
    * @return Error_Settings__c Org-level settings for Errors.
    */
    public static Error_Settings__c getOrgErrorSettings() {
        if(orgErrorSettings == null) {
            orgErrorSettings = Error_Settings__c.getOrgDefaults();
            if(orgErrorSettings.Id == null) {
                configErrorSettings(orgErrorSettings, null);
                if(!Test.isRunningTest())
                    upsert orgErrorSettings;
            }
        }
        return orgErrorSettings;
    }
    
    /*******************************************************************************************************
    * @description Returns the org-level Batch Data Entry settings. Default org-level settings will be created 
    * if none exist. Meant to be called only from settings page and install script.
    * @return Batch_Data_Entry_Settings__c Org-level settings for Batch Data Entry.
    
    public static Batch_Data_Entry_Settings__c getOrgBDESettings() {
        if(orgBDESettings == null) {
            orgBDESettings = Batch_Data_Entry_Settings__c.getOrgDefaults();
            if(orgBDESettings.Id == null) {
                configBDESettings(orgBDESettings);
                if(!Test.isRunningTest())
                    upsert orgBDESettings;
            }
        }
        return orgBDESettings;
    }
    */
    
    /*******************************************************************************************************
    * @description Returns the org-level Data Import settings. Default org-level settings will be created 
    * if none exist. Meant to be called only from settings page and install script.
    * @return Data_Import_Settings__c Org-level settings for Data Import.
    
    public static Data_Import_Settings__c getOrgDataImportSettings() {
        if (orgDataImportSettings == null) {
            orgDataImportSettings = Data_Import_Settings__c.getOrgDefaults();
            if (orgDataImportSettings.Id == null) {
                configDataImportSettings(orgDataImportSettings);
                if(!Test.isRunningTest()) {
                    upsert orgDataImportSettings;
                }
            }
        }
        return orgDataImportSettings;
    }
*/
   

    private static void configErrorSettings(Error_Settings__c es, String notificationsTo) {   
        es.Store_Errors_On__c = true;
        es.Error_Notifications_On__c = true;
        //es.Error_Notifications_To__c = ERR_Notifier.NotificationOptions.sysAdmins;
        es.Disable_Error_Handling__c = false;
        es.Enable_Debug__c = false;
        es.Respect_Duplicate_Rule_Settings__c = false;
    }
    /*
    private static void configBDESettings(Batch_Data_Entry_Settings__c bds) {
        bds.Allow_Blank_Opportunity_Names__c = true;
        bds.Opportunity_Naming__c = true;
    }
*/
   
   
    /*******************************************************************************************************
    * @description Creates instance of settings to use in tests. It does not insert it, but all other methods will see these settings
    * as the configured settings.
    * @parameter mySettings Settings instance with the values to set.
    * @return Error_Settings__c The configured settings.
    **/
    public static Error_Settings__c getErrorSettingsForTests(Error_Settings__c mySettings) {
        if(errorSettings == null)
           errorSettings = new Error_Settings__c();
           
        errorSettings.Error_Notifications_On__c = mySettings.Error_Notifications_On__c;   
        errorSettings.Error_Notifications_To__c = mySettings.Error_Notifications_To__c;
        errorSettings.Store_Errors_On__c = mySettings.Store_Errors_On__c;
        errorSettings.Respect_Duplicate_Rule_Settings__c = mySettings.Respect_Duplicate_Rule_Settings__c;
        orgErrorSettings = errorSettings;
        return errorSettings;  
    }

   

}