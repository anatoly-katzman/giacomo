grammar PredCppStat;

tokens {XXX}

@parser::members {
    // Set<String> types = new HashSet<String>() {{add("T");}};
    boolean istype() { return getCurrentToken().getText().equals("AAA"); }
    boolean isPropertyDefinitions() {return getCurrentToken().getText().equals("properties");}
    boolean isCapabilityDefinitions() {return getCurrentToken().getText().equals("capabilities");}
}

decl: ID ID // E.g., "Point p"
| {istype()}? ID OPEN_BRACKET ID CLOSE_BRACKET // E.g., "Point (p)", same as ID ID
;

expr: INT // integer literal
| ID // identifier
| {!istype()}? ID OPEN_BRACKET expr CLOSE_BRACKET // function call
;


propertyDefinitions
    :   {isPropertyDefinitions()}? propertyDefinition*
    ;

capabilityDefinitions
    :   {isCapabilityDefinitions()}? capabilityDefinition*
    ;

propertyDefinition
    :   propertyName=SCALAR XXX
    ;

capabilityDefinition
    :   KEYNAME_GROUPS capabilityName=SCALAR
    ;

KEYNAME_GROUPS
    :   'qqq' {getText().equals("groups")}?
    ;

KEYNAME_ARTIFACTS
    :   ZZZ {getText().equals("artifacts")}?
    ;

ZZZ: 'abc';
OPEN_BRACKET: '(';
CLOSE_BRACKET: ')';
