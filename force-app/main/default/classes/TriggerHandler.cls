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
    public void handleBeforeInsert(List<SObject> newList) {
        for (SObject obj : newList) {
            if (obj.get('Name') == null) obj.put('Name', 'Default Name');
        }
    }
    public void handleAfterInsert(List<SObject> newList) {
        System.debug('Records inserted: ' + newList.size());
    }
}
