package ak.giacomo.tosca.document.model2;

import org.immutables.value.Value;

import java.util.Optional;

/**
 * Created by ak435s on 8/26/2017.
 */
@Value.Immutable
public abstract class DataType
{
    public abstract Optional<String> derivedFrom();
    public abstract Optional<String> version();
    public abstract Optional<Metadata> metadata();
    public abstract Optional<String> description();
    public abstract Optional<Constraints> constraints();
    public abstract Optional<PropertyDefinitions> properties();
}
