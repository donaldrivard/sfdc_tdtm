global class TDTM_Config_API {

    /*******************************************************************************************************
    * @description Returns the default TDTM configuration. 
    * @return List<Trigger_Handler__c> a list of trigger handler records with the default values. The records
    * have not yet been inserted in the database. You can manipulate them, if necessary, and insert 
    * them. If no Trigger_Handler__c records exist, the application will insert the defaults when any 
    * of the NPSP triggers run. 
    */
    global static List<Trigger_Handler__c> getDefaultRecords() {
        return TDTM_DefaultConfig.getDefaultRecords(); 
    }

    /*******************************************************************************************************
    * @description Returns the list of current cached trigger handler records
    * @return List<Trigger_Handler__c> a list of cached trigger handler records with current values.  SI's
    * may modify this list in the current execution context to temporarily change the functionality of
    * tdtm triggers - disable triggers, enable triggers, or even add a new row to the collection
    * that is not committed to the database.
    */
    global static List<Trigger_Handler__c> getCachedRecords() {
        // need to handle scenario where this is called before any DML has occurred that would set the
        // initial defaults records (ie, in tests).
        if (Test.isRunningTest() && TDTM_ObjectDataGateway.listTH.isEmpty()) {
            insert getDefaultRecords();
            // reset listTH to null so it will get refilled in the correct sort order
            TDTM_ObjectDataGateway.listTH = null;
        }
        return TDTM_ObjectDataGateway.listTH;
    }

    /*******************************************************************************************************
    * @description Method to be called from each of the triggers (only one per object) that follow the TDTM 
    * design. Figures out which classes need to be called, and calls them.
    * @param isBefore Are we in a before trigger context.
    * @param isAfter Are we in an after trigger context.
    * @param isInsert Did the trigger run in response to an insert operation.
    * @param isUpdate Did the trigger run in response to an update operation.
    * @param isDelete Did the trigger run in response to a delete operation.
    * @param isUnDelete Did the trigger run in response to an undelete operation.
    * @param newList The records that were passed to the trigger as trigger.new.
    * @param oldList The records that were passed to the trigger as trigger.old.
    * @param describeObj The type of SObject the class runs for.
    * @return void
    */
    global static void run(Boolean isBefore, Boolean isAfter, Boolean isInsert, Boolean isUpdate,
    Boolean isDelete, Boolean isUnDelete, List<SObject> newList, List<SObject> oldList, 
    Schema.DescribeSObjectResult describeObj) {
        TDTM_TriggerHandler.run(isBefore, isAfter, isInsert, isUpdate, isDelete, isUnDelete, newList, oldList, describeObj, new TDTM_ObjectDataGateway());
    }

    /**
     * @description Method to disable all NPSP roll-up triggers for the current code execution context.
     */
    @InvocableMethod(Label='Disable NPSP Rollup Triggers')
    global static void disableAllRollupTriggers() {
        TDTM_ProcessControl.toggleTriggerState('Opportunity', 'RLLP_OppRollup_TDTM', false);
        TDTM_ProcessControl.toggleTriggerState('Opportunity', 'CRLP_Rollup_TDTM', false);
        TDTM_ProcessControl.toggleTriggerState('npe01__OppPayment__c', 'CRLP_Rollup_TDTM', false);
        TDTM_ProcessControl.toggleTriggerState('Allocation__c', 'CRLP_Rollup_TDTM', false);
    }

}