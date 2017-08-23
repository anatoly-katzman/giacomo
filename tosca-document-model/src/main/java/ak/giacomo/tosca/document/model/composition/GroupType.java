package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface GroupType extends GroupTypes
{
    GroupType derivedFrom(String baseType);

    GroupType version(String version);

    Metadata<GroupType> metadata();

    GroupType description(String description);
/*
properties
attributes
members
requirements
capabilities
interfaces
 */
}
