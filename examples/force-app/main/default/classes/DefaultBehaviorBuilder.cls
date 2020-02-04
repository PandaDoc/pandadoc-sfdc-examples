global with sharing class DefaultBehaviorBuilder extends pandadoc.JsonBuilder {
    private pandadoc.StandardJsonBuilder defaultBuilder;

    public DefaultBehaviorBuilder() {
        super(CustomObject__c.getSObjectType(), null);
        pandadoc__PandaDoc_JsonBulder_Mapping__c builderSetting = pandadoc__PandaDoc_JsonBulder_Mapping__c.getValues(
            CustomObject__c.getSObjectType().getDescribe().getName()
        );
        defaultBuilder = new pandadoc.StandardJsonBuilder(CustomObject__c.getSObjectType(), builderSetting);
    }

    public override pandadoc.Item[] getItems(SObject record) {
        return defaultBuilder.getItems(record);
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        pandadoc.Recipient[] result = defaultBuilder.getRecipients(record); // all default values 
        result.add(new pandadoc.Recipient('first_name', 'last_name', 'hardcoded@email.com', 'company', 'role'));
        return result;
    }
}
