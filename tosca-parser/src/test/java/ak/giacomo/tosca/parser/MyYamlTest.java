package ak.giacomo.tosca.parser;

import org.antlr.v4.runtime.*;
import org.junit.Test;

import static org.junit.Assert.*;

public class MyYamlTest
{
    @Test
    public void testEmptyString() {

        CharStream inputStream = CharStreams.fromString ( " #  ", "mySource");
        MyYaml lexer = new MyYaml( inputStream);
        TokenStream tokenStream = new CommonTokenStream( lexer);
/*
        CharStream inputStream = CharStreams.fromString ( "a a a", "mySource");
        HelloLexer lexer = new HelloLexer( inputStream);
        TokenStream tokenStream = new CommonTokenStream( lexer);
*/
        Token token1 = lexer.getToken();
        Token token2 = lexer.getToken();
        Token token3 = lexer.getToken();
        String text = tokenStream.getText();
        Token token10 = tokenStream.get(0);
        Token token11 = tokenStream.get(0);
        Token token12 = tokenStream.get(1);

    }
}