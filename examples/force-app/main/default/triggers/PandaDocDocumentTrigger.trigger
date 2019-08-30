trigger PandaDocDocumentTrigger on pandadoc__PandaDocDocument__c (after insert, after update) {
    pandadoc.TriggerTemplate.TriggerManager triggerManager = new pandadoc.TriggerTemplate.TriggerManager();

    if (pandadoc.TriggerManager.isTriggerEnabled(DocumentHandler.TRIGGER_NAME)) {
        triggerManager.addHandler(
            new DocumentHandler(),
            new pandadoc.TriggerTemplate.TriggerAction[] {
                pandadoc.TriggerTemplate.TriggerAction.afterupdate,
                pandadoc.TriggerTemplate.TriggerAction.afterinsert
            }
        );
    }
    triggerManager.runHandlers();
}