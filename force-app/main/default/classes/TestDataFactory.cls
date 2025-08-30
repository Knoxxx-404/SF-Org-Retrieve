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
    
    // Existing method
    public static Account createAccount(String name) {
        Account acc = new Account(Name = name);
        insert acc;
        return acc;
    }
    
    // Newly added method (Modification)
    public static Contact createContact(String firstName, String lastName, Id accountId) {
        Contact con = new Contact(
            FirstName = firstName,
            LastName  = lastName,
            AccountId = accountId
        );
        insert con;
        return con;
    }
}