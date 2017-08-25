package ak.giacomo.tosca.document.model2;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by ak435s on 8/26/2017.
 */
public class DataTypeTest
{
    @Test
    public void createEmptyDataType()
    {
        DataType dataType = ImmutableDataType.builder().build();
        assertFalse( dataType.derivedFrom().isPresent());
        assertFalse( dataType.description().isPresent());
        assertFalse( dataType.metadata().isPresent());
        assertFalse( dataType.constraints().isPresent());
        assertFalse( dataType.properties().isPresent());
    }
}