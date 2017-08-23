package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface DocumentItem extends End<Void>
{
    DataTypes dataTypes();

    NodeTypes nodeTypes();

    GroupTypes groupTypes();
}
