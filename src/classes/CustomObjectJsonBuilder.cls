// Every JSON builder should be extended from pandadoc.JsonBuilder class. Also this class should be global.
global with sharing class CustomObjectJsonBuilder extends pandadoc.JsonBuilder {
    // Constructor without parameters is required
    global CustomObjectJsonBuilder() {
        //Here we call pandadoc.JsonBuilder constructor. First parameter is required. It should be a SObject type.
        super(PD_Custom_Object__c.getSObjectType(), null, null);
    }
    // Here we forming PricingItems
    global override pandadoc.Item[] getItems(sObject record) {
        //sObjectName used in lowercase
        String sObjectName = 'Custom_Object_Child__c'.toLowerCase();
        //now we have mapping setting for PricingItem
        pandadoc.Item.ItemSettings setting = pandadoc.Item.PRICING_ITEM_SETTINGS_MAP.get(sObjectName);
        //here we forming list with SOQL fields.
        String[] childFieldsList = new List<String>(setting.getSoqlFields());
        String childFieldsStr = String.join(childFieldsList, ',');

        String query = String.format(
          'SELECT {0} FROM Custom_Object_Child__c WHERE Custom_Object__c = \'\'{1}\'\'',
            new String[] {childFieldsStr, record.Id}
        );

        //forms PricingItems
        sObject[] sObjects = Database.query(query);
        pandadoc.Item[] result = new pandadoc.Item[]{};
        for (sObject rawObject: sObjects) {
            pandadoc.Item newItem = pandadoc.Item.sObjectToItem(rawObject);
            result.add(newItem);
        }
        return result;
    }
    // Here we should form Recipients. But currently we don't do that
    global override pandadoc.Recipient[] getRecipients(sObject record) {
        return null;
    }
}