package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface NodeType extends NodeTypes
{
    NodeType derivedFrom(String baseType);

    NodeType version(String baseType);

    Metadata<NodeType> metadata();

    NodeType description(String description);
/*
properties
attributes
requirements
capabilities
interfaces
artifacts
 */
}
