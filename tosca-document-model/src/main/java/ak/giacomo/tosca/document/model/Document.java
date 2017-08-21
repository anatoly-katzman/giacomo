package ak.giacomo.tosca.document.model;

import com.google.auto.value.AutoValue;

import java.util.Optional;

/**
 * Created by ak435s on 8/20/2017.
 */
@AutoValue
public abstract class Document
{
    abstract Optional<String> toscaDefinitionVersion();
    abstract Optional<Metadata> metadata();
    abstract Optional<String> description();

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

    static Builder builder() {
        return new AutoValue_Document.Builder();
    }

    @AutoValue.Builder
    abstract static class Builder {
        abstract Builder toscaDefinitionVersion( String toscaDefinitionVersion);
        abstract Builder metadata( Metadata metadata);
        abstract Builder description( String description);

        abstract Document build();
    }
}
