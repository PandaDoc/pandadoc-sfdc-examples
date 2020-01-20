# SourceNode
Represents an entity which linked with document

## Constructors
`global SourceNode(String type, String id)`: Creates a root source node. Type should be a SObject API name in lower case. Id should be a object instance id.

## Methods
`global void addChild(String type, String id)`: Adds additional child node to root. Can be used only on root node. Use this if document should be linked with multiple SObjects.

    NOTE: Usually root node represents a SObject which was used for generating document. And child nodes just additional objects for related lists.