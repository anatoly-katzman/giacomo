package ak.giacomo.tosca.document.model;

import com.google.auto.value.AutoValue;

import java.util.Optional;

/**
 * Created by ak435s on 8/20/2017.
 */
@AutoValue
public abstract class Document
{
    abstract public Optional<String> toscaDefinitionVersion();
    abstract public Optional<Metadata> metadata();
    abstract public Optional<String> description();

/*
    private RepositoryDefinitions repositorieDefinitions;
    private ImportDefinitions importDefinitions;
    private ArtifactTypeDefinitions artifactTypeDefinitions;
    private DataTypeDefinitions dataTypeDefinitions;
    private CapabilityTypeDefinitions capabilityTypeDefinitions;
    private InterfaceTypeDefinitions interfaceTypeDefinitions;
    private RelationshipTypeDefinitions relationshipTypeDefinitions;

    private NodeTypeDefinitions nodeTypeDefinitions;
    private GroupTypeDefinitions groupTypeDefinitions;
    private PolicyTypeDefinitions policyTypeDefinitions;
    private DataTypeDefinitions dataTypeDefinitions;

    private TopologyTemplate topologyTemplate;
*/

    static public Builder builder() {
        return new AutoValue_Document.Builder();
    }

    @AutoValue.Builder
    abstract public static class Builder {
        abstract public Builder toscaDefinitionVersion( String toscaDefinitionVersion);
        abstract public Builder metadata( Metadata metadata);
        abstract public Builder description( String description);

        abstract public Document build();
    }
}
