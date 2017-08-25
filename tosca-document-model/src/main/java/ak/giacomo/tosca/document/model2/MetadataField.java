package ak.giacomo.tosca.document.model2;

import org.immutables.value.Value;

/**
 * Created by ak435s on 8/25/2017.
 */
@Value.Immutable
public abstract class MetadataField
{
    @Value.Parameter
    public abstract String name();

    @Value.Parameter
    public abstract String value();
}
