global with sharing class CustomRelation extends pandadoc.JsonBuilder {
    public CustomRelation() {
        super(CustomObject__c.getSObjectType(), null);
    }

    public override pandadoc.Item[] getItems(SObject record) {
        return null;
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        return null;
    }

    public override pandadoc.SourceNode getSourceNode(SObject record) {
        CustomObject__c customObject = [SELECT Id, Contact__c FROM CustomObject__c WHERE Id = :record.Id]; // Reselect needed because no guarantee that Contact__c field was selected

        String objectType = CustomObject__c.getSObjectType().getDescribe().getName().toLowerCase(); // Lower case is important
        String objectId = customObject.Id;

        pandadoc.SourceNode result = new pandadoc.SourceNode(objectType, objectId);
        
        if (customObject.Contact__c != null) { // If custom object have contact then document be shown on Contact page too
            String contactType = Contact.getSObjectType().getDescribe().getName().toLowerCase();
            String contactId = customObject.Contact__c;
            result.addChild(contactType, contactId);
        }

        return result;
    }
}
