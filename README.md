# Code examples for PandaDoc Salesforce package extensions

This repository contains code examples and available API methods for PandaDoc extension for Salesforce CRM.
Our [AppExchange page](https://appexchange.salesforce.com/appxListingDetail?listingId=a0N3A00000DvMrEUAV)

Sometimes standard functionality of PandaDoc package is not enough.
For that reason our package provide API for implementing additional customizations focused for specific business cases.

Currently PandaDoc package provide two different API for package extensions.

1. ## JSON builders.
    JSON builders used for passing data from Salesforce to PandaDoc document. It is a class which implements `pandadoc.JsonBuilder` interface. JSON builder can pass this data into PandaDoc:
    - tokens
    - document name
    - pricing items
    - recipients
    - metadata

2. ## Trigger handlers
    Every time when document state changes PandaDoc sends new document payload in JSON format into SFDC. Our package save this data into [pandadoc__PandaDocDocument__c](docs/pandadoc__PandaDocDocument__c.md) object. Our API provide simplified solution for handling this changes via SF triggers. Currently we sending this events to SFDC side:
    - `document_state_changed`: document status was changed or new document created. You got this event every time when document was sent\paid\approved\etc
    - `recipient_completed`: some recipient filled all required input fields for him
    - `document_deleted`: document was deleted
    - `document_updated`: document moved to draft status after sending or completing. New document version was generated

# How to use this examples

All examples are in folder `examples`. This is sfdx project. You can read how to work with sfdx [here](https://developer.salesforce.com/tools/sfdxcli). We are highly recommends to upload this source code into some scratch org and make experiments there.
By default this source code are already have [installedPackage](examples/force-app/main/default/installedPackages/pandadoc.installedPackage-meta.xml) in it.
So no need to install our package manually. Also it have already configured simple custom object.

# StandardJsonBuilder

PandaDoc package providing are StandardJsonBuilder. This builder can be configured to provide:
- set of tokens
- related recipients
- related pricing items
- document name
- send object itself as recipient(usefull for objects like Lead, Contact or Account)

This builder can be configured via UI. Probably this functionality is enough to cover your business requirements. In this case no need to create new Apex classes just use this functionality. Use `PandaDoc Quick Setup` button on `PandaDoc Setup` page to use already provided functionality.

![quick setup](screenshots/01-quick-setup-btn.png)
![adding screen](screenshots/02-adding-screen.png)
![builder setup](screenshots/03-builder-setup.png)

# Custom JSON builder examples

In `examples` folder you can find source code for JSON builders:
- [MinimalJsonBuilder](examples/force-app/main/default/classes/MinimalJsonBuilder.cls): According to his name it just a minimal JSON Builder. It respects document name and tokens list which was configured via `PandaDoc Setup` page. But recipients and pricing items always be empty.

        NOTE: Make sure that class have `global` access level.

- [CustomRecipients](examples/force-app/main/default/classes/CustomRecipients.cls): This example adding two recipients to document. One of them is generated via related contact. And another is just a hardcoded recipient.
    - Method `getObjectContact` shows how to generate recipient from SObject. This method respects `Recipient Mapping` setting from `PandaDoc Setup`.

            NOTE: To avoid `System.SObjectException: SObject row was retrieved via SOQL without querying the requested field` error please re select provided sobject for every  required operation  like "form recipients" or "form pricing items"

    - Method `getPredefinedRecipient` shows how to generate recipient for any sort of data. This method can not work with recipient mapping from `PandaDoc Setup` page. But this way allow to generate recipients almost from everything.

    Additional information about `Recipient` object [here](docs/Recipient.md)

- [CustomPricingItems](examples/force-app/main/default/classes/CustomPricingItems.cls): Similar to `CustomRecipients` shows how add pricing items into document.

        NOTE: By default package does not have pricing item mapping for Product2 object.
        NOTE: Currently we are not providing any public API to use sorting settings from Pricing Items mapping page. This is experimental feature and public access for third party customizations be added later.

    Additional information about `Item` object [here](docs/Item.md)

- [ExtraTokens](examples/force-app/main/default/classes/ExtraTokens.cls): This builder adding some additional tokens to document. And still document have tokens which was selected on `PandaDoc Setup` page.

For using custom JSON builder class upload this examples to target organization with installed PandaDoc package. After that press to the "Add Custom JSON Builder" button and in showed popup window please enter a class name and select SObject.

![custom-builder-btn](screenshots/04-custom-builder-btn.png)
![adding-custom-builder](screenshots/05-adding-custom-builder.png)

# VisualForce inline page for classic UI
We are highly recommend to use Lightning component for adding PandaDoc to SObject pages. You can read how to do that [here](https://support.pandadoc.com/hc/en-us/articles/360019828554-Salesforce-Lightning-Standard-setup-). If you are not using Lightning UI for some reason you need to create a new Visualforce page for every  object which you want to use with PandaDoc. Except for Contact, Lead, Account and Opportunity VF pages for this objects already included in package. Example VF page can be found [here](examples/force-app/main/default/pages/PandaDocForCustomObject.page)

More info about configuring PandaDoc for classic UI can be found [here](https://support.pandadoc.com/hc/en-us/articles/360007816454-Salesforce-Classic-Add-PandaDoc-to-custom-objects)

# Trigger handler example

[DocumentHandler](examples/force-app/main/default/classes/DocumentHandler.cls) provides an example of trigger handler. This simple handler updates OpportunityLineItem quantity and unit price from PandaDoc document. This handler still can not be executed without properly created trigger for `pandadoc__PandaDocDocument__c` object. Please look at [PandaDocDocumentTrigger](examples/force-app/main/default/triggers/PandaDocDocumentTrigger.trigger). Please look at `pandadoc.TriggerTemplate.TriggerManager` object. This object provide possibility to work with `Document trigger settings` from the `PandaDoc setup` page.

For adding custom Trigger to PandaDoc upload all source code into organization. And click on `Add new trigger` button.
![new-trigger-btn](screenshots/06-new-trigger-btn.png)

On PopUp window enter title for new handler(any human readable text). And internal trigger name. This name will be unique identificator for this trigger. And this name should be used with `pandadoc.TriggerManager.isTriggerEnabled` method.

![new-trigger-setup](screenshots/07-trigger-setup.png)

If everything was configured correctly you will have possibility to enable\disable trigger handlers right from PandaDoc setup page.

# Additional API reference
- [Item](docs/Item.md): wrapper for document pricing item
- [Recipient](docs/Recipient.md): wrapper for document recipient
- [JSONBuilder](docs/JSONBuilder.md): base class for custom JSON builders
- [pandadoc__PandaDocDocument__c](docs/pandadoc__PandaDocDocument__c.md): Database object which represents PandaDoc document
- [DocumentWrapper](docs/DocumentWrapper.md): wrapper for document payload. Used in triggers
- [TriggerTemplate](docs/TriggerTemplate.md): util classes for implementing custom trigger handlers
- [TriggerManager](docs/TriggerManager.md): API for trigger settings