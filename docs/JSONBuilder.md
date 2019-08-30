# JSONBuilder

Base class for all custom JSON builders. JSON Builders using for passing data from Salesforce into PandaDoc. See examples [here](../README.md#custom-json-builder-examples)


# Methods
- `global virtual Map<String, Object> getAttributes(SObject record)`: By default returns tokens which was selected on `Configure Tokens` page. Can be overridden
- `global virtual String getDocName(SObject record)`: By default returns document name which was selected on PandaDoc setup page. Can be overridden
- `global abstract List<Item> getItems(SObject param0)`: This method should return Pricing Items for Document. Must be implemented.
- `global abstract List<Recipient> getRecipients(SObject param0)`: This method should return Recipients for Document. Must be implemented. 
- `global virtual Map<String, String> getPandaDocMetadata(Id recordId, SObject record)`: Generates document metadata. By default returns metadata for linking PandaDoc document and SFDC SObject. PLEASE NOTE: **Linking between SFDC and PandaDoc document via metadata will be deprecated soon.**
