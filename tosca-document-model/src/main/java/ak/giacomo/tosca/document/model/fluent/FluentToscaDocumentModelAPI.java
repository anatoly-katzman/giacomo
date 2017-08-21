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
    DataTypeMetadata metadata ();
    DataType description (String description);
//  DataTypeConstraints constraints ();
//  DataTypePropertyDefinitions properties ();
}

interface DataTypeMetadata extends DataType {
    DataTypeMetadata field (String name, String value);
}

interface NodeType extends NodeTypes {
    NodeType derivedFrom (String baseType);
    NodeType version (String baseType);
    NodeTypeMetadata metadata ();
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

interface NodeTypeMetadata extends NodeType {
    NodeTypeMetadata field (String name, String value);
}

interface GroupType extends GroupTypes {
    GroupType derivedFrom (String baseType);
    GroupType version (String version);
    GroupTypeMetadata metadata ();
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

interface GroupTypeMetadata extends GroupType {
    GroupTypeMetadata field (String name, String value);
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
                            .field("metedata-key3", "metadata-value3")
                    .dataType("DTName2")
                    .dataType("DTName3")
                .nodeTypes()
                    .nodeType("NTName1")
                    .nodeType("NTName2")
                .dataTypes()
                    .dataType("DTName1")
                .end();
    }
}