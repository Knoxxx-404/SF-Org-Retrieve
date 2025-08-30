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

public with sharing class TriggerHandler {
    // Optional recursion guard if you later expand to multi-object logic
    private static Boolean isExecuting = false;

    /***********************
     * BEFORE INSERT: Account
     ***********************/
    public void handleBeforeInsertAccounts(List<Account> newList) {
        if (isExecuting) return;
        isExecuting = true;

        Integer seq = 0;
        for (Account a : newList) {
            // Default Name
            if (String.isBlank(a.Name)) {
                a.Name = 'Default Name';
            }
            // Auto AccountNumber if blank
            if (String.isBlank(a.AccountNumber)) {
                seq++;
                a.AccountNumber = 'ACC-' + Datetime.now().getTime() + '-' + seq;
            }
        }
        isExecuting = false;
    }

    /***********************
     * BEFORE UPDATE: Account
     ***********************/
    public void handleBeforeUpdateAccounts(Map<Id, Account> oldMap, List<Account> newList) {
        if (isExecuting) return;
        isExecuting = true;

        Integer seq = 0;
        for (Account a : newList) {
            Account oldRec = oldMap.get(a.Id);

            // Keep Name non-blank (defensive, just in case test/data loader wipes it)
            if (String.isBlank(a.Name)) {
                a.Name = 'Default Name';
            }

            // Auto AccountNumber if blank
            if (String.isBlank(a.AccountNumber)) {
                seq++;
                a.AccountNumber = 'ACC-' + Datetime.now().getTime() + '-' + seq;
            }

            // If Industry just changed to Technology, mark as Hot
            if (oldRec.Industry != 'Technology' && a.Industry == 'Technology') {
                a.Rating = 'Hot';
            }
        }

        isExecuting = false;
    }

    /***********************
     * BEFORE DELETE: Account
     ***********************/
    public void handleBeforeDeleteAccounts(List<Account> oldList) {
        // No recursion risk in before delete
        for (Account a : oldList) {
            if (a.AnnualRevenue != null && a.AnnualRevenue > 1000000) {
                a.addError('Cannot delete high-value account (AnnualRevenue > 1,000,000).');
            }
        }
    }

    /***********************
     * AFTER INSERT: Account
     ***********************/
    public void handleAfterInsertAccounts(List<Account> newList) {
        if (isExecuting) return;
        isExecuting = true;

        List<Task> toCreate = new List<Task>();
        Date due = Date.today().addDays(7);
        for (Account a : newList) {
            toCreate.add(new Task(
                Subject     = 'Welcome Call',
                Status      = 'Not Started',
                Priority    = 'Normal',
                ActivityDate= due,
                WhatId      = a.Id
            ));
        }
        if (!toCreate.isEmpty()) {
            insert toCreate;
        }
        isExecuting = false;
    }
}