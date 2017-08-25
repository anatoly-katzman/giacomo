package ak.giacomo.tosca.document.model;

import com.google.auto.value.AutoValue;

import java.util.Optional;

/**
 * Created by ak435s on 8/20/2017.
 */
@AutoValue
public abstract class Document
{
    public abstract Optional<String> toscaDefinitionVersion();
    public abstract Optional<Metadata> metadata();
    public abstract Optional<String> description();

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

    public static Builder builder() {
        return new AutoValue_Document.Builder();
    }

    @AutoValue.Builder
    public abstract static class Builder {
        public abstract Builder toscaDefinitionVersion( String toscaDefinitionVersion);
        public abstract Builder metadata( Metadata metadata);
        public abstract Builder description( String description);

        public abstract Document build();
    }
}
