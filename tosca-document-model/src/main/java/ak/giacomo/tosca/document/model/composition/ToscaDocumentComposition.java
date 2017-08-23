package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/21/2017.
 */
/*

https://dzone.com/articles/java-fluent-api-designer-crash

Document ::= ToscaDefinitionVersion? DocumentItem*
DocumentItem ::= DataTypes | NodeTypes | GroupTypes
DataTypes ::= DataType+
NodeTypes ::= NodeType+
GroupTypes ::= GroupType+

Java impplementation of these rules:
- Every DSL “keyword” becomes a Java method
- Every DSL “connection” becomes an interface
- When you have a “mandatory” choice (you can’t skip the next keyword), every keyword of that choice is a method in the current interface. If only one keyword is possible, then there is only one method
- When you have an “optional” keyword, the current interface extends the next one (with all its keywords / methods)
- When you have a “repetition” of keywords, the method representing the repeatable keyword returns the interface itself, instead of the next interface
- Every DSL subdefinition becomes a parameter. This will allow for recursiveness
*/

public interface ToscaDocumentComposition
{
    Document document();
    DataTypes dataTypes();
    DataType dataType();
}


