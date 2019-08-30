# Recipient

Represents recipietns. Uses by [JSON builders](JSONBuilder.md)

## Constructors

- `global Recipient(Recipient.RecipientSettings settings, SObject sObj)`: create Recipient from SObject according to [Recipient.RecipientSettings](#Recipient.RecipientSettings). This constructor can throw exception in case if do not selected required fields or if you have invalid configuration in `RecipientSettings`
- `global Recipient(String first_name, String last_name, String email, String company, String roleName)`

## Methods

- `global static Recipient sObjectToRecipient(SObject sObj)`: converts SObject into Recipient according to [Recipient.RecipientSettings](#Recipient.RecipientSettings). Return null if have some error with configuration or if SOQL request has not required fields for convertation.

## Variables
- `global static Map<String, Recipient.RecipientSettings> RECIPIENT_SETTINGS_MAP`: Dictionary where key is SObject name in lowercase and value is [Recipient.RecipientSettings](#Recipient.RecipientSettings) for this object. This dictionary automatically be initiated at first call.

# Recipient.RecipientSettings

## Methods
- `global Set<String> getSoqlFields()`: return all required field names for converting SObject into Recipient. This fields should be used into SOQL request to avoid SObject errors with not selected fields. Please note this method does not respects Salesforce field level security. If you need to accept FLS rules you should filter this fields additionally

## Variables
- `global String objectName`: name of SObject in lowcase
- `global String companyField`: SObject field name which should be used as recipient company
- `global String emailField`: SObject field name which should be used as recipient email
- `global Boolean filterIfChecked`: If equals to true than Recipient be filtered if value in filtering field equals to True. Otherwise Recipient be filtered if value in filtering field equals to False
- `global String filteringField`: SObject field name which should be used as recipient filtering field
- `global String firstNameField`: SObject field name which should be used as recipient first name
- `global String lastNameField`: SObject field name which should be used as recipient last name
- `global String phoneField`: SObject field name which should be used as recipient phone
- `global String roleField`: SObject field name which should be used as recipient role