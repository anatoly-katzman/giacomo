package ak.giacomo.tosca.parser;

import org.antlr.v4.runtime.CommonToken;
import org.yaml.snakeyaml.error.Mark;
import org.yaml.snakeyaml.tokens.ScalarToken;
import org.yaml.snakeyaml.tokens.Token;

import java.util.HashMap;
import java.util.Map;

public class SnakeyamlScannerBasedToken extends CommonToken
{
    private SnakeyamlScannerBasedToken() {
        super(-1);
    }

    // All possible token types - copied directly from those of Snakeyaml
    public static final int
            ALIAS = Token.ID.Alias.ordinal(),
            ANCHOR = Token.ID.Anchor.ordinal(),
            BLOCK_END = Token.ID.BlockEnd.ordinal(),
            BLOCK_ENTRY = Token.ID.BlockEntry.ordinal(),
            BLOCK_MAPPING_START = Token.ID.BlockMappingStart.ordinal(),
            BLOCK_SEQUENCE_START = Token.ID.BlockSequenceStart.ordinal(),
            DIRECTIVE = Token.ID.Directive.ordinal(),
            DOCUMENT_END = Token.ID.DocumentEnd.ordinal(),
            DOCUMENT_START = Token.ID.DocumentStart.ordinal(),
            FLOW_ENTRY = Token.ID.FlowEntry.ordinal(),
            FLOW_MAPPING_END = Token.ID.FlowMappingEnd.ordinal(),
            FLOW_MAPPING_START = Token.ID.FlowMappingStart.ordinal(),
            FLOW_SEQUENCE_END = Token.ID.FlowSequenceEnd.ordinal(),
            FLOW_SEQUENCE_START = Token.ID.FlowSequenceStart.ordinal(),
            KEY = Token.ID.Key.ordinal(),
            SCALAR = Token.ID.Scalar.ordinal(),
            STREAM_END = Token.ID.StreamEnd.ordinal(),
            STREAM_START = Token.ID.StreamStart.ordinal(),
            TAG = Token.ID.Tag.ordinal(),
            VALUE = Token.ID.Value.ordinal(),
            WHITESPACE = Token.ID.Whitespace.ordinal(),
            COMMENT = Token.ID.Comment.ordinal(),
            ERROR = Token.ID.Error.ordinal();

    /**
     * Create an ANTLR token of a Snakeyaml scanner token
     * @param snakeyamlToken the source Sbakeyaml token
     * @return an ANTLR token that can be fed to an ANTLR parser
     */
    public static org.antlr.v4.runtime.Token fromSnakeyamlScannerToken( org.yaml.snakeyaml.tokens.Token snakeyamlToken)
    {
        Token.ID tokenId = snakeyamlToken.getTokenId();
        Mark startMark = snakeyamlToken.getStartMark();
        Mark endMark = snakeyamlToken.getEndMark();

        SnakeyamlScannerBasedToken antlrToken = new SnakeyamlScannerBasedToken();

        int type = tokenTypesBySnakeyamlId.get( tokenId);
        antlrToken.setType( type);

        antlrToken.setLine( startMark.getLine());
        antlrToken.setCharPositionInLine( startMark.getColumn());
        antlrToken.setStartIndex( startMark.getIndex());
        antlrToken.setStopIndex( endMark.getIndex());

        antlrToken.setChannel( DEFAULT_CHANNEL);
        antlrToken.setTokenIndex(-1);

        String text = (type == SCALAR)
            ? ((ScalarToken)snakeyamlToken).getValue()
            : "";
        antlrToken.setText( text);

        return antlrToken;
    }

    private static final Map<Token.ID, Integer> tokenTypesBySnakeyamlId = new HashMap<>();
    static {
        tokenTypesBySnakeyamlId.put( Token.ID.Alias, ALIAS);
        tokenTypesBySnakeyamlId.put( Token.ID.Anchor, ANCHOR);
        tokenTypesBySnakeyamlId.put( Token.ID.BlockEnd, BLOCK_END);
        tokenTypesBySnakeyamlId.put( Token.ID.BlockEntry, BLOCK_ENTRY);
        tokenTypesBySnakeyamlId.put( Token.ID.BlockMappingStart, BLOCK_MAPPING_START);
        tokenTypesBySnakeyamlId.put( Token.ID.BlockSequenceStart, BLOCK_SEQUENCE_START);
        tokenTypesBySnakeyamlId.put( Token.ID.Directive, DIRECTIVE);
        tokenTypesBySnakeyamlId.put( Token.ID.DocumentEnd, DOCUMENT_END);
        tokenTypesBySnakeyamlId.put( Token.ID.DocumentStart, DOCUMENT_START);
        tokenTypesBySnakeyamlId.put( Token.ID.FlowEntry, FLOW_ENTRY);
        tokenTypesBySnakeyamlId.put( Token.ID.FlowMappingEnd, FLOW_MAPPING_END);
        tokenTypesBySnakeyamlId.put( Token.ID.FlowMappingStart, FLOW_MAPPING_START);
        tokenTypesBySnakeyamlId.put( Token.ID.FlowSequenceEnd, FLOW_SEQUENCE_END);
        tokenTypesBySnakeyamlId.put( Token.ID.FlowSequenceStart, FLOW_SEQUENCE_START);
        tokenTypesBySnakeyamlId.put( Token.ID.Key, KEY);
        tokenTypesBySnakeyamlId.put( Token.ID.Scalar, SCALAR);
        tokenTypesBySnakeyamlId.put( Token.ID.StreamEnd, STREAM_END);
        tokenTypesBySnakeyamlId.put( Token.ID.StreamStart, STREAM_START);
        tokenTypesBySnakeyamlId.put( Token.ID.Tag, TAG);
        tokenTypesBySnakeyamlId.put( Token.ID.Value, VALUE);
        tokenTypesBySnakeyamlId.put( Token.ID.Whitespace, WHITESPACE);
        tokenTypesBySnakeyamlId.put( Token.ID.Comment, COMMENT);
        tokenTypesBySnakeyamlId.put( Token.ID.Error, ERROR);
    }
}
