package ak.giacomo.tosca.document.model;

import org.immutables.value.Value;

import java.util.List;

/**
 * Created by ak435s on 8/26/2017.
 */
@Value.Immutable
public abstract class Constraints
{
    public abstract List<Constraint> constraints();
}
