package ak.giacomo.tosca.document.model2;

import ak.giacomo.tosca.document.model.Constraints;
import ak.giacomo.tosca.document.model.ImmutableConstraint;
import ak.giacomo.tosca.document.model.ImmutableConstraints;
import org.junit.Test;

import java.util.Arrays;

import static org.junit.Assert.*;

/**
 * Created by ak435s on 8/26/2017.
 */
public class ConstraintsTest
{
    @Test
    public void createEmptyConstraints() {
        Constraints constraints = ImmutableConstraints.builder().build();
        assertTrue( constraints.constraints().isEmpty());
    }

    @Test
    public void create2Constraints() {

        Constraints constraints = ImmutableConstraints.builder()
                .addConstraints( ImmutableConstraint.of("equal", Arrays.asList("13")))
                .addConstraints( ImmutableConstraint.of("valid_values", Arrays.asList("0", "1", "2", "3")))
                .build();
        assertEquals( 2, constraints.constraints().size());
        assertEquals( "2", constraints.constraints().get(1).values().get(2));
    }
}