package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface NodeTypeStep extends NodeTypesStep
{
    NodeTypeStep derivedFrom(String baseType);

    NodeTypeStep version(String baseType);

    MetadataStep<NodeTypeStep> metadata();

    NodeTypeStep description(String description);
/*
properties
attributes
requirements
capabilities
interfaces
artifacts
 */
}
