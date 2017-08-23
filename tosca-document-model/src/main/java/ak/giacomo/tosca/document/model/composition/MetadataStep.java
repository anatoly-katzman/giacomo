package ak.giacomo.tosca.document.model.composition;

/**
 * Created by ak435s on 8/22/2017.
 */
public interface MetadataStep<T> extends EndStep<T>
{
    MetadataStep<T> field(String name, String value);
}
