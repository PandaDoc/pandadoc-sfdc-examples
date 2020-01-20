# JSONBuilder

Base class for all custom JSON builders. JSON Builders are used to pass data from Salesforce into PandaDoc. [Here](../README.md#custom-json-builder-examples) you can find more examples.

# Methods
- `global virtual Map<String, Object> getAttributes(SObject record)`: By default, returns tokens that were selected on `Configure Tokens` page. Can be overridden.
- `global virtual String getDocName(SObject record)`: By default returns document name which was selected on PandaDoc setup page. Can be overridden
- `global abstract List<Item> getItems(SObject param0)`: This method should return Pricing Items for Document. Must be implemented.
- `global abstract List<Recipient> getRecipients(SObject param0)`: This method should return Recipients for Document. Must be implemented. 
- `global virtual Map<String, String> getPandaDocMetadata(Id recordId, SObject record)`: Generates document metadata. By default returns metadata to link PandaDoc document and SFDC SObject.

>PLEASE NOTE: **Link between SFDC and PandaDoc document via metadata was deprecated. Metadata contains SOBject data only for backward capability with old third party triggers**

- `global virtual SourceNode getSourceNode(SObject record)`: Generates relation between SFDC SObject and PandaDoc document. By default generate single link for `record`.
