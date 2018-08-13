/**
* @author Salesforce.org
* @date 2017
* @group Utilities
* @description Service Class to handle DML actions.
*/

public class UTIL_DMLService {
    public static final Boolean ALL_OR_NONE_TRUE = true;
    

    /*********************************************************************************************************
    * @description Wraps the Database class insert method and defaults the DMLOptions optAllOrNone to false 
    *   and DuplicateRuleHeader.AllowSave to true.
    * @param recordToInsert The sObject to add to the org.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult insertRecord(sObject recordToInsert) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = ALL_OR_NONE_TRUE;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.insert(recordToInsert, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class insert method and defaults the DMLOptions optAllOrNone to false 
    *   and DuplicateRuleHeader.AllowSave to true.
    * @param recordsToInsert The sObjects to add to the org.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> insertRecords(List<sObject> recordsToInsert) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = ALL_OR_NONE_TRUE;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.insert(recordsToInsert, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class insert method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordToInsert The sObject to add to the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult insertRecord(sObject recordToInsert, Boolean allOrNone) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = allOrNone;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.insert(recordToInsert, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class insert method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordsToInsert The sObjects to add to the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> insertRecords(List<sObject> recordsToInsert, Boolean allOrNone) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = allOrNone;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.insert(recordsToInsert, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class insert method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordToInsert The sObject to add to the org.
    * @param dmlOptions The optional parameter that specifies additional data for the transaction.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult insertRecord(sObject recordToInsert, Database.DMLOptions dmlOptions) {
        if (!useAllowSaveProperty(dmlOptions)) {
            dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();
        }

        return Database.insert(recordToInsert, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class insert method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordsToInsert The sObjects to add to the org.
    * @param dmlOptions The optional parameter that specifies additional data for the transaction.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> insertRecords(List<sObject> recordsToInsert, Database.DMLOptions dmlOptions) {
        if (!useAllowSaveProperty(dmlOptions)) {
            dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();
        }

        return Database.insert(recordsToInsert, dmlOptions);
    }
 

    /*********************************************************************************************************
    * @description Wraps the Database class update method and defaults the DMLOptions optAllOrNone to false 
    *   and DuplicateRuleHeader.AllowSave to true.
    * @param recordToUpdate The sObject to update in the org.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult updateRecord(sObject recordToUpdate) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = ALL_OR_NONE_TRUE;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.update(recordToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class update method and defaults the DMLOptions optAllOrNone to false 
    *   and DuplicateRuleHeader.AllowSave to true.
    * @param recordsToUpdate The sObjects to update in the org.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> updateRecords(List<sObject> recordsToUpdate) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = ALL_OR_NONE_TRUE;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.update(recordsToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class update method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordToUpdate The sObject to update in the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult updateRecord(sObject recordToUpdate, Boolean allOrNone) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = allOrNone;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.update(recordToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class update method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordsToUpdate The sObjects to update in the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> updateRecords(List<sObject> recordsToUpdate, Boolean allOrNone) {
        Database.DMLOptions dmlOptions = new Database.DMLOptions();
        
        dmlOptions.optAllOrNone = allOrNone;
        dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();

        return Database.update(recordsToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class update method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordToUpdate The sObject to update in the org.
    * @param dmlOptions The optional parameter that specifies additional data for the transaction.
    * @return Database.SaveResult
    **********************************************************************************************************/
    public static Database.SaveResult updateRecord(sObject recordToUpdate, Database.DMLOptions dmlOptions) {
        if (!useAllowSaveProperty(dmlOptions)) {
            dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();
        }

        return Database.update(recordToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class update method and sets the DMLOptions optAllOrNone accordingly 
    *   and defaults DuplicateRuleHeader.AllowSave to true.
    * @param recordsToUpdate The sObjects to update in the org.
    * @param dmlOptions The optional parameter that specifies additional data for the transaction.
    * @return List<Database.SaveResult>
    **********************************************************************************************************/
    public static List<Database.SaveResult> updateRecords(List<sObject> recordsToUpdate, Database.DMLOptions dmlOptions) {
        if (!useAllowSaveProperty(dmlOptions)) {
            dmlOptions.DuplicateRuleHeader.AllowSave = retrieveRespectDuplicateRuleSettings();
        }

        return Database.update(recordsToUpdate, dmlOptions);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class upsert method.
    * @param recordToUpsert The sObject to upsert in the org.
    * @return Database.UpsertResult
    **********************************************************************************************************/
    public static Database.UpsertResult upsertRecord(sObject recordToUpsert) {
        // AllowSave handling not added because Database.upsert(...) does not support Database.DMLOptions
        return Database.upsert(recordToUpsert);
    }

    /*********************************************************************************************************
    * @description Handles the batch DML updates of records combined with error handling.
    * @param records The records to be updated
    * @param context The context ERR_Handler_API enum value for the context in which this operation occurs
    **********************************************************************************************************/
    public static void updateRecordBatchAndLogErrors(List<SObject> records, string context){
        List<Database.SaveResult> srList = Database.update(records, false);

     //   ERR_Handler.Errors errorResult = ERR_Handler.getJobErrors(srList, records, context);
      //  if (errorResult.errorsExist) {
       //     ERR_Handler.processErrors(errorResult.errorRecords, context);
       // }
    }


    /*********************************************************************************************************
    * @description Wraps the Database class upsert method.
    * @param recordsToUpsert The sObjects to upsert in the org.
    * @return List<Database.UpsertResult>
    **********************************************************************************************************/
    public static List<Database.UpsertResult> upsertRecords(List<sObject> recordsToUpsert) {
        // AllowSave handling not added because Database.upsert(...) does not support Database.DMLOptions
        return Database.upsert(recordsToUpsert);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class upsert method and sets the flag to allow partial commits.
    * @param recordToUpsert The sObject to upsert in the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return Database.UpsertResult
    **********************************************************************************************************/
    public static Database.UpsertResult upsertRecord(sObject recordToUpsert, Boolean allOrNone) {
        // AllowSave handling not added because Database.upsert(...) does not support Database.DMLOptions
        return Database.upsert(recordToUpsert, allOrNone);
    }


    /*********************************************************************************************************
    * @description Wraps the Database class upsert method and sets the flag to allow partial commits.
    * @param recordsToUpsert The sObjects to upsert in the org.
    * @param allOrNone The optional parameter that specifies whether the operation allows partial success.
    * @return List<Database.UpsertResult>
    **********************************************************************************************************/
    public static List<Database.UpsertResult> upsertRecords(List<sObject> recordsToUpsert, Boolean allOrNone) {
        // AllowSave handling not added because Database.upsert(...) does not support Database.DMLOptions
        return Database.upsert(recordsToUpsert, allOrNone);
    }


    /*********************************************************************************************************
    * @description Checks if the Allow Save property is set and uses it accordingly.
    * @return Boolean
    **********************************************************************************************************/
    private static Boolean useAllowSaveProperty(Database.DMLOptions dmlOptions) {
        return (dmlOptions.DuplicateRuleHeader.AllowSave != null);
    }


    /*********************************************************************************************************
    * @description Returns the NPSP Setting's Allow Duplicate Records To Be Saved value.
    * @return Boolean
    **********************************************************************************************************/
    private static Boolean retrieveRespectDuplicateRuleSettings() {
        return UTIL_CustomSettingsFacade.getErrorSettings().Respect_Duplicate_Rule_Settings__c;
    }    


}