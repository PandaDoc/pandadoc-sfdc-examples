global with sharing class CustomRecipients extends pandadoc.JsonBuilder {
    public CustomRecipients() {
        super(CustomObject__c.getSObjectType(), null);
    }
    public override pandadoc.Item[] getItems(SObject record) {
        return null;
    }

    public override pandadoc.Recipient[] getRecipients(SObject record) {
        pandadoc.Recipient[] result = new pandadoc.Recipient[]{};

        pandadoc.Recipient userRecipient = getObjectContact(record.Id);
        if (userRecipient != null) {
            result.add(userRecipient);
        }
        pandadoc.Recipient predefinedRecipient = getPredefinedRecipient();
        result.add(predefinedRecipient);

        return result;
    }

    private pandadoc.Recipient getObjectContact(Id objectId) {
        Id contactId = [SELECT Contact__c FROM CustomObject__c WHERE Id = :objectId].Contact__c;

        if (contactId == null) {
            return null;
        }

        pandadoc.Recipient.RecipientSettings mappingRules = pandadoc.Recipient.RECIPIENT_SETTINGS_MAP.get('contact');
        if (mappingRules == null) {
            return null;
        }

        Set<String> contactRecipientsFields = mappingRules.getSoqlFields();
        String contactFieldsStr = String.join(new List<String>(contactRecipientsFields), ',');

        String contactSoql = String.format(
            'SELECT {0} FROM Contact WHERE Id = \'\'{1}\'\'',
            new String[] { contactFieldsStr, contactId });
        
        SObject objectContact = Database.query(contactSoql)[0];

        return new pandadoc.Recipient (mappingRules, objectContact);
    }

    private pandadoc.Recipient getPredefinedRecipient() {
        return new pandadoc.Recipient(
            'first_name',
            'last_name',
            'email@email.com',
            'company',
            'roleName');
    }
}