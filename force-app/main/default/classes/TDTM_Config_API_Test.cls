/**
 * @author Salesforce.org
 * @date 2017
 * @group TDTM
 * @group-content ../../ApexDocContent/TDTM.htm
 * @description Test class for TDTM_Config_API Class and enabling TDTM control for SI's
 *
***/
@isTest
private class TDTM_Config_API_Test {

    /*********************************************************************************************************
    * @description Test that an individual trigger can be disabled in the current code execution context
    */
    @isTest
    static void test_disable_trigger_in_context() {
        //skip the test if Advancement is installed
                
        TDTM_DefaultConfig.startTestDataInit();
        Test.startTest();

        Contact con1 = new Contact(LastName='foo');
        insert con1;
        con1 = [SELECT AccountId FROM Contact WHERE Id = :con1.Id LIMIT 1];
        system.assertNotEquals(null, con1.AccountId, 'there should be an account id associated with this new contact');

        // disable the trigger that creates a new Household Account for the Contact
        List<Trigger_Handler__c> handlers = TDTM_Config_API.getCachedRecords();
        for (Trigger_Handler__c th : handlers) {
            if (th.Object__c == 'Contact' && th.Class__c == 'ACCT_IndividualAccounts_TDTM') {
                th.Active__c = false;
            }
        }

        Contact con2 = new Contact(LastName='foo');
        insert con2;
        con2 = [SELECT AccountId FROM Contact WHERE Id = :con2.Id LIMIT 1];
        system.assertEquals(null, con2.AccountId, 'there should NOT be an account id associated with this new contact');

        Test.stopTest();
    }

    /*********************************************************************************************************
    * @description Test that an individual trigger can be disabled permanently for a specified Username
    */
    @isTest
    static void test_disable_for_specific_user() {
        //skip the test if Advancement is installed
       // if(ADV_PackageInfo_SVC.useAdv()) return;

        // disable this one trigger
        List<Trigger_Handler__c> handlers = TDTM_Config_API.getDefaultRecords();
        for (Trigger_Handler__c th : handlers) {
            if (th.Object__c == 'Contact' && th.Class__c == 'ACCT_IndividualAccounts_TDTM') {
                th.Usernames_to_Exclude__c = UserInfo.getUserName();
            }
        }
        insert handlers;

        Contact con = new Contact(LastName='foo');
        insert con;
        con = [SELECT AccountId FROM Contact WHERE Id = :con.Id LIMIT 1];
        system.assertEquals(null, con.AccountId, 'there should not be an account id associated with this new contact');
    }
    
}
