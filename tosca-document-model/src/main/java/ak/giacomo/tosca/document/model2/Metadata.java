package ak.giacomo.tosca.document.model2;

import org.immutables.value.Value;

import java.util.List;
import java.util.Map;

/**
 * Created by ak435s on 8/25/2017.
 */
@Value.Immutable
public abstract class Metadata
{
    public abstract List<MetadataField> fields();
}
