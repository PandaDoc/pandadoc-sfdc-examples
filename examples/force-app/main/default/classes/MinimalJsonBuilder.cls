global with sharing class MinimalJsonBuilder extends pandadoc.JsonBuilder {
    public MinimalJsonBuilder() {
        super(CustomObject__c.getSObjectType(), null);
    }

    public override pandadoc.Item[] getItems(SObject record) {
        return null;
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        return null;
    }
}