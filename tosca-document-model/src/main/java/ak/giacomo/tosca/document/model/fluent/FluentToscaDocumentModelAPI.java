package ak.giacomo.tosca.document.model.fluent;

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

public class FluentToscaDocumentModelAPI
{
}


interface  End {
    void end();
}

interface Document extends End {
    DocumentItem toscaDefinitionVersion(String toscaDefinitionVersion);
}

interface DocumentItem extends End {
    DataTypes dataTypes();
    NodeTypes nodeTypes();
    GroupTypes groupTypes();
}

interface DataTypes extends DocumentItem
{
    DataType dataType( String name);
}

interface NodeTypes extends DocumentItem
{
    NodeType nodeType( String name);
}

interface GroupTypes extends DocumentItem
{
    GroupType groupType( String name);
}

interface DataType extends DataTypes {
    DataType derivedFrom (String baseType);
    DataType version (String baseType);
    Metadata<DataType> metadata ();
    DataType description (String description);
    Constraints<DataType> constraints ();
//  DataTypePropertyDefinitions properties ();
}

interface Metadata<T>  {
    Metadata<T> field(String name, String value);
    T end();
}

interface Constraints<T>  {
    Constraints<T> equal( String val);
    Constraints<T> greaterThan( String val);
    Constraints<T> greaterOrEqualThan( String val);
    Constraints<T> lessThan( String val);
    Constraints<T> lessOrEqualThan( String val);
    Constraints<T> inRange( String lowerVal, String higherVal);
    Constraints<T> validValues( String... values);
    Constraints<T> length( int len);
    Constraints<T> minLength( int len);
    Constraints<T> maxLength( int len);
    Constraints<T> pattern( String pattern);
    T end();
}

interface NodeType extends NodeTypes {
    NodeType derivedFrom (String baseType);
    NodeType version (String baseType);
    Metadata<NodeType> metadata ();
    NodeType description (String description);
/*
    properties
    attributes
    requirements
    capabilities
    interfaces
    artifacts
     */
}

interface GroupType extends GroupTypes {
    GroupType derivedFrom (String baseType);
    GroupType version (String version);
    Metadata<GroupType> metadata ();
    GroupType description (String description);
/*
    properties
    attributes
    members
    requirements
    capabilities
    interfaces
     */
}

class Sample {
    void doIt( Document document) {
        document.end();

        document.toscaDefinitionVersion( "tosca_simple_yaml_1_0")
                .dataTypes()
                    .dataType("DTName1")
                        .derivedFrom("tosca.types.Root")
                        .version("3.0")
                        .metadata()
                            .field("metedata-key1", "metadata-value1")
                            .field("metedata-key2", "metadata-value2")
                            .field("metedata-key3", "metadata-value3").end()
                    .dataType("DTName2")
                        .derivedFrom("string")
                        .constraints()
                            .maxLength( 10)
                            .validValues("a", "b").end()
                    .dataType("DTName3")
                .nodeTypes()
                    .nodeType("NTName1")
                        .metadata()
                            .field("metedata-key1", "metadata-value1")
                            .field("metedata-key2", "metadata-value2").end()
                    .nodeType("NTName2")
                .dataTypes()
                    .dataType("DTName1")
                .end();
    }
}
