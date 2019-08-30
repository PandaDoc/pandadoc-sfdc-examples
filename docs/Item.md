# Item

Represents document pricing item. Uses by [JSON builders](JSONBuilder.md)

## Constructors

- `global Item(Item.ItemSettings setting, SObject sObj)`: create Item from SObject according to [Item.ItemSettings](#Item.ItemSettings). This constructor can throw exception in case if do not selected required fields or if you have invalid configuration in `ItemSettings`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount, Decimal taxFirst, Decimal taxSecond, Object customFields)`
- `global Item(String sku, String name, Decimal price, Decimal qty, String description, Decimal discount, Object customFields)`

## Methods

- `global static Item sObjectToItem(SObject sObj)`: converts SObject into Item according to [Item.ItemSettings](#Item.ItemSettings). Return null if have some error with configuration or if SOQL request has not required fields for convertation.

## Variables
- `global static Map<String, ItemSettings> PRICING_ITEM_SETTINGS_MAP`: Dictionary where key is SObject name in lowercase and value is [Item.ItemSettings](#Item.ItemSettings) for this object. This dictionary automatically be initiated at first call. 

## Item.ItemSettings

## Methods

- `global Set<String> getSoqlFields`: return all required field names for converting SObject into Item. This fields should be used into SOQL request to avoid SObject errors with not selected fields. Please note this method does not respects Salesforce field level security. If you need to accept FLS rules you should filter this fields additionally

## Variables

- `global String objectName`: name of SObject in lowcase
- `global String skuField`: SObject field name which should be used as Pricing Item SKU
- `global String nameField`: SObject field name which should be used as Pricing Item name
- `global String priceField1`: primary field with pricing
- `global String priceField2`: secondary field with pricing be used if primary field is empty
- `global String quantityField`: SObject field name which should be used as Pricing Item quantity
- `global String descriptionField`: SObject field which should be used as Pricing Item description
- `global String discountField`: SObject field which should be used as Pricing Item discount(percents)
- `global String firstTaxField`: SObject field which should be used as Pricing Item tax
- `global String secondTaxField`: SObject field which should be used as Pricing Item tax first and second tax is summarizing together
