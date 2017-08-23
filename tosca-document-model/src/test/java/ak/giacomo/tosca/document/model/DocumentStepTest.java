package ak.giacomo.tosca.document.model;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Created by ak435s on 8/20/2017.
 */
public class DocumentStepTest
{
    @Test
    public void createEmptyDocument() {
        Document document = Document.builder().build();
        assertFalse( document.toscaDefinitionVersion().isPresent());
        assertFalse( document.metadata().isPresent());
        assertFalse( document.description().isPresent());
    }

    @Test
    public void createDocument() {
        final String DESCRIPTION = "This is a description...";
        Document document = Document.builder()
                .description(DESCRIPTION)
                .build();
        assertFalse( document.toscaDefinitionVersion().isPresent());
        assertFalse( document.metadata().isPresent());
        assertEquals( DESCRIPTION, document.description().get());
    }

}
