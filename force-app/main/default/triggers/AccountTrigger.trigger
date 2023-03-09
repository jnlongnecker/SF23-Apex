/*

    Triggers
        - A trigger is a block of code that is run on some DML event
        - 2 types of triggers
            - before trigger : Records are mutable in before triggers
            - after trigger : Records are READ ONLY in after triggers
        - 7 trigger events
            - before insert
            - before update
            - before delete
            - after insert
            - after update
            - after delete
            - after undelete

*/

// Trigger Best Practice #1: 1 Trigger per object
trigger AccountTrigger on Account(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  /*
        The Trigger class holds a number of variables that define the context
        that the trigger is executing in
            - Trigger.operationType : Enum that defines which event is occuring
            - Trigger.isBefore : Returns true if the type is a before trigger
            - Trigger.isAfter : Returns true if the type is an after trigger
            - Trigger.isInsert : Returns true if the event is an insert
            - Trigger.isUpdate : Returns true if the event is an update
            - Trigger.isDelete : Returns true if the event is a delete
            - Trigger.isUndelete : Returns true if the event is undelete
            - Trigger.new : Returns a list of sObjects holding the records that caused the trigger
            - Trigger.old : Returns a list of sObjects with their prior values
            ------- Less Useful --------
            - Trigger.newMap : Returns a map of sObjects to their Ids
            - Trigger.oldMap : Returns a map of sObjects with their prior values to their Ids
            - Trigger.isExecuting : Returns true if the code is firing from a trigger
    */

  switch on Trigger.operationType {
    when BEFORE_INSERT {
      // Can only use Trigger.new
      // Trigger Best Practice #2: Keep triggers logicless
      AccountHelper.validateAccounts(Trigger.new);
    }
    when BEFORE_UPDATE {
      // Can use Trigger.new or Trigger.old
    }
    when BEFORE_DELETE {
      // Can only use Trigger.old
    }
    when AFTER_INSERT {
      // Can only use Trigger.new
      AccountHelper.addLinkedContacts(Trigger.new);
    }
    when AFTER_UPDATE {
      // Can use Trigger.new or Trigger.old
    }
    when AFTER_DELETE {
      // Can only use Trigger.old
    }
    when AFTER_UNDELETE {
      // Can only use Trigger.new
    }
  }

  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
    } else if (Trigger.isUpdate) {
    } else if (Trigger.isDelete) {
    }
  } else if (Trigger.isAfter) {
    if (Trigger.isInsert) {
    } else if (Trigger.isUpdate) {
    } else if (Trigger.isDelete) {
    } else if (Trigger.isUndelete) {
    }
  }
}
