/**
 * @author Salesforce.org
 * @date 2014
 * @group TDTM
 * @group-content ../../ApexDocContent/TDTM.htm
 * @description Test class for TDTM_Runnable
 *
***/
@isTest
public with sharing class TDTM_Runnable_TEST {

    private static string strTestOnly = '*';
    
    /*************************************************************************** 
    * @description This test verifies that the runFuture method of the TDTM_Runnable class works properly 
    **/
    public static testmethod void testAsync() {
    	if (strTestOnly != '*' && strTestOnly != 'testAsync') return;
    	
    	insert new Trigger_Handler__c(Active__c = true, Asynchronous__c = true, 
              Class__c = 'ERR_ParentAccountUpdater2_TEST', Load_Order__c = 1, Object__c = 'Contact', 
              Trigger_Action__c = 'AfterInsert;');
         
        Account acc = new Account(Name = 'Old Acc Name');
        insert acc;
        
        Contact contact = new Contact(FirstName = 'Old First Name', LastName = 'Testerson', AccountId = acc.Id);
        
        Test.startTest(); 
        insert contact;
        Test.stopTest();
        
        contact = [select FirstName from Contact where Id = :contact.ID];
        acc = [select Name from Account where Id = :acc.Id];
        
        System.assertEquals('New First Name', contact.FirstName); //To verify fields from record are available in future
        System.assertEquals('New Acc Name', acc.Name);
    }
    
    /*************************************************************************** 
    * @description Test we do not get the "Cannot have more than 10 chunks in a single operation. Please rearrange the data to 
    * reduce chunking" error. 
    * If you comment out the first line in the method groupSObjects of TDTM_Runnable this test fails.
    **/
    public static testmethod void nochunking() {
    	if (strTestOnly != '*' && strTestOnly != 'nochunking') return;
    	
    	   
    	List<Contact> contacts = new List<Contact>();
		for(integer i = 0; i< 200; i++) {
		    Contact contact = new contact(firstname='Test', lastname='Person' + i);
		    contact.MailingStreet = 'multiple-address';
		    contact.MailingCity = 'Cupertino';
		    contact.MailingState = 'California';
		    contact.MailingPostalCode = '95014';
		    contact.MailingCountry = 'United States';
		    contacts.add(contact);
		}
		
		Test.startTest();
		insert contacts;
		Test.stopTest();
		
		Integer errors = [select count() from Error__c];
		list<Error__c> listErr = [select Full_Message__c, Object_Type__c, Record_URL__c from Error__c];
		system.debug('**** listErr: ' + listErr);
		System.assertEquals(0, errors);
    }
}
