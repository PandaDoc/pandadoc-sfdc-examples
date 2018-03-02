// Every JSON builder should be extended from pandadoc.JsonBuilder class. Also this class should be global.
global with sharing class CustomObjectJsonBuilder extends pandadoc.JsonBuilder {

    // Constructor without parameters is required
    global CustomObjectJsonBuilder() {
        //Here we call pandadoc.JsonBuilder constructor. First parameter is required. It should be a SObject type.
        super(PD_Custom_Object__c.getSObjectType(), null, null);
    }
    // Here we should form Pricing Items for pricing tables. But currently we don't do that
    global override pandadoc.Item[] getItems(sObject record) {
        return null;
    }
    // Here we should form Recipients. But currently we don't do that
    global override pandadoc.Recipient[] getRecipients(sObject record) {
        return null;
    }
}