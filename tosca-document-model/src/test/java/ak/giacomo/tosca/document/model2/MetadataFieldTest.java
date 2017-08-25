package ak.giacomo.tosca.document.model2;

import ak.giacomo.tosca.document.model.ImmutableMetadata;
import ak.giacomo.tosca.document.model.ImmutableMetadataField;
import ak.giacomo.tosca.document.model.Metadata;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by ak435s on 8/26/2017.
 */
public class MetadataFieldTest
{
    @Test
    public void createEmptyMetadata()
    {
        Metadata metadata = ImmutableMetadata.builder().build();
        assertTrue (metadata.fields().isEmpty());
    }

    @Test
    public void createMetadataWith2Fields()
    {
        Metadata metadata = ImmutableMetadata.builder()
                .addFields(ImmutableMetadataField.of("key1", "value1"))
                .addFields(ImmutableMetadataField.of("key2", "value2"))
                .build();
        assertEquals( 2, metadata.fields().size());
        assertEquals( "key1", metadata.fields().get(0).name());
        assertEquals( "value1", metadata.fields().get(0).value());
        assertEquals( "key2", metadata.fields().get(1).name());
        assertEquals( "value2", metadata.fields().get(1).value());
    }
}