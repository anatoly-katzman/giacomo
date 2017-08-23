package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface DocumentStep extends EndStep<Void>
{
    DocumentItemStep toscaDefinitionVersion(String toscaDefinitionVersion);
}
