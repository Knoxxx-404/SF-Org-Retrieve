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
public with sharing class TestDataFactory {

    public static Account createAccount(String name) {
        Account a = new Account(Name = name);
        insert a;
        return a;
    }

    // New: create without Name (to test defaulting)
    public static Account createAccountWithoutName() {
        Account a = new Account();
        insert a; // trigger should default Name & AccountNumber
        return a;
    }

    // New: create with specific fields
    public static Account createAccountWithFields(String name, String industry, Decimal annualRevenue) {
        Account a = new Account(
            Name = name,
            Industry = industry,
            AnnualRevenue = annualRevenue
        );
        insert a;
        return a;
    }

    // New: bulk factory
    public static List<Account> createAccounts(Integer count) {
        List<Account> listA = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            listA.add(new Account(Name = 'Acc ' + i));
        }
        insert listA;
        return listA;
    }
}