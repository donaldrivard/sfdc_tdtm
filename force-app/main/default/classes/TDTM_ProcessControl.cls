/**
 * @author Salesforce.org
 * @date 2017
 * @group TDTM
 * @group-content ../../ApexDocContent/TDTM.htm
 * @description Primary class for recursion process control logic shared across all TDTM classes
 *
***/
public class TDTM_ProcessControl {

    /*******************************************************************************************************
    * @description Enum to define the various recursion prevention types used by all the related TDTM classes
    * Address Triggers:
    * - ADDR: Prevent commom recursion through most of the ADDR triggers
    * - ADDR_hasRunValidation: Prevent recursion specifically in the Address Validation/Verification related triggers
    * - ADDR_hasRunContactOnBefore: Prevent the AfterUpdate trigger on the Contact from processing changes
    *       to the Contact's address that are being made by this BeforeUpdate trigger. Only used by ADDR_Contact_TDTM.
    * Affiliation Triggers
    * - AFFL_doNotRunForContacts: Prevent execution for all Affiliation trigger on the Contact object
    * - AFFL_hasRunForAffiliations: Prevent recursion for Affiliations on the Affiliation object
    * - AFFL_hasRunForAccounts: Prevent recursion for Affiliation on the Account object
    * Allocation Triggers:
    * - ALLOC
    * Household Triggers:
    * - HH
    * OPP Triggers:
    * - OPP_CampaignMember: Control recursion specifically for the OPP_CampaignMember_TDTM class
    * Recuring Donations Triggers:
    * - RD
    * Relationships Triggers:
    * - REL
    */
    public enum flag {
        ADDR_hasRunTrigger,
        ADDR_hasRunContactOnBefore,
        ADDR_hasRunValidation,
        AFFL_doNotRunForContacts,
        AFFL_hasRunForAffiliations,
        AFFL_hasRunForAccounts,
        ALLOC,
        HH,
        OPP_CampaignMember,
        RD,
        REL,
        CascadeDeletes
    }

    /*******************************************************************************************************
    * @description Map to track the specific recursion type status
    */
    private static Map<flag, Integer> recursionMap = new Map<flag, Integer>();

    /*******************************************************************************************************
    * @description Increment/Decrement the static flag counter that tracks whether the processing
    *    trigger has been called already
    * @param b A boolean where true increments the counter and false decrements it.
    * @return void This method modifies class variables and doesn't return anything.
    ********************************************************************************************************/
    public static void setRecursionFlag(flag f, boolean b) {
        Integer recursionFlag = (recursionMap.containsKey(f) ? recursionMap.get(f) : 0);
        recursionFlag += (b ? 1 : -1);
        if (recursionFlag < 0) {
            recursionFlag = 0;
        }
        recursionMap.put(f, recursionFlag);
    }

    /********************************************************************************************************
    * @description Returns true if the recursionFlag value is greater than 1
    */
    public static Boolean isRecursive(flag f) {
        return (recursionMap.containsKey(f) ? recursionMap.get(f) : 0) > 0;
    }

    /*******************************************************************************************************
    * @description Modifies the global static collection of Trigger_Handler records to disable or enable
    * a specific TriggerHander by SObjectName and ApexClass name.
    * @param objName SObject Name
    * @param className Apex Class Name
    * @param state True (enable) | False (disable)
    */
    public static void toggleTriggerState(String objName, String className, Boolean state) {
        List<Trigger_Handler__c> triggerHandlers = TDTM_Config_API.getCachedRecords();
        for (Trigger_Handler__c th : triggerHandlers) {
            if (th.Object__c == objName && th.Class__c == className) {
                th.Active__c = state;
            }
        }
    }
}