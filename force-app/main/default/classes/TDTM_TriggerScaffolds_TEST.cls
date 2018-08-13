/**
 * @author Salesforce.org
 * @date 2014
 * @group TDTM
 * @group-content ../../ApexDocContent/TDTM.htm
 * @description Test class to provide coverage for TDTM triggers on objects for which there are currently no TDTM classes. 
 *
***/

@isTest
public with sharing class TDTM_TriggerScaffolds_TEST {

    /*************************************************************************** 
    * @description Currently we don't have any Trigger_Handler__c record for Lead. This test is 
    * just for test coverage, and to verify no exception gets thrown.
    **/
    public static testmethod void tdtmLead() {
    	insert new Lead(Company = 'Pencil Makers', LastName = 'Smith');
    	
    	System.assert(true); //Just checking that we get to this point = no exception thrown
    }
    
    /*************************************************************************** 
    * @description Currently we don't have any Trigger_Handler__c record for Campaign. This test is 
    * just for test coverage, and to verify no exception gets thrown.
    **/
    public static testmethod void tdtmCampaign() {
        insert new Campaign(Name = 'Make Us Famous');
        
        System.assert(true); //Just checking that we get to this point = no exception thrown 
    }
}
