package ak.giacomo.tosca.document.model;

import com.google.auto.value.AutoValue;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by ak435s on 8/20/2017.
 */
@AutoValue
public class Metadata
{
    private Map<String, MetadataField> valuesByName = new LinkedHashMap();

    public MetadataField getFieldByName( String fieldName) {
        return valuesByName.get( fieldName);
    }
}
