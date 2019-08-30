public with sharing class DocumentHandler implements pandadoc.TriggerTemplate.Handler {
    public final static String TRIGGER_NAME = 'DocumentHandler';

    private pandadoc__PandaDocDocument__c newValue;

    public void setValues(SObject[] newValues, Map<Id, SObject> oldValues) {
        // we are simplified this moment but in production please use bulkify approach
        this.newValue = (pandadoc__PandaDocDocument__c)newValues[0];
    }

    public void handle(pandadoc.TriggerTemplate.TriggerAction action) {
        if (newValue.pandadoc__Opportunity__c == null) {
            return;
        }

        pandadoc.DocumentWrapper wrapper = pandadoc.DocumentWrapper.parseFromJson(
            newValue.pandadoc__InputJSON__c)[0];

        upsertLineItems(wrapper.data.products);
    }

    private void upsertLineItems(pandadoc.DocumentWrapper.DocumentProducts[] products) {
        OpportunityLineItem[] result = new OpportunityLineItem[]{};

        for (pandadoc.DocumentWrapper.DocumentProducts docProduct: products) {
            String lineId = (String)docProduct.custom_fields.get('Id');
            if (String.isBlank(lineId)) {
                continue; // Line item not from SF
            }

            OpportunityLineItem newOppLineItem = new OpportunityLineItem(
                Id=lineId,
                Quantity=docProduct.qty,
                UnitPrice=Decimal.valueOf(docProduct.price));

            result.add(newOppLineItem);
        }

        upsert result;
    }
}