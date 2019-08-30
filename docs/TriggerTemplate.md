# TriggerTemplate

Class for working with PandaDoc trigger handlers

# Handler

Base interface which should be implemented by all trigger handlers.

## Methods
- `void setValues(List<SObject> newValues, Map<Id, SObject> oldValues)`: This method takes Trigger.new and Trigger.oldMap values. Class should save this values internaly.
- `void handle(TriggerTemplate.TriggerAction param0)`: Main handler method. Takes single argument with action type. See [TriggerAction](#TriggerAction)

# TriggerAction
Enum with possible values:
- `afterdelete`
- `afterinsert`
- `afterundelete`
- `afterupdate`
- `beforedelete`
- `beforeinsert`
- `beforeupdate`