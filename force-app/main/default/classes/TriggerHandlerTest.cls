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
    static void testBeforeInsert_Defaults() {
        // No Name on purpose -> should get default Name + AccountNumber
        Account a = new Account();
        insert a;

        Account got = [SELECT Name, AccountNumber FROM Account WHERE Id = :a.Id];
        System.assertEquals('Default Name', got.Name, 'Default Name should be applied.');
        System.assertNotEquals(null, got.AccountNumber, 'AccountNumber should be generated.');
        System.assert(got.AccountNumber.startsWith('ACC-'), 'AccountNumber must start with ACC-.');
    }

    @IsTest
    static void testAfterInsert_TaskCreated() {
        Account a = new Account(Name = 'Task Me');
        insert a;

        Task t = [SELECT Id, Subject, WhatId, Status FROM Task WHERE WhatId = :a.Id LIMIT 1];
        System.assertEquals('Welcome Call', t.Subject);
        System.assertEquals('Not Started', t.Status);
        System.assertEquals(a.Id, t.WhatId);
    }

    @IsTest
    static void testBeforeUpdate_IndustrySetsRating() {
        Account a = new Account(Name = 'Industry Test', Industry = 'Finance');
        insert a;

        a.Industry = 'Technology';
        update a;

        Account got = [SELECT Industry, Rating FROM Account WHERE Id = :a.Id];
        System.assertEquals('Technology', got.Industry);
        System.assertEquals('Hot', got.Rating, 'Rating should become Hot when Industry -> Technology.');
    }

    @IsTest
    static void testBeforeDelete_BlocksHighValue() {
        Account a = new Account(Name = 'Whale Co', AnnualRevenue = 2000000);
        insert a;

        Test.startTest();
        try {
            delete a;
            System.assert(false, 'Delete should have been blocked.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Cannot delete high-value account'),
                'Expected high-value delete block message.');
        }
        Test.stopTest();
    }

    @IsTest
    static void testBulkSafety_Insert() {
        List<Account> many = new List<Account>();
        for (Integer i = 0; i < 205; i++) {
            many.add(new Account()); // blank names -> default
        }
        insert many;

        Integer withDefaultNames = [SELECT Count() FROM Account WHERE Name = 'Default Name' AND Id IN :many];
        System.assertEquals(205, withDefaultNames, 'All should have default Name in bulk insert.');
    }
}