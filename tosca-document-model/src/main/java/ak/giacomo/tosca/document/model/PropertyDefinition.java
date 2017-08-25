package ak.giacomo.tosca.document.model;

import org.immutables.value.Value;

import java.util.Optional;

/**
 * Created by ak435s on 8/26/2017.
 */
@Value.Immutable
public abstract class PropertyDefinition
{
    @Value.Parameter
    public abstract String name();

    @Value.Parameter
    public abstract String type();

    public abstract Optional<String> description();

    @Value.Default
    public boolean required() {
        return true;
    }

    public abstract Optional<String> defaultValue();

    @Value.Default
    public String status() {
        return "supported";
    }

    public abstract Optional<Constraints> constraints();
    public abstract Optional<String> entrySchema();
}
