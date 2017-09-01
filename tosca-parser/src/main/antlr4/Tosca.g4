grammar Tosca;

// Parser rules
propertyDefinitions
    :   KEYNAME_PROPERTIES propertyDefinition*
    ;
propertyDefinition
    :   KEYNAME propertyDefinitionItem*
    ;
propertyDefinitionItem
    :   KEYNAME_TYPE dataTypeName
    |   KEYNAME_DESCRIPTION SCALAR_VALUE
    |   KEYNAME_REQUIRED BOOLEAN_VALUE
    |   KEYNAME_DEFAULT propertyValue
    |   KEYNAME_STATUS PROPERTY_STATUS_VALUE
    |   KEYNAME_CONSTRAINTS constraints
    |   KEYNAME_ENTRY_SCHEMA dataTypeName
    ;
propertyValue
    :
    ;
constraints
    :
    ;
dataTypeName
    :   SCALAR_VALUE
    ;

// Lexer rules
PROPERTY_STATUS_VALUE
    :   'supported' | 'unsupported' | 'experimental' | 'deprecated'
    ;
