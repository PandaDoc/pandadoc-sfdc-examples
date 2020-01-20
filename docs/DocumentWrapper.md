# DocumentWrapper

Parse PandaDoc document JSON payload and provide simple API to access document data

## Methods

- `static List<DocumentWrapper> parseFromJson(String jsonData)`: Used to fill in document data from JSON string.

        pandadoc.DocumentWrapper wrapper = pandadoc.DocumentWrapper.parseFromJson(
            newValue.pandadoc__InputJSON__c)[0];

## Variables
- `global String event`: last event for this document. Possible values:
    - `document_state_changed`: document status was changed or new document was created. You get this event every time a document is sent\paid\approved\etc
    - `recipient_completed`: a recipient filled all required input fields
    - `document_deleted`: document was deleted in PandaDoc application
    - `document_updated`: sent or completed document was edited (moved to draft status). New document version was generated.
- `global DocumentWrapper.DocumentData data`: document data wrapper. See [DocumentData](#documentwrapperdocumentdata)


# DocumentWrapper.DocumentData

Represents PandaDoc document data

## Variables
- `global DocumentWrapper.DocumentPerson action_by`: available only for `recipient_completed` event. Represents a recipient who filled in document data. Equal to `null` otherwise. See [DocumentPerson](#documentwrapperdocumentperson)
- `global DocumentWrapper.PandaDocUser created_by`: PandaDoc user who created the document. See [PandaDocUser](#documentwrapperpandadocuser)
- `global Datetime date_created`: when document was created
- `global Datetime date_modified`: when document was edited
- `global String id`: PandaDoc document Id
- `global Map<String, String> metadata`: document metadata
- `global SourceNode source_node`: link between PandaDoc document and Salesforce SObject. See: [SourceNode](SourceNode.md)
- `global String name`: document name
- `global List<DocumentWrapper.DocumentProducts> products`: list of document pricing items. See [DocumentProducts](#documentwrapperdocumentproducts)
- `global List<DocumentWrapper.DocumentRecipient> recipients`: list of document recipients. See  [DocumentRecipient](#documentwrapperdocumentrecipient)
- `global DocumentWrapper.PandaDocUser sent_by`: PandaDoc user who sent the document.
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
Base class for users\recipients
- `global String email`: email
- `global String first_name`:  first name
- `global String last_name`: last name
- `global String id`: PandaDoc id

# DocumentWrapper.PandaDocUser
Extends from [DocumentPerson](#documentwrapperdocumentperson) and has all fields from parent.
- `global String avatar`: url to user avatar image

# DocumentWrapper.DocumentRecipient
Extends from [DocumentPerson](#documentwrapperdocumentperson) and has all fields from parent.
- `global Boolean has_completed`: `true` the recipient has completed the document
- `global String recipient_type`: possible values:
    - `signer`: the recipient has input field assigned to them
    - `CC`: the recipient has no input field assigned
- `global String role `: recipient role name

# DocumentWrapper.DocumentProducts
- `global String sku`: product sku
- `global Map<String, Object> custom_fields`: here you will get all fields that were selected on the `Configure Tokens` page for this Product type. By default there is a selected `Id` field for `OpportunityLineItem` object. Please note that if the field value equals to `null`, this value won’t been added here, Dictionary won’t have this key.
- `global Map<String, Object> custom_columns`: here you will get all custom columns that were added on PandaDoc UI.
- `global String description`: product description.
- `global DocumentWrapper.Discount discount`: product discount. Should be percent. Please see [Discount](#discount).
- `global String name`: product name
- `global String price`: string representation of product price per unit
- `global Integer qty`: items quantity
- `global String subtotal`: (price * qty) - discount

# Discount
represents discount
- `global String type`: currently always equals to `percent`
- `global String value`: string representation of discount size
