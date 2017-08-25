package ak.giacomo.tosca.document.model;

import org.immutables.value.Value;

import java.util.List;

/**
 * Created by ak435s on 8/25/2017.
 */
@Value.Immutable
public abstract class Constraint
{
    @Value.Parameter
    public abstract String operator();

    @Value.Parameter
    public abstract List<String> values();
}
