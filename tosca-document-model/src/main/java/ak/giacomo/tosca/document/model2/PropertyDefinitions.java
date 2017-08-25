package ak.giacomo.tosca.document.model2;

import org.immutables.value.Value;

import java.util.List;
import java.util.Optional;

/**
 * Created by ak435s on 8/26/2017.
 */
@Value.Immutable
public abstract class PropertyDefinitions
{
    public abstract List<PropertyDefinition> properties();
}
