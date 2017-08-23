package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface Document extends End<Void>
{
    DocumentItem toscaDefinitionVersion(String toscaDefinitionVersion);
}
