package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface DocumentItemStep extends EndStep<Void>
{
    DataTypesStep dataTypes();

    NodeTypesStep nodeTypes();

    GroupTypesStep groupTypes();
}
