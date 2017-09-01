// Define a grammar called Hello
grammar Hello;

r  : 'hello' PERSON_NAME ;         // match keyword hello followed by an identifier
PERSON_NAME : [a-z]+ ;             // match lower-case identifiers
WS : [ \t\r\n]+ -> skip ; // skip spaces, tabs, newlines
