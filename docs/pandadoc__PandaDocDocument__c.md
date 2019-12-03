# PandaDoc Document

Technical SObject which is used to represent PandaDoc document in SFDC. Primarily used for implementing event handlers and storing historical data. API name: `pandadoc__PandaDocDocument__c`.

## Fields
- `pandadoc__Account__c`: `Lookup(Account)`: Relation to Account. Has a value if the document is linked to Account. Empty otherwise.
- `pandadoc__Contact__c`: `Lookup(Contact)`: Relation to Contact. Has a value if the document is linked to Contact. Empty otherwise.
- `pandadoc__Lead__c'`: `Lookup(Lead)`: Relation to Lead. Has a value if the document is linked to Lead. Empty otherwise.
- `pandadoc__Opportunity__c`: `Lookup(Opportunity)`: Relation to Opportunity. Has value if the document is linked to Opportunity. Empty otherwise.
- `pandadoc__Custom_Object_Id__c`: `Text(18)`: String representation of SObject id which was used to create a document. 
- `pandadoc__InputJSON__c`: `Long Text Area(131072)`: JSON payload of document. Used for documents created in Editor V1 Only
- `pandadoc__InputJSON_EV2__c`: `Long Text Area(131072)`: JSON payload of document. Used for documents created in Editor V2 Only
- `pandadoc__Is_Deleted__c`: `Checkbox`: true if this document was deleted on PandaDoc side
- `pandadoc__ParentId__c`: `Formula (Text)`: Formula which always represents correct ID to linked SObject
-  `pandadoc__Status__c`: `Text(255)`: Document status. Possible values:
    - `document.draft`
    - `document.sent`
    - `document.completed`
    - `document.viewed`
    - `document.waiting_approval`
    - `document.rejected`
    - `document.approved`
    - `document.waiting_pay`
    - `document.paid`
    - `document.expired`
    - `document.declined`
- `pandadoc__UUID__c`: `Text(30)`: PandaDoc ID.
- `Name`: `Text(80)`: Document name as in PandaDoc application. NOTE:
if document name is longer than 80 characters then name be truncated. You can use document name through [DocumentWrapper](DocumentWrapper.md) also.
