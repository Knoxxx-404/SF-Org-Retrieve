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
trigger AccountTrigger on Account (before insert, before update, before delete, after insert) {
    TriggerHandler h = new TriggerHandler();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) h.handleBeforeInsertAccounts(Trigger.new);
        if (Trigger.isUpdate) h.handleBeforeUpdateAccounts(Trigger.oldMap, Trigger.new);
        if (Trigger.isDelete) h.handleBeforeDeleteAccounts(Trigger.old);
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) h.handleAfterInsertAccounts(Trigger.new);
    }
}