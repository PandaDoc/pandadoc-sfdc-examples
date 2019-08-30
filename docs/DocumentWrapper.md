# DocumentWrapper

Parse PandaDoc document JSON payload and provide simple API for access to document data

## Methods

- `static List<DocumentWrapper> parseFromJson(String jsonData)`: Used for fill document data from JSON string.
        
        pandadoc.DocumentWrapper wrapper = pandadoc.DocumentWrapper.parseFromJson(
            newValue.pandadoc__InputJSON__c)[0];

## Variables
- `global String event`: last event for this document. Possible values:
    - `document_state_changed`: document status was changed or new document created. You got this event every time when document was sent\paid\approved\etc
    - `recipient_completed`: some recipient filled all required input fields for him
    - `document_deleted`: document was deleted in PandaDoc
    - `document_updated`: document moved to draft status after sending or completing. New document version was generated
- `global DocumentWrapper.DocumentData data`: document data wrapper. See [DocumentData](#DocumentWrapper.DocumentData) 


# DocumentWrapper.DocumentData

Represents PandaDoc document data 

## Variables
- `global DocumentWrapper.DocumentPerson action_by`: available only for `recipient_completed` event. Represent recipient who filled document data. Equal to `null` otherwise. See [DocumentPerson](#DocumentWrapper.DocumentPerson)
- `global DocumentWrapper.PandaDocUser created_by`: PandaDoc user who created this document. See [PandaDocUser](#DocumentWrapper.PandaDocUser)
- `global Datetime date_created`: when document was created
- `global Datetime date_modified`: when document was changed
- `global String id`: PandaDoc document Id
- `global Map<String, String> metadata`: document metadata
- `global String name`: document name
- `global List<DocumentWrapper.DocumentProducts> products`: list of document pricing items. See [DocumentProducts](#DocumentWrapper.DocumentProducts)
- `global List<DocumentWrapper.DocumentRecipient> recipients`: list of document recipients. See  [DocumentRecipient](#DocumentWrapper.DocumentRecipient)
- `global DocumentWrapper.PandaDocUser sent_by`: PandaDoc user who sent this document.
- `global String status`: Document status on PandaDoc side. Possible values:
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


# DocumentWrapper.DocumentPerson
Base class for all persons(user\recipient)
- `global String email`: email
- `global String first_name`:  first name
- `global String last_name`: last name
- `global String id`: PandaDoc id

# DocumentWrapper.PandaDocUser
Extends from [DocumentPerson](#DocumentWrapper.DocumentPerson) and have all fields from parent.
- `global String avatar`: url to user avatar image

# DocumentWrapper.DocumentRecipient
Extends from [DocumentPerson](#DocumentWrapper.DocumentPerson) and have all fields from parent.
- `global Boolean has_completed`: `true` if this recipient already completed this document
- `global String recipient_type`: possible values:
    - `signer`: this recipient have assigned input field
    - `CC`: this recipient has no any assigned input field
- `global String role `: recipient role name

# DocumentWrapper.DocumentProducts
- `global String sku`: product sku
- `global Map<String, Object> custom_fields`: here you will get all fields which was selected on the "Configure Tokens" page for this Product type. For example by default there is selected the "Id" field for `OpportunityLineItem` object. Please note if field value equal to 'null' then this value does not been added here Dictionary just would not have this key.
- `global Map<String, Object> custom_columns`: here you will get all custom columns which was added in PandaDoc UI.
- `global String description`: product description. 
- `global DocumentWrapper.Discount discount`: product discount. Should be in percents. Please see [Discount](#Discount).
- `global String name`: product name
- `global String price`: string representation of product price per unit
- `global Integer qty`: items quantity
- `global String subtotal`: (price * qty) - discount

# Discount
represents discount
- `global String type`: currently always equals to `percent`
- `global String value`: string representation of discount size
