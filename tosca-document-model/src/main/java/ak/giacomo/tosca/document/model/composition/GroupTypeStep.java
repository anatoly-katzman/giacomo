package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface GroupTypeStep extends GroupTypesStep
{
    GroupTypeStep derivedFrom(String baseType);

    GroupTypeStep version(String version);

    MetadataStep<GroupTypeStep> metadata();

    GroupTypeStep description(String description);
/*
properties
attributes
members
requirements
capabilities
interfaces
 */
}
