global with sharing class ExtraTokens extends pandadoc.JsonBuilder {
    public ExtraTokens() {
        super(CustomObject__c.getSObjectType(), null);
    }

    public override pandadoc.Item[] getItems(SObject record) {
        return null;
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        return null;
    }

    public override Map<String, Object> getAttributes(SObject record) {
        Map<String, Object> result = super.getAttributes(record);
        result.put('CurrentUserId', UserInfo.getUserId());
        result.put('CurrentDate', Date.today());
        result.put('UltimateAnswer', 42);
        return result;
    }
}