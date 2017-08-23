package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface Metadata<T> extends End<T>
{
    Metadata<T> field(String name, String value);
}
