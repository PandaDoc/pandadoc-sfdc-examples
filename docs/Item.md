# Item

Represents document pricing item. Used by [JSON builders](JSONBuilder.md)

## Constructors

- `global Item(Item.ItemSettings setting, SObject sObj)`: create Item from SObject according to [Item.ItemSettings](#itemitemsettings). This constructor can throw exception in case required fields are not selected or if you have invalid configuration in `ItemSettings`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount, Decimal taxFirst, Decimal taxSecond, Object customFields)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount, Object customFields)`

## Methods

- `global static Item sObjectToItem(SObject sObj)`: converts SObject into Item according to [Item.ItemSettings](#itemitemsettings). Returns null if there was an error with configuration or if SOQL request doesn’t have the selected fields for conversion.

## Variables
- `global static Map<String, ItemSettings> PRICING_ITEM_SETTINGS_MAP`: Dictionary where key is SObject name in lowercase and value is [Item.ItemSettings](#itemitemsettings) for this object. This dictionary is automatically initiated at first call. 

## Item.ItemSettings

## Methods

- `global Set<String> getSoqlFields`: returns all required fields names for converting SObject into Item. These fields should be used into SOQL request to avoid SObject errors with not selected fields. Please note this method does not respect Salesforce field level security. If you need to accept FLS rules you should filter these fields additionally

## Variables

- `global String objectName`: name of SObject in lowcase
- `global String skuField`: SObject field name which should be used as Pricing Item SKU
- `global String nameField`: SObject field name which should be used as Pricing Item name
- `global String priceField1`: primary field with pricing
- `global String priceField2`: secondary field with pricing to be used if primary field is empty
- `global String quantityField`: SObject field name which should be used as Pricing Item quantity
- `global String descriptionField`: SObject field which should be used as Pricing Item description
- `global String discountField`: SObject field which should be used as Pricing Item discount(percent)
- `global String firstTaxField`: SObject field which should be used as Pricing Item tax
- `global String secondTaxField`: SObject field which should be used as as a second Pricing Item tax. The taxes are summarized in the pricing table.
