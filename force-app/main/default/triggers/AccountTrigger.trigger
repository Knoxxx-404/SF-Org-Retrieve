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
trigger AccountTrigger on Account (before insert, after insert) {
    TriggerHandler handler = new TriggerHandler();
    
    if (Trigger.isBefore && Trigger.isInsert) {
        handler.handleBeforeInsert(Trigger.new);
    }
    
    if (Trigger.isAfter && Trigger.isInsert) {
        handler.handleAfterInsert(Trigger.new);
    }
}