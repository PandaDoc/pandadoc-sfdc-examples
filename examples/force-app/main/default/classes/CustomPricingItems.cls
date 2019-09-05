global with sharing class CustomPricingItems extends pandadoc.JsonBuilder {
    public CustomPricingItems() {
        super(CustomObject__c.getSObjectType(), null);
    }

    public override pandadoc.Item[] getItems(SObject record) {
        pandadoc.Item[] result = new pandadoc.Item[]{};

        pandadoc.Item relatedProductItem = getRelatedProductItem(record.Id);
        pandadoc.Item predefinedItem = getPredefinedItem();

        if (relatedProductItem != null) {
            result.add(relatedProductItem);
        }
        result.add(predefinedItem);

        return result;
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        return null;
    }

    private pandadoc.Item getRelatedProductItem(Id objectId) {
        Id productId = [SELECT Product__c FROM CustomObject__c WHERE Id = :objectId].Product__c;

        if (productId == null) {
            return null;
        }

        pandadoc.Item.ItemSettings mappingRules = pandadoc.Item.PRICING_ITEM_SETTINGS_MAP.get('product2');

        if (mappingRules == null) {
            return null;
        }

        Set<String> itemFields = mappingRules.getSoqlFields();
        String itemFieldsStr = String.join(new List<String>(itemFields), ',');

        String itemSoql = String.format(
            'SELECT {0} FROM Product2 WHERE Id = \'\'{1}\'\'',
            new String[]{itemFieldsStr, productId}
        );

        SObject itemObject = Database.query(itemSoql)[0];
        return new pandadoc.Item(mappingRules, itemObject);
    }

    private pandadoc.Item getPredefinedItem() {
        return new pandadoc.Item('sku', 'name', 10.0, 25, 'description');
    }
}