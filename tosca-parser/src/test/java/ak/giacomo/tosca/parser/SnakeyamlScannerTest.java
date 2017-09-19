package ak.giacomo.tosca.parser;

import org.junit.Test;
import org.yaml.snakeyaml.reader.StreamReader;
import org.yaml.snakeyaml.scanner.Scanner;
import org.yaml.snakeyaml.scanner.ScannerImpl;
import org.yaml.snakeyaml.tokens.ScalarToken;
import org.yaml.snakeyaml.tokens.Token;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.yaml.snakeyaml.tokens.Token.ID.*;

public class SnakeyamlScannerTest
{
    @Test
    public void scanEmptyString() {
        List<Token> tokens = tokenize( "");
        assertEquals(2, tokens.size());
        assertEquals( StreamStart, tokens.get(0).getTokenId());
        assertEquals( StreamEnd, tokens.get(1).getTokenId());
    }

    @Test
    public void scanString()
    {
        List<Token> tokens = tokenize( "\nabc: 56 \nk2: 7\nk3: {a: 1, b: 2}\n[1, 2, 3]: 'abc'");
        assertEquals(36, tokens.size());
        assertEquals( Token.ID.StreamStart, tokens.get(0).getTokenId());
        assertEquals( Token.ID.BlockMappingStart, tokens.get(1).getTokenId());

        assertEquals( Token.ID.Key, tokens.get(2).getTokenId());

        Token token3 = tokens.get(3);
        assertEquals( Token.ID.Scalar, token3.getTokenId());
        ScalarToken scalar3 = (ScalarToken) token3;
        assertEquals( "abc", scalar3.getValue());
        assertEquals( 1, scalar3.getStartMark().getLine());

        assertEquals( Token.ID.Value, tokens.get(4).getTokenId());

        Token token5 = tokens.get(5);
        assertEquals( Token.ID.Scalar, token5.getTokenId());
        ScalarToken scalar5 = (ScalarToken) token5;
        assertEquals( "56", scalar5.getValue());
        assertEquals( 1, scalar5.getStartMark().getLine());
        
        assertEquals( Token.ID.StreamEnd, tokens.get(35).getTokenId());
    }

    @Test
    public void scanInvalidYamlString() {
        // Should tokenize even strings that look invalid as YAML
        List<Token> tokens = tokenize( "}{");
        assertEquals(4, tokens.size());
        assertEquals( StreamStart, tokens.get(0).getTokenId());
        assertEquals( FlowMappingEnd, tokens.get(1).getTokenId());
        assertEquals( FlowMappingStart, tokens.get(2).getTokenId());
        assertEquals( StreamEnd, tokens.get(3).getTokenId());
    }

    private List<Token> tokenize(String text)
    {
        List<Token> tokens = new ArrayList<>();
        StreamReader reader = new StreamReader( text);
        Scanner scanner = new ScannerImpl(reader);
        while (!scanner.checkToken( StreamEnd)) {
            Token token = scanner.getToken();
            tokens.add( token);
        }
        Token token = scanner.getToken();
        tokens.add( token);

/*
        String prettyTokens = Joiner.on(",\n").join(tokens);
        System.out.println( prettyTokens);
*/
        return tokens;
    }
}
