package ak.giacomo.tosca.parser;

import org.junit.Test;
import org.yaml.snakeyaml.DumperOptions;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.events.*;
import org.yaml.snakeyaml.nodes.Tag;

import java.io.StringReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import static org.junit.Assert.*;

public class SnakeyamlParserTest
{
    @Test
    public void testParse() {
        Yaml yaml = new Yaml();
        Event e = null;
        int numEvents = 0;
        Iterable<Event> events = yaml.parse(new StringReader("abc: 56 \nk2: 7\nk3: {a: 1, b: 2}\n[1, 2, 3]: 'abc'"));
        for (Event event : events) {
            System.out.println( event);
            numEvents++ ;
        }
        System.out.println("Counted " + numEvents + " events in total");
        assertEquals( 23, numEvents);
    }

    @Test
    public void testParseEvents() {
        Yaml yaml = new Yaml();
        Iterator<Event> events = yaml.parse(new StringReader("%YAML 1.1\n---\na")).iterator();
        assertTrue(events.next() instanceof StreamStartEvent);
        DocumentStartEvent documentStartEvent = (DocumentStartEvent) events.next();
        assertTrue(documentStartEvent.getExplicit());
        assertEquals(DumperOptions.Version.V1_1, documentStartEvent.getVersion());
        Map<String, String> DEFAULT_TAGS = new HashMap<String, String>();
        DEFAULT_TAGS.put("!", "!");
        DEFAULT_TAGS.put("!!", Tag.PREFIX);
        assertEquals(DEFAULT_TAGS, documentStartEvent.getTags());
        ScalarEvent scalarEvent = (ScalarEvent) events.next();
        assertNull(scalarEvent.getAnchor());
        assertNull(scalarEvent.getTag());
        assertEquals(new ImplicitTuple(true, false).toString(), scalarEvent.getImplicit().toString());
        DocumentEndEvent documentEndEvent = (DocumentEndEvent) events.next();
        assertFalse(documentEndEvent.getExplicit());
        assertTrue("Unexpected event.", events.next() instanceof StreamEndEvent);
        assertFalse(events.hasNext());
    }

    @Test
    public void testParseManyDocuments() {
        Yaml yaml = new Yaml();
        Event e = null;
        int counter = 0;
        for (Event event : yaml.parse(new StringReader("abc: 56\n---\n4\n---\nqwe\n"))) {
            if (e == null) {
                assertTrue(event instanceof StreamStartEvent);
            }
            e = event;
            counter++;
        }
        assertTrue(e instanceof StreamEndEvent);
        assertEquals(14, counter);
    }
}
