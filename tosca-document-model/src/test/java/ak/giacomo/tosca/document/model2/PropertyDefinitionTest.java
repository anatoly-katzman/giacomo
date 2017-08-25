package ak.giacomo.tosca.document.model2;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by ak435s on 8/26/2017.
 */
public class PropertyDefinitionTest
{
    @Test( expected = IllegalStateException.class)
    public void createEmptyPropertyDefinition() {
        PropertyDefinition prop = ImmutablePropertyDefinition.builder().build();
    }

    @Test
    public void createMinimalPropertyDefinition() {
        PropertyDefinition prop = ImmutablePropertyDefinition.of("myName", "myType");
        assertEquals( "myName", prop.name());
        assertEquals( "myType", prop.type());
        assertEquals( "supported", prop.status());
        assertEquals( true, prop.required());
        assertFalse( prop.description().isPresent());
        assertFalse( prop.defaultValue().isPresent());
    }

    @Test
    public void createPropertyDefinition() {
        PropertyDefinition prop = ImmutablePropertyDefinition.builder()
                .name("myName").type("myType").description("myDescription").defaultValue("myDefault")
                .required(false).status("myStatus")
                .build();
        assertEquals( "myName", prop.name());
        assertEquals( "myType", prop.type());
        assertEquals( false, prop.required());
        assertEquals( "myDescription", prop.description().get());
        assertEquals( "myDefault", prop.defaultValue().get());
    }
}