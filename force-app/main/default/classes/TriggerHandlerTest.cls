/**
 * @description       : 
 * @author            : Sangram Keshari Upadhyaya
 * @group             : 
 * @last modified on  : 30-08-2025
 * @last modified by  : Sangram Keshari Upadhyaya
 * Modifications Log
 * Ver   Date         Author                      Modification
 * 1.0   30-08-2025   Sangram Keshari Upadhyaya   Initial Version
**/
@IsTest
private class TriggerHandlerTest {
    
    @IsTest
    static void testBeforeInsert() {
        Account acc = new Account();
        insert acc;
        
        System.assertNotEquals(null, acc.Id, 'Account should be inserted');
    }
    
    @IsTest
    static void testAfterInsert() {
        List<Account> accList = new List<Account>{
            new Account(Name = 'Test Acc')
        };
        insert accList;
        
        System.assertEquals(1, accList.size(), 'One account should be inserted');
    }
}