package ak.giacomo.tosca.parser;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.junit.Test;

import static org.junit.Assert.*;

public class HelloParserTest
{
    @Test
    public void testHelloParser() {

        CharStream inputStream = CharStreams.fromString ( "a a a", "mySource");
        HelloLexer lexer = new HelloLexer( inputStream);
        TokenStream tokenStream = new CommonTokenStream( lexer);
        HelloParser parser = new HelloParser( tokenStream);
        HelloParser.RContext rContext = parser.r();

        HelloVisitor visitor = new HelloBaseVisitor();
        visitor.visit( rContext);

        HelloListener listener = new HelloBaseListener();
        ParseTreeWalker walker = new ParseTreeWalker();
        walker.walk( listener, rContext);
    }
}