lexer grammar MyYaml;

/*

http://yaml.org/spec/1.2/spec.html

*/


/*****************************************************************************
    Chapter 5. Characters
    5.1. Character Set
*****************************************************************************/

//[1]	c-printable	::=	  #x9 | #xA | #xD | [#x20-#x7E]        /* 8 bit */
//                    | #x85 | [#xA0-#xD7FF] | [#xE000-#xFFFD] /* 16 bit */
//                    | [#x10000-#x10FFFF]                     /* 32 bit */
C_PRINTABLE: '\u0009' | '\u000A' | '\u000D' | [\u0020-\u007e]
            | '\u0085' | [\u00a0-\ud7ff] | [\ue000-\ufffd]
            | [\u{10000}-\u{10ffff}];

// [2]	nb-json	::=	#x9 | [#x20-#x10FFFF]
NB_JSON: '\u0009' | [\u0020-\u{10ffff}];


/*****************************************************************************
    5.2. Character Encodings
*****************************************************************************/

// [3]	c-byte-order-mark	::=	#xFEFF
C_BYTE_ORDER_MARK: '\ufeff';


/*****************************************************************************
    5.3. Indicator Characters
*****************************************************************************/

//--- Block Structure Indicators
// [4]	c-sequence-entry	::=	“-”
C_CEQUENCE_ENTRY: '-';

// [5]	c-mapping-key	::=	“?”
C_MAPPING_KEY: '?';

// [6]	c-mapping-value	::=	“:”
C_MAPPING_VALUE: ':';

//--- Flow Collection Indicators
// [7]	c-collect-entry	::=	“,”
C_COLLECT_ENTRY: ',';

// [8]	c-sequence-start	::=	“[”
C_SEQUENCE_START: '[';

// [9]	c-sequence-end	::=	“]”
C_SEQUENCE_END: '[';

// [10]	c-mapping-start	::=	“{”
C_MAPPING_START: '[';

// [11]	c-mapping-end	::=	“}”
C_MAPPING_END: '[';

//--- Comment Indicator
// [12]	c-comment	::=	“#”
C_COMMENT: '#';

//--- Node Property Indicators
// [13]	c-anchor	::=	“&”
C_ANCHOR: '&';

// [14]	c-alias	::=	“*”
C_ALIAS: '*';

// [15]	c-tag	::=	“!”
C_TAG: '!';

//--- Block Scalar Indicators
// [16]	c-literal	::=	“|”
C_LITERAL: '|';

// [17]	c-folded	::=	“>”
C_FOLDED: '>';

//--- Quoted Scalar Indicators
// [18]	c-single-quote	::=	“'”
C_SINGLE_QUOTE: '\'';

// [19]	c-double-quote	::=	“"”
C_DOUBLE_QUOTE: '"';

// [20]	c-directive	::=	“%”
C_DIRECTIVE: '%';

// [21]	c-reserved	::=	“@” | “`”
C_RESERVED: [@`];

/*
[22]	c-indicator	::=	  “-” | “?” | “:” | “,” | “[” | “]” | “{” | “}”
            | “#” | “&” | “*” | “!” | “|” | “>” | “'” | “"”
            | “%” | “@” | “`”
*/
C_INDICATOR: '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'
             | '#' | '&' | '*' | '!' | '|' | '>' | '\'' | '"'
             | '%' | '@' | '`';

// [23]	c-flow-indicator	::=	“,” | “[” | “]” | “{” | “}”
C_FLOW_INDICATOR:   ',' | '[' | ']' | '{' | '}';

/*****************************************************************************
    5.4. Line Break Characters
*****************************************************************************/

// [24]	b-line-feed	::=	#xA    /* LF */
fragment B_LINE_FEED: '\u000A';

// [25]	b-carriage-return	::=	#xD    /* CR */
fragment B_CARRIADGE_RETURN: '\u000D';

// [26]	b-char	::=	b-line-feed | b-carriage-return
B_CHAR: B_LINE_FEED | B_CARRIADGE_RETURN;

// [27]	nb-char	::=	c-printable - b-char - c-byte-order-mark
NB_CHAR: '\u0009'
//      | '\u000a' | '\u000d'   // excluding B_CHAR
        | [\u0020-\u007e]
        | '\u0085' | [\u00a0-\ud7ff] /*| [\ue000-\ufffd]*/
        | [\ue000-\uefefe] | [\uf000-\ufffd] // excluding C_BYTE_ORDER_MARK: '\ufeff';
        | [\u{10000}-\u{10ffff}];

//  [28]	b-break	::=	  ( b-carriage-return b-line-feed ) /* DOS, Windows */
//                      | b-carriage-return                 /* MacOS upto 9.x */
//                      | b-line-feed                       /* UNIX, MacOS X */
B_BREAK: B_CARRIADGE_RETURN B_LINE_FEED
        | B_CARRIADGE_RETURN
        | B_LINE_FEED;

// [29]	b-as-line-feed	::=	b-break
B_AS_LINE_FEED:	B_BREAK;

// [30]	b-non-content	::=	b-break
B_NON_CONTENT: B_BREAK;

/*****************************************************************************
    5.5. White Space Characters
*****************************************************************************/

// [31]	s-space	::=	#x20 /* SP */
S_SPACE: '\u0020';

// [32]	s-tab	::=	#x9  /* TAB */
S_TAB: '\u0009';

// [33]	s-white	::=	s-space | s-tab
S_WHITE: S_SPACE | S_TAB;

// [34]	ns-char	::=	nb-char - s-white
NS_CHAR: ~[\u0020\u0009];

/*****************************************************************************
    5.6. Miscellaneous Characters
*****************************************************************************/

// [35]	ns-dec-digit	::=	[#x30-#x39] /* 0-9 */
NS_DEC_DIGIT: [\u0030-\u0039];

// [36]	ns-hex-digit	::=	  ns-dec-digit
//      | [#x41-#x46] /* A-F */ | [#x61-#x66] /* a-f */
NS_HEX_DIGIT: NS_DEC_DIGIT | [\u0041-\u0046] | [\u0061-\u0066];

// [37]	ns-ascii-letter	::=	[#x41-#x5A] /* A-Z */ | [#x61-#x7A] /* a-z */
NS_ASCII_LETTER: [\u0041-\u005a];

// [38]	ns-word-char	::=	ns-dec-digit | ns-ascii-letter | “-”
NS_WORD_CHAR: NS_DEC_DIGIT | NS_ASCII_LETTER;

/*
 [39] ns-uri-char	::=	  “%” ns-hex-digit ns-hex-digit | ns-word-char | “#”
                    | “;” | “/” | “?” | “:” | “@” | “&” | “=” | “+” | “$” | “,”
                    | “_” | “.” | “!” | “~” | “*” | “'” | “(” | “)” | “[” | “]”
*/
NS_URI_CHAR: '%' NS_HEX_DIGIT NS_HEX_DIGIT | NS_WORD_CHAR | '#'
                    | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
                    | '_' | '.' | '!' | '~' | '*' | '\'' | '(' | ')' | '[' | ']';

// [40]	ns-tag-char	::=	ns-uri-char - “!” - c-flow-indicator
NS_TAG_CHAR: '%' NS_HEX_DIGIT NS_HEX_DIGIT | NS_WORD_CHAR /*| '#'*/
                    | ';' | '/' | '?' | ':' | '@' | '&' | '=' | '+' | '$' | ','
                    | '_' | '.' | /*'!' |*/ '~' | '*' | '\'' | '(' | ')' | '[' | ']';


/*****************************************************************************
    5.7. Escaped Characters
*****************************************************************************/

// [42]	ns-esc-null	::=	“0”
NS_ESC_NULL: '0';

// [43]	ns-esc-bell	::=	“a”
NS_ESC_BELL: 'a';

// [44]	ns-esc-backspace	::=	“b”
NS_ESC_BACKSPACE: 'b';

// [45]	ns-esc-horizontal-tab	::=	“t” | #x9
NS_ESC_HORIZONTAL_TAB: 't' | '\u0009';

// [46]	ns-esc-line-feed	::=	“n”
NS_ESC_LINE_FEED: 'n';

// [47]	ns-esc-vertical-tab	::=	“v”
NS_ESC_VERTICAL_TAB: 'v';

// [48]	ns-esc-form-feed	::=	“f”
NS_ESC_FORM_FEED: 'f';

// [49]	ns-esc-carriage-return	::=	“r”
NS_ESC_CARRIAGE_RETURN: 'r';

// [50]	ns-esc-escape	::=	“e”
NS_ESC_ESCAPE: 'e';

// [51]	ns-esc-space	::=	#x20
NS_ESC_SPACE: '\u0020';

// [52]	ns-esc-double-quote	::=	“"”
NS_ESC_DOUBLE_QUOTE: '"';

// [53]	ns-esc-slash	::=	“/”
NS_ESC_SLASH: '/';

// [54]	ns-esc-backslash	::=	“\”
NS_ESC_BACKSLASH: '\\';

// [55]	ns-esc-next-line	::=	“N”
NS_ESC_NEXT_LINE: 'N';

// [56]	ns-esc-non-breaking-space	::=	“_”
NS_ESC_NON_BREAKING_SPACE: '_';

// [57]	ns-esc-line-separator	::=	“L”
NS_ESC_LINE_SEPARATOR: 'L';

// [58]	ns-esc-paragraph-separator	::=	“P”
NS_ESC_PARAGRAPH_SEPARATOR: 'P';

// [59]	ns-esc-8-bit	::=	“x” ( ns-hex-digit × 2 )
NS_ESC_8_BIT: 'x' NS_HEX_DIGIT NS_HEX_DIGIT;

// [60]	ns-esc-16-bit	::=	“u” ( ns-hex-digit × 4 )
NS_ESC_16_BIT: 'u' NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT;

// [61]	ns-esc-32-bit	::=	“U” ( ns-hex-digit × 8 )
NS_ESC_32_BIT: 'U' NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT NS_HEX_DIGIT;

/*
[62]	c-ns-esc-char	::=	“\”
                        ( ns-esc-null | ns-esc-bell | ns-esc-backspace
                        | ns-esc-horizontal-tab | ns-esc-line-feed
                        | ns-esc-vertical-tab | ns-esc-form-feed
                        | ns-esc-carriage-return | ns-esc-escape | ns-esc-space
                        | ns-esc-double-quote | ns-esc-slash | ns-esc-backslash
                        | ns-esc-next-line | ns-esc-non-breaking-space
                        | ns-esc-line-separator | ns-esc-paragraph-separator
                        | ns-esc-8-bit | ns-esc-16-bit | ns-esc-32-bit )
*/
C_NS_ESC_CHAR:	'\\'
                ( NS_ESC_NULL | NS_ESC_BELL | NS_ESC_BACKSPACE
                | NS_ESC_HORIZONTAL_TAB | NS_ESC_LINE_FEED
                | NS_ESC_VERTICAL_TAB | NS_ESC_FORM_FEED
                | NS_ESC_CARRIAGE_RETURN | NS_ESC_ESCAPE | NS_ESC_SPACE
                | NS_ESC_DOUBLE_QUOTE | NS_ESC_SLASH | NS_ESC_BACKSLASH
                | NS_ESC_NEXT_LINE | NS_ESC_NON_BREAKING_SPACE
                | NS_ESC_LINE_SEPARATOR | NS_ESC_PARAGRAPH_SEPARATOR
                | NS_ESC_8_BIT | NS_ESC_16_BIT | NS_ESC_32_BIT );



/*****************************************************************************
    Chapter 6. Basic Structures
    6.1. Indentation Spaces
*****************************************************************************/

// [63]	s-indent(n)	::=	s-space × n
S_INDENT_N01: S_SPACE;
S_INDENT_N02: S_INDENT_N01 S_SPACE;
S_INDENT_N03: S_INDENT_N02 S_SPACE;
S_INDENT_N04: S_INDENT_N03 S_SPACE;
S_INDENT_N05: S_INDENT_N04 S_SPACE;

// [64]	s-indent(<n)	::=	s-space × m /* Where m < n */
S_INDENT_LT_N02: S_INDENT_N01;
S_INDENT_LT_N03: S_INDENT_N01 | S_INDENT_N02;
S_INDENT_LT_N04: S_INDENT_N01 | S_INDENT_N02 | S_INDENT_N03;
S_INDENT_LT_N05: S_INDENT_N01 | S_INDENT_N02 | S_INDENT_N03 | S_INDENT_N04;

// [65]	s-indent(≤n)	::=	s-space × m /* Where m ≤ n */
S_INDENT_LE_N02: S_INDENT_LT_N02 | S_INDENT_N02;
S_INDENT_LE_N03: S_INDENT_LT_N03 | S_INDENT_N03;
S_INDENT_LE_N04: S_INDENT_LT_N04 | S_INDENT_N04;
S_INDENT_LE_N05: S_INDENT_LT_N05 | S_INDENT_N05;

/*****************************************************************************
    6.2. Separation Spaces
*****************************************************************************/
// [66]	s-separate-in-line	::=	s-white+ | /* Start of line */
S_SEPARATE_IN_LINE:	S_WHITE+; // | <Start of line>
//TODO how to express <Start of line>?!

/*****************************************************************************
    6.3. Line Prefixes
*****************************************************************************/
/*
Rule [67]	s-line-prefix(n,c)	::=	c = block-out ⇒ s-block-line-prefix(n)
                                    c = block-in  ⇒ s-block-line-prefix(n)
                                    c = flow-out  ⇒ s-flow-line-prefix(n)
                                    c = flow-in   ⇒ s-flow-line-prefix(n)
*/
S_LINE_PREFIX_N01_CBLOCKOUT: S_BLOCK_LINE_PREFIX_N01;
S_LINE_PREFIX_N02_CBLOCKOUT: S_BLOCK_LINE_PREFIX_N02;
S_LINE_PREFIX_N03_CBLOCKOUT: S_BLOCK_LINE_PREFIX_N03;
S_LINE_PREFIX_N04_CBLOCKOUT: S_BLOCK_LINE_PREFIX_N04;
S_LINE_PREFIX_N05_CBLOCKOUT: S_BLOCK_LINE_PREFIX_N05;

S_LINE_PREFIX_N01_CBLOCKIN: S_BLOCK_LINE_PREFIX_N01;
S_LINE_PREFIX_N02_CBLOCKIN: S_BLOCK_LINE_PREFIX_N02;
S_LINE_PREFIX_N03_CBLOCKIN: S_BLOCK_LINE_PREFIX_N03;
S_LINE_PREFIX_N04_CBLOCKIN: S_BLOCK_LINE_PREFIX_N04;
S_LINE_PREFIX_N05_CBLOCKIN: S_BLOCK_LINE_PREFIX_N05;

S_LINE_PREFIX_N01_CFLOWOUT: S_FLOW_LINE_PREFIX_N01;
S_LINE_PREFIX_N02_CFLOWOUT: S_FLOW_LINE_PREFIX_N02;
S_LINE_PREFIX_N03_CFLOWOUT: S_FLOW_LINE_PREFIX_N03;
S_LINE_PREFIX_N04_CFLOWOUT: S_FLOW_LINE_PREFIX_N04;
S_LINE_PREFIX_N05_CFLOWOUT: S_FLOW_LINE_PREFIX_N05;

S_LINE_PREFIX_N01_CFLOWIN: S_FLOW_LINE_PREFIX_N01;
S_LINE_PREFIX_N02_CFLOWIN: S_FLOW_LINE_PREFIX_N02;
S_LINE_PREFIX_N03_CFLOWIN: S_FLOW_LINE_PREFIX_N03;
S_LINE_PREFIX_N04_CFLOWIN: S_FLOW_LINE_PREFIX_N04;
S_LINE_PREFIX_N05_CFLOWIN: S_FLOW_LINE_PREFIX_N05;

// [68]	s-block-line-prefix(n)	::=	s-indent(n)
S_BLOCK_LINE_PREFIX_N01: S_INDENT_N01;
S_BLOCK_LINE_PREFIX_N02: S_INDENT_N02;
S_BLOCK_LINE_PREFIX_N03: S_INDENT_N03;
S_BLOCK_LINE_PREFIX_N04: S_INDENT_N04;
S_BLOCK_LINE_PREFIX_N05: S_INDENT_N05;

// [69]	s-flow-line-prefix(n)	::=	s-indent(n) s-separate-in-line?
S_FLOW_LINE_PREFIX_N01: S_INDENT_N01 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_N02: S_INDENT_N02 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_N03: S_INDENT_N03 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_N04: S_INDENT_N04 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_N05: S_INDENT_N05 S_SEPARATE_IN_LINE?;

/*****************************************************************************
    6.4. Empty Lines
*****************************************************************************/

// [70]	l-empty(n,c)	::=	( s-line-prefix(n,c) | s-indent(<n) ) b-as-line-feed
L_EMPTY_N01_CBLOCKIN: (S_BLOCK_LINE_PREFIX_N01)? B_AS_LINE_FEED;
L_EMPTY_N02_CBLOCKIN: (S_BLOCK_LINE_PREFIX_N02 | S_INDENT_LT_N02) B_AS_LINE_FEED;
L_EMPTY_N03_CBLOCKIN: (S_BLOCK_LINE_PREFIX_N03 | S_INDENT_LT_N03) B_AS_LINE_FEED;
L_EMPTY_N04_CBLOCKIN: (S_BLOCK_LINE_PREFIX_N04 | S_INDENT_LT_N04) B_AS_LINE_FEED;
L_EMPTY_N05_CBLOCKIN: (S_BLOCK_LINE_PREFIX_N05 | S_INDENT_LT_N05) B_AS_LINE_FEED;

L_EMPTY_N01_CBLOCKOUT: (S_BLOCK_LINE_PREFIX_N01)? B_AS_LINE_FEED;
L_EMPTY_N02_CBLOCKOUT: (S_BLOCK_LINE_PREFIX_N02 | S_INDENT_LT_N02) B_AS_LINE_FEED;
L_EMPTY_N03_CBLOCKOUT: (S_BLOCK_LINE_PREFIX_N03 | S_INDENT_LT_N03) B_AS_LINE_FEED;
L_EMPTY_N04_CBLOCKOUT: (S_BLOCK_LINE_PREFIX_N04 | S_INDENT_LT_N04) B_AS_LINE_FEED;
L_EMPTY_N05_CBLOCKOUT: (S_BLOCK_LINE_PREFIX_N05 | S_INDENT_LT_N05) B_AS_LINE_FEED;

L_EMPTY_N01_CFLOWIN: (S_FLOW_LINE_PREFIX_N01)? B_AS_LINE_FEED;
L_EMPTY_N02_CFLOWIN: (S_FLOW_LINE_PREFIX_N02 | S_INDENT_LT_N02) B_AS_LINE_FEED;
L_EMPTY_N03_CFLOWIN: (S_FLOW_LINE_PREFIX_N03 | S_INDENT_LT_N03) B_AS_LINE_FEED;
L_EMPTY_N04_CFLOWIN: (S_FLOW_LINE_PREFIX_N04 | S_INDENT_LT_N04) B_AS_LINE_FEED;
L_EMPTY_N05_CFLOWIN: (S_FLOW_LINE_PREFIX_N05 | S_INDENT_LT_N05) B_AS_LINE_FEED;

L_EMPTY_N01_CFLOWOUT: (S_FLOW_LINE_PREFIX_N01)? B_AS_LINE_FEED;
L_EMPTY_N02_CFLOWOUT: (S_FLOW_LINE_PREFIX_N02 | S_INDENT_LT_N02) B_AS_LINE_FEED;
L_EMPTY_N03_CFLOWOUT: (S_FLOW_LINE_PREFIX_N03 | S_INDENT_LT_N03) B_AS_LINE_FEED;
L_EMPTY_N04_CFLOWOUT: (S_FLOW_LINE_PREFIX_N04 | S_INDENT_LT_N04) B_AS_LINE_FEED;
L_EMPTY_N05_CFLOWOUT: (S_FLOW_LINE_PREFIX_N05 | S_INDENT_LT_N05) B_AS_LINE_FEED;


/*****************************************************************************
    6.5. Line Folding
*****************************************************************************/

// [71]	b-l-trimmed(n,c)	::=	b-non-content l-empty(n,c)+
B_L_TRIMMED_N01_CBLOCKIN: B_NON_CONTENT L_EMPTY_N01_CBLOCKIN+;
B_L_TRIMMED_N02_CBLOCKIN: B_NON_CONTENT L_EMPTY_N02_CBLOCKIN+;
B_L_TRIMMED_N03_CBLOCKIN: B_NON_CONTENT L_EMPTY_N03_CBLOCKIN+;
B_L_TRIMMED_N04_CBLOCKIN: B_NON_CONTENT L_EMPTY_N04_CBLOCKIN+;
B_L_TRIMMED_N05_CBLOCKIN: B_NON_CONTENT L_EMPTY_N05_CBLOCKIN+;

B_L_TRIMMED_N01_CBLOCKOUT: B_NON_CONTENT L_EMPTY_N01_CBLOCKOUT+;
B_L_TRIMMED_N02_CBLOCKOUT: B_NON_CONTENT L_EMPTY_N02_CBLOCKOUT+;
B_L_TRIMMED_N03_CBLOCKOUT: B_NON_CONTENT L_EMPTY_N03_CBLOCKOUT+;
B_L_TRIMMED_N04_CBLOCKOUT: B_NON_CONTENT L_EMPTY_N04_CBLOCKOUT+;
B_L_TRIMMED_N05_CBLOCKOUT: B_NON_CONTENT L_EMPTY_N05_CBLOCKOUT+;

B_L_TRIMMED_N01_CFLOWIN: B_NON_CONTENT L_EMPTY_N01_CFLOWIN+;
B_L_TRIMMED_N02_CFLOWIN: B_NON_CONTENT L_EMPTY_N02_CFLOWIN+;
B_L_TRIMMED_N03_CFLOWIN: B_NON_CONTENT L_EMPTY_N03_CFLOWIN+;
B_L_TRIMMED_N04_CFLOWIN: B_NON_CONTENT L_EMPTY_N04_CFLOWIN+;
B_L_TRIMMED_N05_CFLOWIN: B_NON_CONTENT L_EMPTY_N05_CFLOWIN+;

B_L_TRIMMED_N01_CFLOWOUT: B_NON_CONTENT L_EMPTY_N01_CFLOWOUT+;
B_L_TRIMMED_N02_CFLOWOUT: B_NON_CONTENT L_EMPTY_N02_CFLOWOUT+;
B_L_TRIMMED_N03_CFLOWOUT: B_NON_CONTENT L_EMPTY_N03_CFLOWOUT+;
B_L_TRIMMED_N04_CFLOWOUT: B_NON_CONTENT L_EMPTY_N04_CFLOWOUT+;
B_L_TRIMMED_N05_CFLOWOUT: B_NON_CONTENT L_EMPTY_N05_CFLOWOUT+;

// [72]	b-as-space	::=	b-break
B_AS_SPACE: B_BREAK;

// [73]	b-l-folded(n,c)	::=	b-l-trimmed(n,c) | b-as-space
B_L_FOLDED_N01_CBLOCKIN: B_L_TRIMMED_N01_CBLOCKIN | B_AS_SPACE;
B_L_FOLDED_N02_CBLOCKIN: B_L_TRIMMED_N02_CBLOCKIN | B_AS_SPACE;
B_L_FOLDED_N03_CBLOCKIN: B_L_TRIMMED_N03_CBLOCKIN | B_AS_SPACE;
B_L_FOLDED_N04_CBLOCKIN: B_L_TRIMMED_N04_CBLOCKIN | B_AS_SPACE;
B_L_FOLDED_N05_CBLOCKIN: B_L_TRIMMED_N05_CBLOCKIN | B_AS_SPACE;

B_L_FOLDED_N01_CBLOCKOUT: B_L_TRIMMED_N01_CBLOCKOUT | B_AS_SPACE;
B_L_FOLDED_N02_CBLOCKOUT: B_L_TRIMMED_N02_CBLOCKOUT | B_AS_SPACE;
B_L_FOLDED_N03_CBLOCKOUT: B_L_TRIMMED_N03_CBLOCKOUT | B_AS_SPACE;
B_L_FOLDED_N04_CBLOCKOUT: B_L_TRIMMED_N04_CBLOCKOUT | B_AS_SPACE;
B_L_FOLDED_N05_CBLOCKOUT: B_L_TRIMMED_N05_CBLOCKOUT | B_AS_SPACE;

B_L_FOLDED_N01_CFLOWIN: B_L_TRIMMED_N01_CFLOWIN | B_AS_SPACE;
B_L_FOLDED_N02_CFLOWIN: B_L_TRIMMED_N02_CFLOWIN | B_AS_SPACE;
B_L_FOLDED_N03_CFLOWIN: B_L_TRIMMED_N03_CFLOWIN | B_AS_SPACE;
B_L_FOLDED_N04_CFLOWIN: B_L_TRIMMED_N04_CFLOWIN | B_AS_SPACE;
B_L_FOLDED_N05_CFLOWIN: B_L_TRIMMED_N05_CFLOWIN | B_AS_SPACE;

B_L_FOLDED_N01_CFLOWOUT: B_L_TRIMMED_N01_CFLOWOUT | B_AS_SPACE;
B_L_FOLDED_N02_CFLOWOUT: B_L_TRIMMED_N02_CFLOWOUT | B_AS_SPACE;
B_L_FOLDED_N03_CFLOWOUT: B_L_TRIMMED_N03_CFLOWOUT | B_AS_SPACE;
B_L_FOLDED_N04_CFLOWOUT: B_L_TRIMMED_N04_CFLOWOUT | B_AS_SPACE;
B_L_FOLDED_N05_CFLOWOUT: B_L_TRIMMED_N05_CFLOWOUT | B_AS_SPACE;

// [74]	s-flow-folded(n)	::=	s-separate-in-line? b-l-folded(n,flow-in) s-flow-line-prefix(n)
S_FLOW_FOLDED_N01: S_SEPARATE_IN_LINE? B_L_FOLDED_N01_CFLOWIN S_FLOW_LINE_PREFIX_N01;
S_FLOW_FOLDED_N02: S_SEPARATE_IN_LINE? B_L_FOLDED_N02_CFLOWIN S_FLOW_LINE_PREFIX_N02;
S_FLOW_FOLDED_N03: S_SEPARATE_IN_LINE? B_L_FOLDED_N03_CFLOWIN S_FLOW_LINE_PREFIX_N03;
S_FLOW_FOLDED_N04: S_SEPARATE_IN_LINE? B_L_FOLDED_N04_CFLOWIN S_FLOW_LINE_PREFIX_N04;
S_FLOW_FOLDED_N05: S_SEPARATE_IN_LINE? B_L_FOLDED_N05_CFLOWIN S_FLOW_LINE_PREFIX_N05;

/*****************************************************************************
    6.6. Comments
*****************************************************************************/

// [75]	c-nb-comment-text	::=	“#” nb-char*
C_NB_COMMENT_TEXT: '#' NB_CHAR*;

// [76]	b-comment	::=	b-non-content | /* End of file */
B_COMMENT: B_NON_CONTENT | EOF; // TODO check about EOF

// [77]	s-b-comment	::=	( s-separate-in-line c-nb-comment-text? )? b-comment
S_B_COMMENT: (S_SEPARATE_IN_LINE C_NB_COMMENT_TEXT?)? B_COMMENT;

// [78]	l-comment	::=	s-separate-in-line c-nb-comment-text? b-comment
L_COMMENT: S_SEPARATE_IN_LINE C_NB_COMMENT_TEXT? B_COMMENT;

// [79]	s-l-comments	::=	( s-b-comment | /* Start of line */ ) l-comment*
S_L_COMMENTS: (S_B_COMMENT /*| START_OF_LINE */) L_COMMENT*; // TODO find a way to express START_OF_LINE

/*****************************************************************************
    6.7. Separation Lines
*****************************************************************************/

// [80]	s-separate(n,c)	::=	c = block-out ⇒ s-separate-lines(n)
//                          c = block-in  ⇒ s-separate-lines(n)
//                          c = flow-out  ⇒ s-separate-lines(n)
//                          c = flow-in   ⇒ s-separate-lines(n)
//                          c = block-key ⇒ s-separate-in-line
//                          c = flow-key  ⇒ s-separate-in-line
S_SEPARATE_N01_CBLOCKOUT: S_SEPARATE_LINES_N01;
S_SEPARATE_N02_CBLOCKOUT: S_SEPARATE_LINES_N02;
S_SEPARATE_N03_CBLOCKOUT: S_SEPARATE_LINES_N03;
S_SEPARATE_N04_CBLOCKOUT: S_SEPARATE_LINES_N04;
S_SEPARATE_N05_CBLOCKOUT: S_SEPARATE_LINES_N05;

S_SEPARATE_N01_CBLOCKIN: S_SEPARATE_LINES_N01;
S_SEPARATE_N02_CBLOCKIN: S_SEPARATE_LINES_N02;
S_SEPARATE_N03_CBLOCKIN: S_SEPARATE_LINES_N03;
S_SEPARATE_N04_CBLOCKIN: S_SEPARATE_LINES_N04;
S_SEPARATE_N05_CBLOCKIN: S_SEPARATE_LINES_N05;

S_SEPARATE_N01_CFLOWOUT: S_SEPARATE_LINES_N01;
S_SEPARATE_N02_CFLOWOUT: S_SEPARATE_LINES_N02;
S_SEPARATE_N03_CFLOWOUT: S_SEPARATE_LINES_N03;
S_SEPARATE_N04_CFLOWOUT: S_SEPARATE_LINES_N04;
S_SEPARATE_N05_CFLOWOUT: S_SEPARATE_LINES_N05;

S_SEPARATE_N01_CFLOWIN: S_SEPARATE_LINES_N01;
S_SEPARATE_N02_CFLOWIN: S_SEPARATE_LINES_N02;
S_SEPARATE_N03_CFLOWIN: S_SEPARATE_LINES_N03;
S_SEPARATE_N04_CFLOWIN: S_SEPARATE_LINES_N04;
S_SEPARATE_N05_CFLOWIN: S_SEPARATE_LINES_N05;

S_SEPARATE_CBLOCKKEY: S_SEPARATE_IN_LINE;
S_SEPARATE_CFLOWKEY: S_SEPARATE_IN_LINE;

// [81]	s-separate-lines(n)	::=	( s-l-comments s-flow-line-prefix(n) )
//                          | s-separate-in-line
S_SEPARATE_LINES_N01: (S_L_COMMENTS S_FLOW_LINE_PREFIX_N01) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_N02: (S_L_COMMENTS S_FLOW_LINE_PREFIX_N02) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_N03: (S_L_COMMENTS S_FLOW_LINE_PREFIX_N03) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_N04: (S_L_COMMENTS S_FLOW_LINE_PREFIX_N04) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_N05: (S_L_COMMENTS S_FLOW_LINE_PREFIX_N05) | S_SEPARATE_IN_LINE;

/*****************************************************************************
    6.8. Directives
*****************************************************************************/
// [82]	l-directive	::=	“%”
//  ( ns-yaml-directive
//  | ns-tag-directive
//  | ns-reserved-directive )
//  s-l-comments
L_DIRECTIVE: '%' (NS_YAML_DIRECTIVE | NS_TAG_DIRECTIVE | NS_RESERVED_DIRECTIVE) S_L_COMMENTS;

//--- Reserved Directives
// [83]	ns-reserved-directive ::= ns-directive-name
//                            ( s-separate-in-line ns-directive-parameter )*
NS_RESERVED_DIRECTIVE: NS_DIRECTIVE_NAME (S_SEPARATE_IN_LINE NS_DIRECTIVE_PARAMETER)*;

// [84]	ns-directive-name ::= ns-char+
NS_DIRECTIVE_NAME: NS_CHAR+;

// [85]	ns-directive-parameter ::= ns-char+
NS_DIRECTIVE_PARAMETER: NS_CHAR+;

//--- “YAML” Directives
// [86]	ns-yaml-directive ::= “Y” “A” “M” “L” s-separate-in-line ns-yaml-version
NS_YAML_DIRECTIVE: 'Y' 'A' 'M' 'L' S_SEPARATE_IN_LINE NS_YAML_VERSION;

// [87]	ns-yaml-version	::=	ns-dec-digit+ “.” ns-dec-digit+
NS_YAML_VERSION: NS_DEC_DIGIT+ '.' NS_DEC_DIGIT+;

//--- “TAG” directive
// [88]	ns-tag-directive	::=	“T” “A” “G”
//                          s-separate-in-line c-tag-handle
//                          s-separate-in-line ns-tag-prefix
NS_TAG_DIRECTIVE: 'T' 'A' 'G' S_SEPARATE_IN_LINE C_TAG_HANDLE S_SEPARATE_IN_LINE NS_TAG_PREFIX;

//--- Tag Handles
// [89]	c-tag-handle	::=	  c-named-tag-handle
//                      | c-secondary-tag-handle
//                      | c-primary-tag-handle
C_TAG_HANDLE: C_NAMED_TAG_HANDLE | C_SECONDARY_TAG_HANDLE | C_PRIMARY_TAG_HANDLE;

// [90]	c-primary-tag-handle	::=	“!”
C_PRIMARY_TAG_HANDLE: '!';

// [91]	c-secondary-tag-handle	::=	“!” “!”
C_SECONDARY_TAG_HANDLE: '!' '!';

// [92]	c-named-tag-handle	::=	“!” ns-word-char+ “!”
C_NAMED_TAG_HANDLE: '!' NS_WORD_CHAR+ '!';

//--- Tag Prefixes
// [93]	ns-tag-prefix	::=	c-ns-local-tag-prefix | ns-global-tag-prefix
NS_TAG_PREFIX: C_NS_LOCAL_TAG_PREFIX | NS_GLOBAL_TAG_PREFIX;

// [94]	c-ns-local-tag-prefix	::=	“!” ns-uri-char*
C_NS_LOCAL_TAG_PREFIX: '!' NS_URI_CHAR*;

// [95]	ns-global-tag-prefix	::=	ns-tag-char ns-uri-char*
NS_GLOBAL_TAG_PREFIX: NS_TAG_CHAR NS_URI_CHAR*;

//--- Node Properties
//  [96]	c-ns-properties(n,c)	::=	  ( c-ns-tag-property ( s-separate(n,c) c-ns-anchor-property )? )
//                                  | ( c-ns-anchor-property ( s-separate(n,c) c-ns-tag-property )? )
C_NS_PROPERTIES_N01_CFLOWOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N01_CFLOWOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N01_CFLOWOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CFLOWOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N02_CFLOWOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N02_CFLOWOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CFLOWOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N03_CFLOWOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N03_CFLOWOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CFLOWOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N04_CFLOWOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N04_CFLOWOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CFLOWOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N05_CFLOWOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N05_CFLOWOUT C_NS_TAG_PROPERTY)?);

C_NS_PROPERTIES_N01_CFLOWIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N01_CFLOWIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N01_CFLOWIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CFLOWIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N02_CFLOWIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N02_CFLOWIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CFLOWIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N03_CFLOWIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N03_CFLOWIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CFLOWIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N04_CFLOWIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N04_CFLOWIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CFLOWIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N05_CFLOWIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N05_CFLOWIN C_NS_TAG_PROPERTY)?);

C_NS_PROPERTIES_N01_CBLOCKOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N01_CBLOCKOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N01_CBLOCKOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CBLOCKOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N02_CBLOCKOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N02_CBLOCKOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CBLOCKOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N03_CBLOCKOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N03_CBLOCKOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CBLOCKOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N04_CBLOCKOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N04_CBLOCKOUT C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CBLOCKOUT: (C_NS_TAG_PROPERTY (S_SEPARATE_N05_CBLOCKOUT C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N05_CBLOCKOUT C_NS_TAG_PROPERTY)?);

C_NS_PROPERTIES_N01_CBLOCKIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N01_CBLOCKIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N01_CBLOCKIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CBLOCKIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N02_CBLOCKIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N02_CBLOCKIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CBLOCKIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N03_CBLOCKIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N03_CBLOCKIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CBLOCKIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N04_CBLOCKIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N04_CBLOCKIN C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CBLOCKIN: (C_NS_TAG_PROPERTY (S_SEPARATE_N05_CBLOCKIN C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_N05_CBLOCKIN C_NS_TAG_PROPERTY)?);

C_NS_PROPERTIES_N01_CBLOCKKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CBLOCKKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CBLOCKKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CBLOCKKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CBLOCKKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CBLOCKKEY C_NS_TAG_PROPERTY)?);

C_NS_PROPERTIES_N01_CFLOWKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N02_CFLOWKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N03_CFLOWKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N04_CFLOWKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_TAG_PROPERTY)?);
C_NS_PROPERTIES_N05_CFLOWKEY: (C_NS_TAG_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_ANCHOR_PROPERTY)? )
                            | (C_NS_ANCHOR_PROPERTY (S_SEPARATE_CFLOWKEY C_NS_TAG_PROPERTY)?);


//--- Node Tags
// [97]	c-ns-tag-property	::=	  c-verbatim-tag
//                          | c-ns-shorthand-tag
//                          | c-non-specific-tag
C_NS_TAG_PROPERTY: C_VERBATIM_TAG | C_NS_SHORTHAND_TAG | C_NON_SPECIFIC_TAG;

// [98]	c-verbatim-tag	::=	“!” “<” ns-uri-char+ “>”
C_VERBATIM_TAG: '!' '<' NS_URI_CHAR+ '>';

// [99]	c-ns-shorthand-tag	::=	c-tag-handle ns-tag-char+
C_NS_SHORTHAND_TAG: C_TAG_HANDLE NS_TAG_CHAR+;

// [100]	c-non-specific-tag	::=	“!”
C_NON_SPECIFIC_TAG: '!';

//--- Node Anchors
// [101]	c-ns-anchor-property	::=	“&” ns-anchor-name
C_NS_ANCHOR_PROPERTY: '&' NS_ANCHOR_NAME;

// [102]	ns-anchor-char	::=	ns-char - c-flow-indicator
NS_ANCHOR_CHAR: ~([\u0020\u0009] | ',' | '[' | ']' | '{' | '}');

// [103]	ns-anchor-name	::=	ns-anchor-char+
NS_ANCHOR_NAME: NS_ANCHOR_CHAR+;

/*****************************************************************************
    Chapter 7. Flow Styles
    7.1. Alias Nodes
*****************************************************************************/

// [104]	c-ns-alias-node	::=	“*” ns-anchor-name
C_NS_ALIAS_NODE: '*' NS_ANCHOR_NAME;

//--- Empty Nodes
// [105]	e-scalar	::=	/* Empty */
fragment E_SCALAR:;

// [106]	e-node	::=	e-scalar
fragment E_NODE: E_SCALAR;  // Completely Empty Flow Nodes


/*****************************************************************************
    7.3. Flow Scalar Styles
*****************************************************************************/

//--- Double-Quoted Style
// [107]	nb-double-char	::=	c-ns-esc-char | ( nb-json - “\” - “"” )
NB_DOUBLE_CHAR: C_NS_ESC_CHAR
                | '\u0020'..'\u0021'
                // exclude \u0022 /* double quote */
                | '\u0023'..'\u005b'
                // exclude \u005c /* backslash */
                | '\u005d'..'\u{10ffff}';

// [108]	ns-double-char	::=	nb-double-char - s-white
// NS_DOUBLE_CHAR: NB_DOUBLE_CHAR - S_WHITE;
NS_DOUBLE_CHAR: C_NS_ESC_CHAR
                //  exclude space x20
                | '\u0021'
                // exclude \u0022 /* double quote */
                | '\u0023'..'\u005b'
                // exclude \u005c /* backslash */
                | '\u005d'..'\u{10ffff}';

// [109]	c-double-quoted(n,c)	::=	“"” nb-double-text(n,c) “"”
C_DOUBLE_QUOTED_N01_CFLOWOUT: '"' NB_DOUBLE_TEXT_N01_CFLOWOUT '"';
C_DOUBLE_QUOTED_N02_CFLOWOUT: '"' NB_DOUBLE_TEXT_N02_CFLOWOUT '"';
C_DOUBLE_QUOTED_N03_CFLOWOUT: '"' NB_DOUBLE_TEXT_N03_CFLOWOUT '"';
C_DOUBLE_QUOTED_N04_CFLOWOUT: '"' NB_DOUBLE_TEXT_N04_CFLOWOUT '"';
C_DOUBLE_QUOTED_N05_CFLOWOUT: '"' NB_DOUBLE_TEXT_N05_CFLOWOUT '"';

C_DOUBLE_QUOTED_N01_CFLOWIN: '"' NB_DOUBLE_TEXT_N01_CFLOWIN '"';
C_DOUBLE_QUOTED_N02_CFLOWIN: '"' NB_DOUBLE_TEXT_N02_CFLOWIN '"';
C_DOUBLE_QUOTED_N03_CFLOWIN: '"' NB_DOUBLE_TEXT_N03_CFLOWIN '"';
C_DOUBLE_QUOTED_N04_CFLOWIN: '"' NB_DOUBLE_TEXT_N04_CFLOWIN '"';
C_DOUBLE_QUOTED_N05_CFLOWIN: '"' NB_DOUBLE_TEXT_N05_CFLOWIN '"';

C_DOUBLE_QUOTED_N01_CBLOCKKEY: '"' NB_DOUBLE_TEXT_N01_CBLOCKKEY '"';
C_DOUBLE_QUOTED_N02_CBLOCKKEY: '"' NB_DOUBLE_TEXT_N02_CBLOCKKEY '"';
C_DOUBLE_QUOTED_N03_CBLOCKKEY: '"' NB_DOUBLE_TEXT_N03_CBLOCKKEY '"';
C_DOUBLE_QUOTED_N04_CBLOCKKEY: '"' NB_DOUBLE_TEXT_N04_CBLOCKKEY '"';
C_DOUBLE_QUOTED_N05_CBLOCKKEY: '"' NB_DOUBLE_TEXT_N05_CBLOCKKEY '"';

C_DOUBLE_QUOTED_N01_CFLOWKEY: '"' NB_DOUBLE_TEXT_N01_CFLOWKEY '"';
C_DOUBLE_QUOTED_N02_CFLOWKEY: '"' NB_DOUBLE_TEXT_N02_CFLOWKEY '"';
C_DOUBLE_QUOTED_N03_CFLOWKEY: '"' NB_DOUBLE_TEXT_N03_CFLOWKEY '"';
C_DOUBLE_QUOTED_N04_CFLOWKEY: '"' NB_DOUBLE_TEXT_N04_CFLOWKEY '"';
C_DOUBLE_QUOTED_N05_CFLOWKEY: '"' NB_DOUBLE_TEXT_N05_CFLOWKEY '"';

// [110]	nb-double-text(n,c)	::=	c = flow-out  ⇒ nb-double-multi-line(n)
//                              c = flow-in   ⇒ nb-double-multi-line(n)
//                              c = block-key ⇒ nb-double-one-line
//                              c = flow-key  ⇒ nb-double-one-line
fragment NB_DOUBLE_TEXT_N01_CFLOWOUT: NB_DOUBLE_MULTI_LINE_N01;
fragment NB_DOUBLE_TEXT_N02_CFLOWOUT: NB_DOUBLE_MULTI_LINE_N02;
fragment NB_DOUBLE_TEXT_N03_CFLOWOUT: NB_DOUBLE_MULTI_LINE_N03;
fragment NB_DOUBLE_TEXT_N04_CFLOWOUT: NB_DOUBLE_MULTI_LINE_N04;
fragment NB_DOUBLE_TEXT_N05_CFLOWOUT: NB_DOUBLE_MULTI_LINE_N05;

fragment NB_DOUBLE_TEXT_N01_CFLOWIN: NB_DOUBLE_MULTI_LINE_N01;
fragment NB_DOUBLE_TEXT_N02_CFLOWIN: NB_DOUBLE_MULTI_LINE_N02;
fragment NB_DOUBLE_TEXT_N03_CFLOWIN: NB_DOUBLE_MULTI_LINE_N03;
fragment NB_DOUBLE_TEXT_N04_CFLOWIN: NB_DOUBLE_MULTI_LINE_N04;
fragment NB_DOUBLE_TEXT_N05_CFLOWIN: NB_DOUBLE_MULTI_LINE_N05;

fragment NB_DOUBLE_TEXT_N01_CBLOCKKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N02_CBLOCKKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N03_CBLOCKKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N04_CBLOCKKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N05_CBLOCKKEY: NB_DOUBLE_ONE_LINE;

fragment NB_DOUBLE_TEXT_N01_CFLOWKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N02_CFLOWKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N03_CFLOWKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N04_CFLOWKEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_N05_CFLOWKEY: NB_DOUBLE_ONE_LINE;

// [111]	nb-double-one-line	::=	nb-double-char*
fragment NB_DOUBLE_ONE_LINE: NB_DOUBLE_CHAR*;

// [112]	s-double-escaped(n)	::=	s-white* “\” b-non-content
//                              l-empty(n,flow-in)* s-flow-line-prefix(n)
S_DOUBLE_ESCAPED_N01: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_N01_CFLOWIN* S_FLOW_LINE_PREFIX_N01;
S_DOUBLE_ESCAPED_N02: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_N02_CFLOWIN* S_FLOW_LINE_PREFIX_N02;
S_DOUBLE_ESCAPED_N03: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_N03_CFLOWIN* S_FLOW_LINE_PREFIX_N03;
S_DOUBLE_ESCAPED_N04: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_N04_CFLOWIN* S_FLOW_LINE_PREFIX_N04;
S_DOUBLE_ESCAPED_N05: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_N05_CFLOWIN* S_FLOW_LINE_PREFIX_N05;

// [113]	s-double-break(n)	::=	s-double-escaped(n) | s-flow-folded(n)
S_DOUBLE_BREAK_N01: S_DOUBLE_ESCAPED_N01 | S_FLOW_FOLDED_N01;
S_DOUBLE_BREAK_N02: S_DOUBLE_ESCAPED_N02 | S_FLOW_FOLDED_N02;
S_DOUBLE_BREAK_N03: S_DOUBLE_ESCAPED_N03 | S_FLOW_FOLDED_N03;
S_DOUBLE_BREAK_N04: S_DOUBLE_ESCAPED_N04 | S_FLOW_FOLDED_N04;
S_DOUBLE_BREAK_N05: S_DOUBLE_ESCAPED_N05 | S_FLOW_FOLDED_N05;

// [114]	nb-ns-double-in-line	::=	( s-white* ns-double-char )*
fragment NB_NS_DOUBLE_IN_LINE: (S_WHITE NS_DOUBLE_CHAR)*;

// [115]	s-double-next-line(n)	::=	s-double-break(n)
//                                  ( ns-double-char nb-ns-double-in-line
//                                  ( s-double-next-line(n) | s-white* ) )?
S_DOUBLE_NEXT_LINE_N01: S_DOUBLE_BREAK_N01
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_N01 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_N02: S_DOUBLE_BREAK_N02
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_N02 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_N03: S_DOUBLE_BREAK_N03
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_N03 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_N04: S_DOUBLE_BREAK_N04
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_N04 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_N05: S_DOUBLE_BREAK_N05
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_N05 | S_WHITE*))?;

// [116]	nb-double-multi-line(n)	::=	nb-ns-double-in-line
//                                  (s-double-next-line(n) | s-white* )
fragment NB_DOUBLE_MULTI_LINE_N01: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_N01 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_N02: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_N02 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_N03: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_N03 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_N04: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_N04 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_N05: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_N05 | S_WHITE*);

//--- Single-Quoted Style
// [117]	c-quoted-quote	::=	“'” “'”
C_QUOTED_QUOTE: '\'' '\'';

// [118]	nb-single-char	::=	c-quoted-quote | ( nb-json - “'” )
NB_SINGLE_CHAR: C_QUOTED_QUOTE
                | '\u0009'
                | '\u0020'..'\u0026'
                // exclude x27 single quote
                | '\u0028'..'\u{10ffff}';

// [119]	ns-single-char	::=	nb-single-char - s-white
NS_SINGLE_CHAR: C_QUOTED_QUOTE
                // | '\u0009' - exclude tab
                | '\u0021'..'\u0026'  // exclude x20 space
                // exclude x27 single quote
                | '\u0028'..'\u{10ffff}';
                
// [120]	c-single-quoted(n,c)	::=	“'” nb-single-text(n,c) “'”
C_SINGLE_QUOTED_N01_CFLOWOUT: '\'' NB_SINGLE_TEXT_N01_CFLOWOUT '\'';
C_SINGLE_QUOTED_N02_CFLOWOUT: '\'' NB_SINGLE_TEXT_N02_CFLOWOUT '\'';
C_SINGLE_QUOTED_N03_CFLOWOUT: '\'' NB_SINGLE_TEXT_N03_CFLOWOUT '\'';
C_SINGLE_QUOTED_N04_CFLOWOUT: '\'' NB_SINGLE_TEXT_N04_CFLOWOUT '\'';
C_SINGLE_QUOTED_N05_CFLOWOUT: '\'' NB_SINGLE_TEXT_N05_CFLOWOUT '\'';

C_SINGLE_QUOTED_N01_CFLOWIN: '\'' NB_SINGLE_TEXT_N01_CFLOWIN '\'';
C_SINGLE_QUOTED_N02_CFLOWIN: '\'' NB_SINGLE_TEXT_N02_CFLOWIN '\'';
C_SINGLE_QUOTED_N03_CFLOWIN: '\'' NB_SINGLE_TEXT_N03_CFLOWIN '\'';
C_SINGLE_QUOTED_N04_CFLOWIN: '\'' NB_SINGLE_TEXT_N04_CFLOWIN '\'';
C_SINGLE_QUOTED_N05_CFLOWIN: '\'' NB_SINGLE_TEXT_N05_CFLOWIN '\'';

C_SINGLE_QUOTED_N01_CBLOCKKEY: '\'' NB_SINGLE_TEXT_N01_CBLOCKKEY '\'';
C_SINGLE_QUOTED_N02_CBLOCKKEY: '\'' NB_SINGLE_TEXT_N02_CBLOCKKEY '\'';
C_SINGLE_QUOTED_N03_CBLOCKKEY: '\'' NB_SINGLE_TEXT_N03_CBLOCKKEY '\'';
C_SINGLE_QUOTED_N04_CBLOCKKEY: '\'' NB_SINGLE_TEXT_N04_CBLOCKKEY '\'';
C_SINGLE_QUOTED_N05_CBLOCKKEY: '\'' NB_SINGLE_TEXT_N05_CBLOCKKEY '\'';

C_SINGLE_QUOTED_N01_CFLOWKEY: '\'' NB_SINGLE_TEXT_N01_CFLOWKEY '\'';
C_SINGLE_QUOTED_N02_CFLOWKEY: '\'' NB_SINGLE_TEXT_N02_CFLOWKEY '\'';
C_SINGLE_QUOTED_N03_CFLOWKEY: '\'' NB_SINGLE_TEXT_N03_CFLOWKEY '\'';
C_SINGLE_QUOTED_N04_CFLOWKEY: '\'' NB_SINGLE_TEXT_N04_CFLOWKEY '\'';
C_SINGLE_QUOTED_N05_CFLOWKEY: '\'' NB_SINGLE_TEXT_N05_CFLOWKEY '\'';

// [121]	nb-single-text(n,c)	::=	c = flow-out  ⇒ nb-single-multi-line(n)
//                              c = flow-in   ⇒ nb-single-multi-line(n)
//                              c = block-key ⇒ nb-single-one-line
//                              c = flow-key  ⇒ nb-single-one-line
fragment NB_SINGLE_TEXT_N01_CFLOWOUT: NB_SINGLE_MULTI_LINE_N01;
fragment NB_SINGLE_TEXT_N02_CFLOWOUT: NB_SINGLE_MULTI_LINE_N02;
fragment NB_SINGLE_TEXT_N03_CFLOWOUT: NB_SINGLE_MULTI_LINE_N03;
fragment NB_SINGLE_TEXT_N04_CFLOWOUT: NB_SINGLE_MULTI_LINE_N04;
fragment NB_SINGLE_TEXT_N05_CFLOWOUT: NB_SINGLE_MULTI_LINE_N05;

fragment NB_SINGLE_TEXT_N01_CFLOWIN: NB_SINGLE_MULTI_LINE_N01;
fragment NB_SINGLE_TEXT_N02_CFLOWIN: NB_SINGLE_MULTI_LINE_N02;
fragment NB_SINGLE_TEXT_N03_CFLOWIN: NB_SINGLE_MULTI_LINE_N03;
fragment NB_SINGLE_TEXT_N04_CFLOWIN: NB_SINGLE_MULTI_LINE_N04;
fragment NB_SINGLE_TEXT_N05_CFLOWIN: NB_SINGLE_MULTI_LINE_N05;

fragment NB_SINGLE_TEXT_N01_CBLOCKKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N02_CBLOCKKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N03_CBLOCKKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N04_CBLOCKKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N05_CBLOCKKEY: NB_SINGLE_ONE_LINE;

fragment NB_SINGLE_TEXT_N01_CFLOWKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N02_CFLOWKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N03_CFLOWKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N04_CFLOWKEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_N05_CFLOWKEY: NB_SINGLE_ONE_LINE;

// [122]	nb-single-one-line	::=	nb-single-char*
fragment NB_SINGLE_ONE_LINE: NB_SINGLE_CHAR*;

// [123]	nb-ns-single-in-line	::=	( s-white* ns-single-char )*
fragment NB_NS_SINGLE_IN_LINE: (S_WHITE* NS_SINGLE_CHAR)*;

// [124]	s-single-next-line(n)	::=	s-flow-folded(n)
//                                  ( ns-single-char nb-ns-single-in-line
//                                    ( s-single-next-line(n) | s-white* ) )?
S_SINGLE_NEXT_LINE_N01: S_FLOW_FOLDED_N01
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_N01 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_N02: S_FLOW_FOLDED_N02
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_N02 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_N03: S_FLOW_FOLDED_N03
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_N03 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_N04: S_FLOW_FOLDED_N04
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_N04 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_N05: S_FLOW_FOLDED_N05
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_N05 | S_WHITE*))?;

// [125]	nb-single-multi-line(n)	::=	nb-ns-single-in-line
//                                  ( s-single-next-line(n) | s-white* )
fragment NB_SINGLE_MULTI_LINE_N01: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_N01 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_N02: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_N02 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_N03: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_N03 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_N04: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_N04 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_N05: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_N05 | S_WHITE)*;

//--- Plain Style
// [126]	ns-plain-first(c)	::=	  ( ns-char - c-indicator )
//                              | ( ( “?” | “:” | “-” )
//                                   /* Followed by an ns-plain-safe(c)) */ )
fragment AK_NS_PLAIN_FIRST_OPTION1:
            ~('\u0020' | '\u0009'
            | '-' | '?' | ':' | ',' | '[' | ']' | '{' | '}'     // minus C_INDICATOR
            | '#' | '&' | '*' | '!' | '|' | '>' | '\'' | '"'
            | '%' | '@' | '`');
NS_PLAIN_FIRST_CFLOWOUT: AK_NS_PLAIN_FIRST_OPTION1
                        | ('?' | ':' | '-') NS_PLAIN_SAFE_CFLOWOUT;
NS_PLAIN_FIRST_CFLOWIN: AK_NS_PLAIN_FIRST_OPTION1
                        | ('?' | ':' | '-') NS_PLAIN_SAFE_CFLOWIN;
NS_PLAIN_FIRST_CBLOCKKEY: AK_NS_PLAIN_FIRST_OPTION1
                        | ('?' | ':' | '-') NS_PLAIN_SAFE_CBLOCKKEY;
NS_PLAIN_FIRST_CFLOWKEY: AK_NS_PLAIN_FIRST_OPTION1
                        | ('?' | ':' | '-') NS_PLAIN_SAFE_CFLOWKEY;

// [127]	ns-plain-safe(c)	::=	c = flow-out  ⇒ ns-plain-safe-out
//                                  c = flow-in   ⇒ ns-plain-safe-in
//                                  c = block-key ⇒ ns-plain-safe-out
//                                  c = flow-key  ⇒ ns-plain-safe-in
NS_PLAIN_SAFE_CFLOWOUT: NS_PLAIN_SAFE_OUT;
NS_PLAIN_SAFE_CFLOWIN: NS_PLAIN_SAFE_IN;
NS_PLAIN_SAFE_CBLOCKKEY: NS_PLAIN_SAFE_OUT;
NS_PLAIN_SAFE_CFLOWKEY: NS_PLAIN_SAFE_IN;

// [128]	ns-plain-safe-out	::=	ns-char
NS_PLAIN_SAFE_OUT: NS_CHAR;

// [129]	ns-plain-safe-in	::=	ns-char - c-flow-indicator
NS_PLAIN_SAFE_IN: ~('\u0020' | '\u0009'
                        | ',' | '[' | ']' | '{' | '}');     // and minus C_FLOW_INDICATOR

// [130]	ns-plain-char(c)	::=	  ( ns-plain-safe(c) - “:” - “#” )
//                              | ( /* An ns-char preceding */ “#” )
//                              | ( “:” /* Followed by an ns-plain-safe(c) */ )
NS_PLAIN_CHAR_CFLOWOUT: ~('\u0020' | '\u0009' | ':' | '#')
                        | (NS_CHAR '#')
                        | (':' NS_PLAIN_SAFE_CFLOWOUT);
NS_PLAIN_CHAR_CFLOWIN: ~('\u0020' | '\u0009' | ',' | '[' | ']' | '{' | '}'  | ':' | '#')
                        | (NS_CHAR '#')
                        | (':' NS_PLAIN_SAFE_CFLOWIN);
NS_PLAIN_CHAR_CBLOCKKEY: ~('\u0020' | '\u0009' | ':' | '#')
                        | (NS_CHAR '#')
                        | (':' NS_PLAIN_SAFE_CBLOCKKEY);
NS_PLAIN_CHAR_CFLOWKEY: ~('\u0020' | '\u0009' | ',' | '[' | ']' | '{' | '}' | ':' | '#')
                        | (NS_CHAR '#')
                        | (':' NS_PLAIN_SAFE_CFLOWKEY);


// [131]	ns-plain(n,c)	::=	c = flow-out  ⇒ ns-plain-multi-line(n,c)
//                              c = flow-in   ⇒ ns-plain-multi-line(n,c)
//                              c = block-key ⇒ ns-plain-one-line(c)
//                              c = flow-key  ⇒ ns-plain-one-line(c)
NS_PLAIN_N01_CFLOWOUT: NS_PLAIN_MULTI_LINE_N01_CFLOWOUT;
NS_PLAIN_N02_CFLOWOUT: NS_PLAIN_MULTI_LINE_N02_CFLOWOUT;
NS_PLAIN_N03_CFLOWOUT: NS_PLAIN_MULTI_LINE_N03_CFLOWOUT;
NS_PLAIN_N04_CFLOWOUT: NS_PLAIN_MULTI_LINE_N04_CFLOWOUT;
NS_PLAIN_N05_CFLOWOUT: NS_PLAIN_MULTI_LINE_N05_CFLOWOUT;

NS_PLAIN_N01_CFLOWIN: NS_PLAIN_MULTI_LINE_N01_CFLOWIN;
NS_PLAIN_N02_CFLOWIN: NS_PLAIN_MULTI_LINE_N02_CFLOWIN;
NS_PLAIN_N03_CFLOWIN: NS_PLAIN_MULTI_LINE_N03_CFLOWIN;
NS_PLAIN_N04_CFLOWIN: NS_PLAIN_MULTI_LINE_N04_CFLOWIN;
NS_PLAIN_N05_CFLOWIN: NS_PLAIN_MULTI_LINE_N05_CFLOWIN;

NS_PLAIN_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY;
NS_PLAIN_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY;


// [132]	nb-ns-plain-in-line(c)	::=	( s-white* ns-plain-char(c) )*
fragment NB_NS_PLAIN_IN_LINE_CFLOWOUT: (S_WHITE* NS_PLAIN_CHAR_CFLOWOUT)*;
fragment NB_NS_PLAIN_IN_LINE_CFLOWIN: (S_WHITE* NS_PLAIN_CHAR_CFLOWIN)*;
fragment NB_NS_PLAIN_IN_LINE_CBLOCKKEY: (S_WHITE* NS_PLAIN_CHAR_CBLOCKKEY)*;
fragment NB_NS_PLAIN_IN_LINE_CFLOWKEY: (S_WHITE* NS_PLAIN_CHAR_CFLOWKEY)*;

// [133]	ns-plain-one-line(c)	::=	ns-plain-first(c) nb-ns-plain-in-line(c)
NS_PLAIN_ONE_LINE_CFLOWOUT: NS_PLAIN_FIRST_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;
NS_PLAIN_ONE_LINE_CFLOWIN: NS_PLAIN_FIRST_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;
NS_PLAIN_ONE_LINE_CBLOCKKEY: NS_PLAIN_FIRST_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;
NS_PLAIN_ONE_LINE_CFLOWKEY: NS_PLAIN_FIRST_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;

// [134]	s-ns-plain-next-line(n,c)	::=	s-flow-folded(n)
//                                          ns-plain-char(c) nb-ns-plain-in-line(c)
S_NS_PLAIN_NEXT_LINE_N01_CFLOWOUT: S_FLOW_FOLDED_N01 NS_PLAIN_CHAR_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;
S_NS_PLAIN_NEXT_LINE_N02_CFLOWOUT: S_FLOW_FOLDED_N02 NS_PLAIN_CHAR_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;
S_NS_PLAIN_NEXT_LINE_N03_CFLOWOUT: S_FLOW_FOLDED_N03 NS_PLAIN_CHAR_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;
S_NS_PLAIN_NEXT_LINE_N04_CFLOWOUT: S_FLOW_FOLDED_N04 NS_PLAIN_CHAR_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;
S_NS_PLAIN_NEXT_LINE_N05_CFLOWOUT: S_FLOW_FOLDED_N05 NS_PLAIN_CHAR_CFLOWOUT NB_NS_PLAIN_IN_LINE_CFLOWOUT;

S_NS_PLAIN_NEXT_LINE_N01_CFLOWIN: S_FLOW_FOLDED_N01 NS_PLAIN_CHAR_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;
S_NS_PLAIN_NEXT_LINE_N02_CFLOWIN: S_FLOW_FOLDED_N02 NS_PLAIN_CHAR_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;
S_NS_PLAIN_NEXT_LINE_N03_CFLOWIN: S_FLOW_FOLDED_N03 NS_PLAIN_CHAR_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;
S_NS_PLAIN_NEXT_LINE_N04_CFLOWIN: S_FLOW_FOLDED_N04 NS_PLAIN_CHAR_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;
S_NS_PLAIN_NEXT_LINE_N05_CFLOWIN: S_FLOW_FOLDED_N05 NS_PLAIN_CHAR_CFLOWIN NB_NS_PLAIN_IN_LINE_CFLOWIN;

S_NS_PLAIN_NEXT_LINE_N01_CBLOCKKEY: S_FLOW_FOLDED_N01 NS_PLAIN_CHAR_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;
S_NS_PLAIN_NEXT_LINE_N02_CBLOCKKEY: S_FLOW_FOLDED_N02 NS_PLAIN_CHAR_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;
S_NS_PLAIN_NEXT_LINE_N03_CBLOCKKEY: S_FLOW_FOLDED_N03 NS_PLAIN_CHAR_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;
S_NS_PLAIN_NEXT_LINE_N04_CBLOCKKEY: S_FLOW_FOLDED_N04 NS_PLAIN_CHAR_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;
S_NS_PLAIN_NEXT_LINE_N05_CBLOCKKEY: S_FLOW_FOLDED_N05 NS_PLAIN_CHAR_CBLOCKKEY NB_NS_PLAIN_IN_LINE_CBLOCKKEY;

S_NS_PLAIN_NEXT_LINE_N01_CFLOWKEY: S_FLOW_FOLDED_N01 NS_PLAIN_CHAR_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;
S_NS_PLAIN_NEXT_LINE_N02_CFLOWKEY: S_FLOW_FOLDED_N02 NS_PLAIN_CHAR_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;
S_NS_PLAIN_NEXT_LINE_N03_CFLOWKEY: S_FLOW_FOLDED_N03 NS_PLAIN_CHAR_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;
S_NS_PLAIN_NEXT_LINE_N04_CFLOWKEY: S_FLOW_FOLDED_N04 NS_PLAIN_CHAR_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;
S_NS_PLAIN_NEXT_LINE_N05_CFLOWKEY: S_FLOW_FOLDED_N05 NS_PLAIN_CHAR_CFLOWKEY NB_NS_PLAIN_IN_LINE_CFLOWKEY;

// [135]	ns-plain-multi-line(n,c)	::=	ns-plain-one-line(c)
//                                          s-ns-plain-next-line(n,c)*
NS_PLAIN_MULTI_LINE_N01_CFLOWOUT: NS_PLAIN_ONE_LINE_CFLOWOUT S_NS_PLAIN_NEXT_LINE_N01_CFLOWOUT*;
NS_PLAIN_MULTI_LINE_N02_CFLOWOUT: NS_PLAIN_ONE_LINE_CFLOWOUT S_NS_PLAIN_NEXT_LINE_N02_CFLOWOUT*;
NS_PLAIN_MULTI_LINE_N03_CFLOWOUT: NS_PLAIN_ONE_LINE_CFLOWOUT S_NS_PLAIN_NEXT_LINE_N03_CFLOWOUT*;
NS_PLAIN_MULTI_LINE_N04_CFLOWOUT: NS_PLAIN_ONE_LINE_CFLOWOUT S_NS_PLAIN_NEXT_LINE_N04_CFLOWOUT*;
NS_PLAIN_MULTI_LINE_N05_CFLOWOUT: NS_PLAIN_ONE_LINE_CFLOWOUT S_NS_PLAIN_NEXT_LINE_N05_CFLOWOUT*;

NS_PLAIN_MULTI_LINE_N01_CFLOWIN: NS_PLAIN_ONE_LINE_CFLOWIN S_NS_PLAIN_NEXT_LINE_N01_CFLOWIN*;
NS_PLAIN_MULTI_LINE_N02_CFLOWIN: NS_PLAIN_ONE_LINE_CFLOWIN S_NS_PLAIN_NEXT_LINE_N02_CFLOWIN*;
NS_PLAIN_MULTI_LINE_N03_CFLOWIN: NS_PLAIN_ONE_LINE_CFLOWIN S_NS_PLAIN_NEXT_LINE_N03_CFLOWIN*;
NS_PLAIN_MULTI_LINE_N04_CFLOWIN: NS_PLAIN_ONE_LINE_CFLOWIN S_NS_PLAIN_NEXT_LINE_N04_CFLOWIN*;
NS_PLAIN_MULTI_LINE_N05_CFLOWIN: NS_PLAIN_ONE_LINE_CFLOWIN S_NS_PLAIN_NEXT_LINE_N05_CFLOWIN*;

NS_PLAIN_MULTI_LINE_N01_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY S_NS_PLAIN_NEXT_LINE_N01_CBLOCKKEY*;
NS_PLAIN_MULTI_LINE_N02_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY S_NS_PLAIN_NEXT_LINE_N02_CBLOCKKEY*;
NS_PLAIN_MULTI_LINE_N03_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY S_NS_PLAIN_NEXT_LINE_N03_CBLOCKKEY*;
NS_PLAIN_MULTI_LINE_N04_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY S_NS_PLAIN_NEXT_LINE_N04_CBLOCKKEY*;
NS_PLAIN_MULTI_LINE_N05_CBLOCKKEY: NS_PLAIN_ONE_LINE_CBLOCKKEY S_NS_PLAIN_NEXT_LINE_N05_CBLOCKKEY*;

NS_PLAIN_MULTI_LINE_N01_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY S_NS_PLAIN_NEXT_LINE_N01_CFLOWKEY*;
NS_PLAIN_MULTI_LINE_N02_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY S_NS_PLAIN_NEXT_LINE_N02_CFLOWKEY*;
NS_PLAIN_MULTI_LINE_N03_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY S_NS_PLAIN_NEXT_LINE_N03_CFLOWKEY*;
NS_PLAIN_MULTI_LINE_N04_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY S_NS_PLAIN_NEXT_LINE_N04_CFLOWKEY*;
NS_PLAIN_MULTI_LINE_N05_CFLOWKEY: NS_PLAIN_ONE_LINE_CFLOWKEY S_NS_PLAIN_NEXT_LINE_N05_CFLOWKEY*;

/*****************************************************************************
    7.4. Flow Collection Styles
*****************************************************************************/
// [136]	in-flow(c)	::=	c = flow-out  ⇒ flow-in
//                          c = flow-in   ⇒ flow-in
//                          c = block-key ⇒ flow-key
//                          c = flow-key  ⇒ flow-key
/*
IN_FLOW_CFLOWOUT: FLOW_IN;
IN_FLOW_CFLOWIN: FLOW_IN;
IN_FLOW_CBLOCKKEY: FLOW_KEY;
IN_FLOW_CFLOWKEY: FLOW_KEY;
*/

//--- 7.4.1. Flow Sequences
// [137]	c-flow-sequence(n,c)	::=	“[” s-separate(n,c)?
//                                      ns-s-flow-seq-entries(n,in-flow(c))? “]”
C_FLOW_SEQUENCE_N01_CFLOWOUT: '[' S_SEPARATE_N01_CFLOWOUT? NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWIN? ']';
C_FLOW_SEQUENCE_N02_CFLOWOUT: '[' S_SEPARATE_N02_CFLOWOUT? NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWIN? ']';
C_FLOW_SEQUENCE_N03_CFLOWOUT: '[' S_SEPARATE_N03_CFLOWOUT? NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWIN? ']';
C_FLOW_SEQUENCE_N04_CFLOWOUT: '[' S_SEPARATE_N04_CFLOWOUT? NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWIN? ']';
C_FLOW_SEQUENCE_N05_CFLOWOUT: '[' S_SEPARATE_N05_CFLOWOUT? NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWIN? ']';

C_FLOW_SEQUENCE_N01_CFLOWIN: '[' S_SEPARATE_N01_CFLOWIN? NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWIN? ']';
C_FLOW_SEQUENCE_N02_CFLOWIN: '[' S_SEPARATE_N02_CFLOWIN? NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWIN? ']';
C_FLOW_SEQUENCE_N03_CFLOWIN: '[' S_SEPARATE_N03_CFLOWIN? NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWIN? ']';
C_FLOW_SEQUENCE_N04_CFLOWIN: '[' S_SEPARATE_N04_CFLOWIN? NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWIN? ']';
C_FLOW_SEQUENCE_N05_CFLOWIN: '[' S_SEPARATE_N05_CFLOWIN? NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWIN? ']';

C_FLOW_SEQUENCE_N01_CBLOCKKEY: '[' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N02_CBLOCKKEY: '[' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N03_CBLOCKKEY: '[' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N04_CBLOCKKEY: '[' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N05_CBLOCKKEY: '[' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWKEY? ']';

C_FLOW_SEQUENCE_N01_CFLOWKEY: '[' S_SEPARATE_CFLOWKEY? NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N02_CFLOWKEY: '[' S_SEPARATE_CFLOWKEY? NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N03_CFLOWKEY: '[' S_SEPARATE_CFLOWKEY? NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N04_CFLOWKEY: '[' S_SEPARATE_CFLOWKEY? NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWKEY? ']';
C_FLOW_SEQUENCE_N05_CFLOWKEY: '[' S_SEPARATE_CFLOWKEY? NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWKEY? ']';

// [138]	ns-s-flow-seq-entries(n,c)	::=	ns-flow-seq-entry(n,c) s-separate(n,c)?
//                                      ( “,” s-separate(n,c)?
//                                      ns-s-flow-seq-entries(n,c)? )?
NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWOUT: NS_FLOW_SEQ_ENTRY_N01_CFLOWOUT S_SEPARATE_N01_CFLOWOUT?
                                ( ',' S_SEPARATE_N01_CFLOWOUT?
                                    NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWOUT? )?;
NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWOUT: NS_FLOW_SEQ_ENTRY_N02_CFLOWOUT S_SEPARATE_N02_CFLOWOUT?
                                ( ',' S_SEPARATE_N02_CFLOWOUT?
                                    NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWOUT? )?;
NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWOUT: NS_FLOW_SEQ_ENTRY_N03_CFLOWOUT S_SEPARATE_N03_CFLOWOUT?
                                ( ',' S_SEPARATE_N03_CFLOWOUT?
                                    NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWOUT? )?;
NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWOUT: NS_FLOW_SEQ_ENTRY_N04_CFLOWOUT S_SEPARATE_N04_CFLOWOUT?
                                ( ',' S_SEPARATE_N04_CFLOWOUT?
                                    NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWOUT? )?;
NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWOUT: NS_FLOW_SEQ_ENTRY_N05_CFLOWOUT S_SEPARATE_N05_CFLOWOUT?
                                ( ',' S_SEPARATE_N05_CFLOWOUT?
                                    NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWOUT? )?;

NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWIN: NS_FLOW_SEQ_ENTRY_N01_CFLOWIN S_SEPARATE_N01_CFLOWIN?
                                ( ',' S_SEPARATE_N01_CFLOWIN?
                                    NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWIN? )?;
NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWIN: NS_FLOW_SEQ_ENTRY_N02_CFLOWIN S_SEPARATE_N02_CFLOWIN?
                                ( ',' S_SEPARATE_N02_CFLOWIN?
                                    NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWIN? )?;
NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWIN: NS_FLOW_SEQ_ENTRY_N03_CFLOWIN S_SEPARATE_N03_CFLOWIN?
                                ( ',' S_SEPARATE_N03_CFLOWIN?
                                    NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWIN? )?;
NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWIN: NS_FLOW_SEQ_ENTRY_N04_CFLOWIN S_SEPARATE_N04_CFLOWIN?
                                ( ',' S_SEPARATE_N04_CFLOWIN?
                                    NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWIN? )?;
NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWIN: NS_FLOW_SEQ_ENTRY_N05_CFLOWIN S_SEPARATE_N05_CFLOWIN?
                                ( ',' S_SEPARATE_N05_CFLOWIN?
                                    NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWIN? )?;

NS_S_FLOW_SEQ_ENTRIES_N01_CBLOCKKEY: NS_FLOW_SEQ_ENTRY_N01_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N01_CBLOCKKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N02_CBLOCKKEY: NS_FLOW_SEQ_ENTRY_N02_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N02_CBLOCKKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N03_CBLOCKKEY: NS_FLOW_SEQ_ENTRY_N03_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N03_CBLOCKKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N04_CBLOCKKEY: NS_FLOW_SEQ_ENTRY_N04_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N04_CBLOCKKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N05_CBLOCKKEY: NS_FLOW_SEQ_ENTRY_N05_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N05_CBLOCKKEY? )?;

NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWKEY: NS_FLOW_SEQ_ENTRY_N01_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N01_CFLOWKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWKEY: NS_FLOW_SEQ_ENTRY_N02_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N02_CFLOWKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWKEY: NS_FLOW_SEQ_ENTRY_N03_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N03_CFLOWKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWKEY: NS_FLOW_SEQ_ENTRY_N04_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N04_CFLOWKEY? )?;
NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWKEY: NS_FLOW_SEQ_ENTRY_N05_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_SEQ_ENTRIES_N05_CFLOWKEY? )?;


// [139]	ns-flow-seq-entry(n,c)	::=	ns-flow-pair(n,c) | ns-flow-node(n,c)
NS_FLOW_SEQ_ENTRY_N01_CFLOWOUT: NS_FLOW_PAIR_N01_CFLOWOUT | NS_FLOW_NODE_N01_CFLOWOUT;
NS_FLOW_SEQ_ENTRY_N02_CFLOWOUT: NS_FLOW_PAIR_N02_CFLOWOUT | NS_FLOW_NODE_N02_CFLOWOUT;
NS_FLOW_SEQ_ENTRY_N03_CFLOWOUT: NS_FLOW_PAIR_N03_CFLOWOUT | NS_FLOW_NODE_N03_CFLOWOUT;
NS_FLOW_SEQ_ENTRY_N04_CFLOWOUT: NS_FLOW_PAIR_N04_CFLOWOUT | NS_FLOW_NODE_N04_CFLOWOUT;
NS_FLOW_SEQ_ENTRY_N05_CFLOWOUT: NS_FLOW_PAIR_N05_CFLOWOUT | NS_FLOW_NODE_N05_CFLOWOUT;

NS_FLOW_SEQ_ENTRY_N01_CFLOWIN: NS_FLOW_PAIR_N01_CFLOWIN | NS_FLOW_NODE_N01_CFLOWIN;
NS_FLOW_SEQ_ENTRY_N02_CFLOWIN: NS_FLOW_PAIR_N02_CFLOWIN | NS_FLOW_NODE_N02_CFLOWIN;
NS_FLOW_SEQ_ENTRY_N03_CFLOWIN: NS_FLOW_PAIR_N03_CFLOWIN | NS_FLOW_NODE_N03_CFLOWIN;
NS_FLOW_SEQ_ENTRY_N04_CFLOWIN: NS_FLOW_PAIR_N04_CFLOWIN | NS_FLOW_NODE_N04_CFLOWIN;
NS_FLOW_SEQ_ENTRY_N05_CFLOWIN: NS_FLOW_PAIR_N05_CFLOWIN | NS_FLOW_NODE_N05_CFLOWIN;

NS_FLOW_SEQ_ENTRY_N01_CBLOCKKEY: NS_FLOW_PAIR_N01_CBLOCKKEY | NS_FLOW_NODE_N01_CBLOCKKEY;
NS_FLOW_SEQ_ENTRY_N02_CBLOCKKEY: NS_FLOW_PAIR_N02_CBLOCKKEY | NS_FLOW_NODE_N02_CBLOCKKEY;
NS_FLOW_SEQ_ENTRY_N03_CBLOCKKEY: NS_FLOW_PAIR_N03_CBLOCKKEY | NS_FLOW_NODE_N03_CBLOCKKEY;
NS_FLOW_SEQ_ENTRY_N04_CBLOCKKEY: NS_FLOW_PAIR_N04_CBLOCKKEY | NS_FLOW_NODE_N04_CBLOCKKEY;
NS_FLOW_SEQ_ENTRY_N05_CBLOCKKEY: NS_FLOW_PAIR_N05_CBLOCKKEY | NS_FLOW_NODE_N05_CBLOCKKEY;

NS_FLOW_SEQ_ENTRY_N01_CFLOWKEY: NS_FLOW_PAIR_N01_CFLOWKEY | NS_FLOW_NODE_N01_CFLOWKEY;
NS_FLOW_SEQ_ENTRY_N02_CFLOWKEY: NS_FLOW_PAIR_N02_CFLOWKEY | NS_FLOW_NODE_N02_CFLOWKEY;
NS_FLOW_SEQ_ENTRY_N03_CFLOWKEY: NS_FLOW_PAIR_N03_CFLOWKEY | NS_FLOW_NODE_N03_CFLOWKEY;
NS_FLOW_SEQ_ENTRY_N04_CFLOWKEY: NS_FLOW_PAIR_N04_CFLOWKEY | NS_FLOW_NODE_N04_CFLOWKEY;
NS_FLOW_SEQ_ENTRY_N05_CFLOWKEY: NS_FLOW_PAIR_N05_CFLOWKEY | NS_FLOW_NODE_N05_CFLOWKEY;


//--- 7.4.2. Flow Mappings
// [140]	c-flow-mapping(n,c)	::=	“{” s-separate(n,c)?
//                              ns-s-flow-map-entries(n,in-flow(c))? “}”
C_FLOW_MAPPING_N01_CFLOWOUT: '{' S_SEPARATE_N01_CFLOWOUT? NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN? '}';
C_FLOW_MAPPING_N02_CFLOWOUT: '{' S_SEPARATE_N02_CFLOWOUT? NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN? '}';
C_FLOW_MAPPING_N03_CFLOWOUT: '{' S_SEPARATE_N03_CFLOWOUT? NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN? '}';
C_FLOW_MAPPING_N04_CFLOWOUT: '{' S_SEPARATE_N04_CFLOWOUT? NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN? '}';
C_FLOW_MAPPING_N05_CFLOWOUT: '{' S_SEPARATE_N05_CFLOWOUT? NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN? '}';

C_FLOW_MAPPING_N01_CFLOWIN: '{' S_SEPARATE_N01_CFLOWIN? NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN? '}';
C_FLOW_MAPPING_N02_CFLOWIN: '{' S_SEPARATE_N02_CFLOWIN? NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN? '}';
C_FLOW_MAPPING_N03_CFLOWIN: '{' S_SEPARATE_N03_CFLOWIN? NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN? '}';
C_FLOW_MAPPING_N04_CFLOWIN: '{' S_SEPARATE_N04_CFLOWIN? NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN? '}';
C_FLOW_MAPPING_N05_CFLOWIN: '{' S_SEPARATE_N05_CFLOWIN? NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN? '}';

C_FLOW_MAPPING_N01_CBLOCKKEY: '{' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN? '}';
C_FLOW_MAPPING_N02_CBLOCKKEY: '{' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN? '}';
C_FLOW_MAPPING_N03_CBLOCKKEY: '{' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN? '}';
C_FLOW_MAPPING_N04_CBLOCKKEY: '{' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN? '}';
C_FLOW_MAPPING_N05_CBLOCKKEY: '{' S_SEPARATE_CBLOCKKEY? NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN? '}';

C_FLOW_MAPPING_N01_CFLOWKEY: '{' S_SEPARATE_CFLOWKEY? NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN? '}';
C_FLOW_MAPPING_N02_CFLOWKEY: '{' S_SEPARATE_CFLOWKEY? NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN? '}';
C_FLOW_MAPPING_N03_CFLOWKEY: '{' S_SEPARATE_CFLOWKEY? NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN? '}';
C_FLOW_MAPPING_N04_CFLOWKEY: '{' S_SEPARATE_CFLOWKEY? NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN? '}';
C_FLOW_MAPPING_N05_CFLOWKEY: '{' S_SEPARATE_CFLOWKEY? NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN? '}';

// [141]	ns-s-flow-map-entries(n,c)	::=	ns-flow-map-entry(n,c) s-separate(n,c)?
//                                      ( “,” s-separate(n,c)?
//                                      ns-s-flow-map-entries(n,c)? )?
NS_S_FLOW_MAP_ENTRIES_N01_CFLOWOUT: NS_FLOW_MAP_ENTRY_N01_CFLOWOUT S_SEPARATE_N01_CFLOWOUT?
                                    ( ',' S_SEPARATE_N01_CFLOWOUT?
                                    NS_S_FLOW_MAP_ENTRIES_N01_CFLOWOUT? )?;
NS_S_FLOW_MAP_ENTRIES_N02_CFLOWOUT: NS_FLOW_MAP_ENTRY_N02_CFLOWOUT S_SEPARATE_N02_CFLOWOUT?
                                    ( ',' S_SEPARATE_N02_CFLOWOUT?
                                    NS_S_FLOW_MAP_ENTRIES_N02_CFLOWOUT? )?;
NS_S_FLOW_MAP_ENTRIES_N03_CFLOWOUT: NS_FLOW_MAP_ENTRY_N03_CFLOWOUT S_SEPARATE_N03_CFLOWOUT?
                                    ( ',' S_SEPARATE_N03_CFLOWOUT?
                                    NS_S_FLOW_MAP_ENTRIES_N03_CFLOWOUT? )?;
NS_S_FLOW_MAP_ENTRIES_N04_CFLOWOUT: NS_FLOW_MAP_ENTRY_N04_CFLOWOUT S_SEPARATE_N04_CFLOWOUT?
                                    ( ',' S_SEPARATE_N04_CFLOWOUT?
                                    NS_S_FLOW_MAP_ENTRIES_N04_CFLOWOUT? )?;
NS_S_FLOW_MAP_ENTRIES_N05_CFLOWOUT: NS_FLOW_MAP_ENTRY_N05_CFLOWOUT S_SEPARATE_N05_CFLOWOUT?
                                    ( ',' S_SEPARATE_N05_CFLOWOUT?
                                    NS_S_FLOW_MAP_ENTRIES_N05_CFLOWOUT? )?;
                                    
NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN: NS_FLOW_MAP_ENTRY_N01_CFLOWIN S_SEPARATE_N01_CFLOWIN?
                                    ( ',' S_SEPARATE_N01_CFLOWIN?
                                    NS_S_FLOW_MAP_ENTRIES_N01_CFLOWIN? )?;
NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN: NS_FLOW_MAP_ENTRY_N02_CFLOWIN S_SEPARATE_N02_CFLOWIN?
                                    ( ',' S_SEPARATE_N02_CFLOWIN?
                                    NS_S_FLOW_MAP_ENTRIES_N02_CFLOWIN? )?;
NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN: NS_FLOW_MAP_ENTRY_N03_CFLOWIN S_SEPARATE_N03_CFLOWIN?
                                    ( ',' S_SEPARATE_N03_CFLOWIN?
                                    NS_S_FLOW_MAP_ENTRIES_N03_CFLOWIN? )?;
NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN: NS_FLOW_MAP_ENTRY_N04_CFLOWIN S_SEPARATE_N04_CFLOWIN?
                                    ( ',' S_SEPARATE_N04_CFLOWIN?
                                    NS_S_FLOW_MAP_ENTRIES_N04_CFLOWIN? )?;
NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN: NS_FLOW_MAP_ENTRY_N05_CFLOWIN S_SEPARATE_N05_CFLOWIN?
                                    ( ',' S_SEPARATE_N05_CFLOWIN?
                                    NS_S_FLOW_MAP_ENTRIES_N05_CFLOWIN? )?;

NS_S_FLOW_MAP_ENTRIES_N01_CBLOCKKEY: NS_FLOW_MAP_ENTRY_N01_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                    ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N01_CBLOCKKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N02_CBLOCKKEY: NS_FLOW_MAP_ENTRY_N02_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                    ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N02_CBLOCKKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N03_CBLOCKKEY: NS_FLOW_MAP_ENTRY_N03_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                    ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N03_CBLOCKKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N04_CBLOCKKEY: NS_FLOW_MAP_ENTRY_N04_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                    ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N04_CBLOCKKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N05_CBLOCKKEY: NS_FLOW_MAP_ENTRY_N05_CBLOCKKEY S_SEPARATE_CBLOCKKEY?
                                    ( ',' S_SEPARATE_CBLOCKKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N05_CBLOCKKEY? )?;
                                    
NS_S_FLOW_MAP_ENTRIES_N01_CFLOWKEY: NS_FLOW_MAP_ENTRY_N01_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                    ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N01_CFLOWKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N02_CFLOWKEY: NS_FLOW_MAP_ENTRY_N02_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                    ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N02_CFLOWKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N03_CFLOWKEY: NS_FLOW_MAP_ENTRY_N03_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                    ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N03_CFLOWKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N04_CFLOWKEY: NS_FLOW_MAP_ENTRY_N04_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                    ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N04_CFLOWKEY? )?;
NS_S_FLOW_MAP_ENTRIES_N05_CFLOWKEY: NS_FLOW_MAP_ENTRY_N05_CFLOWKEY S_SEPARATE_CFLOWKEY?
                                    ( ',' S_SEPARATE_CFLOWKEY?
                                    NS_S_FLOW_MAP_ENTRIES_N05_CFLOWKEY? )?;
                                    

// [142]	ns-flow-map-entry(n,c)	::=	  ( “?” s-separate(n,c)
//                                  ns-flow-map-explicit-entry(n,c) )
//                                  | ns-flow-map-implicit-entry(n,c)
NS_FLOW_MAP_ENTRY_N01_CFLOWOUT: '?' S_SEPARATE_N01_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWOUT
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWOUT;
NS_FLOW_MAP_ENTRY_N02_CFLOWOUT: '?' S_SEPARATE_N02_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWOUT
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWOUT;
NS_FLOW_MAP_ENTRY_N03_CFLOWOUT: '?' S_SEPARATE_N03_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWOUT
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWOUT;
NS_FLOW_MAP_ENTRY_N04_CFLOWOUT: '?' S_SEPARATE_N04_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWOUT
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWOUT;
NS_FLOW_MAP_ENTRY_N05_CFLOWOUT: '?' S_SEPARATE_N05_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWOUT
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWOUT;

NS_FLOW_MAP_ENTRY_N01_CFLOWIN: '?' S_SEPARATE_N01_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWIN
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWIN;
NS_FLOW_MAP_ENTRY_N02_CFLOWIN: '?' S_SEPARATE_N02_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWIN
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWIN;
NS_FLOW_MAP_ENTRY_N03_CFLOWIN: '?' S_SEPARATE_N03_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWIN
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWIN;
NS_FLOW_MAP_ENTRY_N04_CFLOWIN: '?' S_SEPARATE_N04_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWIN
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWIN;
NS_FLOW_MAP_ENTRY_N05_CFLOWIN: '?' S_SEPARATE_N05_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWIN
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWIN;

NS_FLOW_MAP_ENTRY_N01_CBLOCKKEY: '?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CBLOCKKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CBLOCKKEY;
NS_FLOW_MAP_ENTRY_N02_CBLOCKKEY: '?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CBLOCKKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CBLOCKKEY;
NS_FLOW_MAP_ENTRY_N03_CBLOCKKEY: '?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CBLOCKKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CBLOCKKEY;
NS_FLOW_MAP_ENTRY_N04_CBLOCKKEY: '?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CBLOCKKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CBLOCKKEY;
NS_FLOW_MAP_ENTRY_N05_CBLOCKKEY: '?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CBLOCKKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CBLOCKKEY;

NS_FLOW_MAP_ENTRY_N01_CFLOWKEY: '?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWKEY;
NS_FLOW_MAP_ENTRY_N02_CFLOWKEY: '?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWKEY;
NS_FLOW_MAP_ENTRY_N03_CFLOWKEY: '?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWKEY;
NS_FLOW_MAP_ENTRY_N04_CFLOWKEY: '?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWKEY;
NS_FLOW_MAP_ENTRY_N05_CFLOWKEY: '?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWKEY
                                | NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWKEY;

// [143]	ns-flow-map-explicit-entry(n,c)	::=	  ns-flow-map-implicit-entry(n,c)
//                                          | ( e-node /* Key */
//                                          e-node /* Value */ )
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWOUT: NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWOUT
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWOUT: NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWOUT
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWOUT: NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWOUT
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWOUT: NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWOUT
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWOUT: NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWOUT
                                        | E_NODE /* key */    E_NODE /* value */;

fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWIN: NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWIN
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWIN: NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWIN
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWIN: NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWIN
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWIN: NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWIN
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWIN: NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWIN
                                        | E_NODE /* key */    E_NODE /* value */;

fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CBLOCKKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CBLOCKKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CBLOCKKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CBLOCKKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CBLOCKKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CBLOCKKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CBLOCKKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CBLOCKKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CBLOCKKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CBLOCKKEY
                                        | E_NODE /* key */    E_NODE /* value */;

fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWKEY
                                        | E_NODE /* key */    E_NODE /* value */;
fragment NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWKEY: NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWKEY
                                        | E_NODE /* key */    E_NODE /* value */;


// [144]	ns-flow-map-implicit-entry(n,c)	::=	  ns-flow-map-yaml-key-entry(n,c)
//                                          | c-ns-flow-map-empty-key-entry(n,c)
//                                          | c-ns-flow-map-json-key-entry(n,c)
NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWOUT: NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWOUT
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWOUT
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWOUT;
NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWOUT: NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWOUT
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWOUT
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWOUT;
NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWOUT: NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWOUT
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWOUT
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWOUT;
NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWOUT: NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWOUT
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWOUT
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWOUT;
NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWOUT: NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWOUT
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWOUT
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWOUT;

NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWIN: NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWIN
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWIN
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWIN;
NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWIN: NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWIN
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWIN
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWIN;
NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWIN: NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWIN
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWIN
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWIN;
NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWIN: NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWIN
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWIN
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWIN;
NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWIN: NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWIN
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWIN
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWIN;

NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CBLOCKKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CBLOCKKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CBLOCKKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CBLOCKKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CBLOCKKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CBLOCKKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CBLOCKKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CBLOCKKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CBLOCKKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CBLOCKKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CBLOCKKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CBLOCKKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CBLOCKKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CBLOCKKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CBLOCKKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CBLOCKKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CBLOCKKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CBLOCKKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CBLOCKKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CBLOCKKEY;

NS_FLOW_MAP_IMPLICIT_ENTRY_N01_CFLOWKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N02_CFLOWKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N03_CFLOWKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N04_CFLOWKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWKEY;
NS_FLOW_MAP_IMPLICIT_ENTRY_N05_CFLOWKEY: NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWKEY
                                        | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWKEY
                                        | C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWKEY;


// [145]	ns-flow-map-yaml-key-entry(n,c)	::=	ns-flow-yaml-node(n,c)
//                                          ( ( s-separate(n,c)? c-ns-flow-map-separate-value(n,c) )
//                                          | e-node )
NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWOUT: NS_FLOW_YAML_NODE_N01_CFLOWOUT (
                                            (S_SEPARATE_N01_CFLOWOUT? C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWOUT)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWOUT: NS_FLOW_YAML_NODE_N02_CFLOWOUT (
                                            (S_SEPARATE_N02_CFLOWOUT? C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWOUT)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWOUT: NS_FLOW_YAML_NODE_N03_CFLOWOUT (
                                            (S_SEPARATE_N03_CFLOWOUT? C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWOUT)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWOUT: NS_FLOW_YAML_NODE_N04_CFLOWOUT (
                                            (S_SEPARATE_N04_CFLOWOUT? C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWOUT)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWOUT: NS_FLOW_YAML_NODE_N05_CFLOWOUT (
                                            (S_SEPARATE_N05_CFLOWOUT? C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWOUT)
                                            | E_NODE);

NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWIN: NS_FLOW_YAML_NODE_N01_CFLOWIN (
                                            (S_SEPARATE_N01_CFLOWIN? C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWIN)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWIN: NS_FLOW_YAML_NODE_N02_CFLOWIN (
                                            (S_SEPARATE_N02_CFLOWIN? C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWIN)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWIN: NS_FLOW_YAML_NODE_N03_CFLOWIN (
                                            (S_SEPARATE_N03_CFLOWIN? C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWIN)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWIN: NS_FLOW_YAML_NODE_N04_CFLOWIN (
                                            (S_SEPARATE_N04_CFLOWIN? C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWIN)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWIN: NS_FLOW_YAML_NODE_N05_CFLOWIN (
                                            (S_SEPARATE_N05_CFLOWIN? C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWIN)
                                            | E_NODE);

NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CBLOCKKEY: NS_FLOW_YAML_NODE_N01_CBLOCKKEY (
                                            (S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CBLOCKKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CBLOCKKEY: NS_FLOW_YAML_NODE_N02_CBLOCKKEY (
                                            (S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CBLOCKKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CBLOCKKEY: NS_FLOW_YAML_NODE_N03_CBLOCKKEY (
                                            (S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CBLOCKKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CBLOCKKEY: NS_FLOW_YAML_NODE_N04_CBLOCKKEY (
                                            (S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CBLOCKKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CBLOCKKEY: NS_FLOW_YAML_NODE_N05_CBLOCKKEY (
                                            (S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CBLOCKKEY)
                                            | E_NODE);

NS_FLOW_MAP_YAML_KEY_ENTRY_N01_CFLOWKEY: NS_FLOW_YAML_NODE_N01_CFLOWKEY (
                                            (S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N02_CFLOWKEY: NS_FLOW_YAML_NODE_N02_CFLOWKEY (
                                            (S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N03_CFLOWKEY: NS_FLOW_YAML_NODE_N03_CFLOWKEY (
                                            (S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N04_CFLOWKEY: NS_FLOW_YAML_NODE_N04_CFLOWKEY (
                                            (S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWKEY)
                                            | E_NODE);
NS_FLOW_MAP_YAML_KEY_ENTRY_N05_CFLOWKEY: NS_FLOW_YAML_NODE_N05_CFLOWKEY (
                                            (S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWKEY)
                                            | E_NODE);


// [146]	c-ns-flow-map-empty-key-entry(n,c)	::=	e-node /* Key */
//                                              c-ns-flow-map-separate-value(n,c)
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWOUT: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWOUT;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWOUT: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWOUT;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWOUT: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWOUT;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWOUT: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWOUT;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWOUT: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWOUT;

C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWIN: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWIN;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWIN: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWIN;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWIN: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWIN;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWIN: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWIN;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWIN: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWIN;

C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CBLOCKKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CBLOCKKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CBLOCKKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CBLOCKKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CBLOCKKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CBLOCKKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CBLOCKKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CBLOCKKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CBLOCKKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CBLOCKKEY;

C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWKEY;
C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWKEY: E_NODE C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWKEY;

// [147]	c-ns-flow-map-separate-value(n,c)	::=	“:” /* Not followed by an ns-plain-safe(c) */
//                                              ( ( s-separate(n,c) ns-flow-node(n,c) )
//                                              | e-node /* Value */ )
C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWOUT: ':' (S_SEPARATE_N01_CFLOWOUT NS_FLOW_NODE_N01_CFLOWOUT | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWOUT: ':' (S_SEPARATE_N02_CFLOWOUT NS_FLOW_NODE_N02_CFLOWOUT | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWOUT: ':' (S_SEPARATE_N03_CFLOWOUT NS_FLOW_NODE_N03_CFLOWOUT | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWOUT: ':' (S_SEPARATE_N04_CFLOWOUT NS_FLOW_NODE_N04_CFLOWOUT | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWOUT: ':' (S_SEPARATE_N05_CFLOWOUT NS_FLOW_NODE_N05_CFLOWOUT | E_NODE);

C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWIN: ':' (S_SEPARATE_N01_CFLOWIN NS_FLOW_NODE_N01_CFLOWIN | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWIN: ':' (S_SEPARATE_N02_CFLOWIN NS_FLOW_NODE_N02_CFLOWIN | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWIN: ':' (S_SEPARATE_N03_CFLOWIN NS_FLOW_NODE_N03_CFLOWIN | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWIN: ':' (S_SEPARATE_N04_CFLOWIN NS_FLOW_NODE_N04_CFLOWIN | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWIN: ':' (S_SEPARATE_N05_CFLOWIN NS_FLOW_NODE_N05_CFLOWIN | E_NODE);

C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CBLOCKKEY: ':' (S_SEPARATE_CBLOCKKEY NS_FLOW_NODE_N01_CBLOCKKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CBLOCKKEY: ':' (S_SEPARATE_CBLOCKKEY NS_FLOW_NODE_N02_CBLOCKKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CBLOCKKEY: ':' (S_SEPARATE_CBLOCKKEY NS_FLOW_NODE_N03_CBLOCKKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CBLOCKKEY: ':' (S_SEPARATE_CBLOCKKEY NS_FLOW_NODE_N04_CBLOCKKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CBLOCKKEY: ':' (S_SEPARATE_CBLOCKKEY NS_FLOW_NODE_N05_CBLOCKKEY | E_NODE);

C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWKEY: ':' (S_SEPARATE_CFLOWKEY NS_FLOW_NODE_N01_CFLOWKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWKEY: ':' (S_SEPARATE_CFLOWKEY NS_FLOW_NODE_N02_CFLOWKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWKEY: ':' (S_SEPARATE_CFLOWKEY NS_FLOW_NODE_N03_CFLOWKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWKEY: ':' (S_SEPARATE_CFLOWKEY NS_FLOW_NODE_N04_CFLOWKEY | E_NODE);
C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWKEY: ':' (S_SEPARATE_CFLOWKEY NS_FLOW_NODE_N05_CFLOWKEY | E_NODE);

// [148]	c-ns-flow-map-json-key-entry(n,c)	::=	c-flow-json-node(n,c)
//                                              ( ( s-separate(n,c)? c-ns-flow-map-adjacent-value(n,c) )
//                                                | e-node )
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWOUT: C_FLOW_JSON_NODE_N01_CFLOWOUT
                                           ( ( S_SEPARATE_N01_CFLOWOUT? C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWOUT)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWOUT: C_FLOW_JSON_NODE_N02_CFLOWOUT
                                           ( ( S_SEPARATE_N02_CFLOWOUT? C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWOUT)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWOUT: C_FLOW_JSON_NODE_N03_CFLOWOUT
                                           ( ( S_SEPARATE_N03_CFLOWOUT? C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWOUT)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWOUT: C_FLOW_JSON_NODE_N04_CFLOWOUT
                                           ( ( S_SEPARATE_N04_CFLOWOUT? C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWOUT)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWOUT: C_FLOW_JSON_NODE_N05_CFLOWOUT
                                           ( ( S_SEPARATE_N05_CFLOWOUT? C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWOUT)
                                             | E_NODE);

C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWIN: C_FLOW_JSON_NODE_N01_CFLOWIN
                                           ( ( S_SEPARATE_N01_CFLOWIN? C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWIN)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWIN: C_FLOW_JSON_NODE_N02_CFLOWIN
                                           ( ( S_SEPARATE_N02_CFLOWIN? C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWIN)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWIN: C_FLOW_JSON_NODE_N03_CFLOWIN
                                           ( ( S_SEPARATE_N03_CFLOWIN? C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWIN)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWIN: C_FLOW_JSON_NODE_N04_CFLOWIN
                                           ( ( S_SEPARATE_N04_CFLOWIN? C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWIN)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWIN: C_FLOW_JSON_NODE_N05_CFLOWIN
                                           ( ( S_SEPARATE_N05_CFLOWIN? C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWIN)
                                             | E_NODE);

C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CBLOCKKEY: C_FLOW_JSON_NODE_N01_CBLOCKKEY
                                           ( ( S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CBLOCKKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CBLOCKKEY: C_FLOW_JSON_NODE_N02_CBLOCKKEY
                                           ( ( S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CBLOCKKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CBLOCKKEY: C_FLOW_JSON_NODE_N03_CBLOCKKEY
                                           ( ( S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CBLOCKKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CBLOCKKEY: C_FLOW_JSON_NODE_N04_CBLOCKKEY
                                           ( ( S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CBLOCKKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CBLOCKKEY: C_FLOW_JSON_NODE_N05_CBLOCKKEY
                                           ( ( S_SEPARATE_CBLOCKKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CBLOCKKEY)
                                             | E_NODE);

C_NS_FLOW_MAP_JSON_KEY_ENTRY_N01_CFLOWKEY: C_FLOW_JSON_NODE_N01_CFLOWKEY
                                           ( ( S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N02_CFLOWKEY: C_FLOW_JSON_NODE_N02_CFLOWKEY
                                           ( ( S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N03_CFLOWKEY: C_FLOW_JSON_NODE_N03_CFLOWKEY
                                           ( ( S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N04_CFLOWKEY: C_FLOW_JSON_NODE_N04_CFLOWKEY
                                           ( ( S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWKEY)
                                             | E_NODE);
C_NS_FLOW_MAP_JSON_KEY_ENTRY_N05_CFLOWKEY: C_FLOW_JSON_NODE_N05_CFLOWKEY
                                           ( ( S_SEPARATE_CFLOWKEY? C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWKEY)
                                             | E_NODE);

//[149]	c-ns-flow-map-adjacent-value(n,c)	::=	“:” ( ( s-separate(n,c)? ns-flow-node(n,c) )
//                                              | e-node ) /* Value */
C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWOUT: ':' ( (S_SEPARATE_N01_CFLOWOUT? NS_FLOW_NODE_N01_CFLOWOUT) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWOUT: ':' ( (S_SEPARATE_N02_CFLOWOUT? NS_FLOW_NODE_N02_CFLOWOUT) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWOUT: ':' ( (S_SEPARATE_N03_CFLOWOUT? NS_FLOW_NODE_N03_CFLOWOUT) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWOUT: ':' ( (S_SEPARATE_N04_CFLOWOUT? NS_FLOW_NODE_N04_CFLOWOUT) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWOUT: ':' ( (S_SEPARATE_N05_CFLOWOUT? NS_FLOW_NODE_N05_CFLOWOUT) | E_NODE);
    
C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWIN: ':' ( (S_SEPARATE_N01_CFLOWIN? NS_FLOW_NODE_N01_CFLOWIN) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWIN: ':' ( (S_SEPARATE_N02_CFLOWIN? NS_FLOW_NODE_N02_CFLOWIN) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWIN: ':' ( (S_SEPARATE_N03_CFLOWIN? NS_FLOW_NODE_N03_CFLOWIN) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWIN: ':' ( (S_SEPARATE_N04_CFLOWIN? NS_FLOW_NODE_N04_CFLOWIN) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWIN: ':' ( (S_SEPARATE_N05_CFLOWIN? NS_FLOW_NODE_N05_CFLOWIN) | E_NODE);
    
C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CBLOCKKEY: ':' ( (S_SEPARATE_CBLOCKKEY? NS_FLOW_NODE_N01_CBLOCKKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CBLOCKKEY: ':' ( (S_SEPARATE_CBLOCKKEY? NS_FLOW_NODE_N02_CBLOCKKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CBLOCKKEY: ':' ( (S_SEPARATE_CBLOCKKEY? NS_FLOW_NODE_N03_CBLOCKKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CBLOCKKEY: ':' ( (S_SEPARATE_CBLOCKKEY? NS_FLOW_NODE_N04_CBLOCKKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CBLOCKKEY: ':' ( (S_SEPARATE_CBLOCKKEY? NS_FLOW_NODE_N05_CBLOCKKEY) | E_NODE);
    
C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWKEY: ':' ( (S_SEPARATE_CFLOWKEY? NS_FLOW_NODE_N01_CFLOWKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWKEY: ':' ( (S_SEPARATE_CFLOWKEY? NS_FLOW_NODE_N02_CFLOWKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWKEY: ':' ( (S_SEPARATE_CFLOWKEY? NS_FLOW_NODE_N03_CFLOWKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWKEY: ':' ( (S_SEPARATE_CFLOWKEY? NS_FLOW_NODE_N04_CFLOWKEY) | E_NODE);
C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWKEY: ':' ( (S_SEPARATE_CFLOWKEY? NS_FLOW_NODE_N05_CFLOWKEY) | E_NODE);
    

//[150]	ns-flow-pair(n,c)	::=	  ( “?” s-separate(n,c) ns-flow-map-explicit-entry(n,c) )
//                          | ns-flow-pair-entry(n,c)	 
NS_FLOW_PAIR_N01_CFLOWOUT: ('?' S_SEPARATE_N01_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWOUT)
                        | NS_FLOW_PAIR_ENTRY_N01_CFLOWOUT;
NS_FLOW_PAIR_N02_CFLOWOUT: ('?' S_SEPARATE_N02_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWOUT)
                        | NS_FLOW_PAIR_ENTRY_N02_CFLOWOUT;
NS_FLOW_PAIR_N03_CFLOWOUT: ('?' S_SEPARATE_N03_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWOUT)
                        | NS_FLOW_PAIR_ENTRY_N03_CFLOWOUT;
NS_FLOW_PAIR_N04_CFLOWOUT: ('?' S_SEPARATE_N04_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWOUT)
                        | NS_FLOW_PAIR_ENTRY_N04_CFLOWOUT;
NS_FLOW_PAIR_N05_CFLOWOUT: ('?' S_SEPARATE_N05_CFLOWOUT NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWOUT)
                        | NS_FLOW_PAIR_ENTRY_N05_CFLOWOUT;

NS_FLOW_PAIR_N01_CFLOWIN: ('?' S_SEPARATE_N01_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWIN)
                        | NS_FLOW_PAIR_ENTRY_N01_CFLOWIN;
NS_FLOW_PAIR_N02_CFLOWIN: ('?' S_SEPARATE_N02_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWIN)
                        | NS_FLOW_PAIR_ENTRY_N02_CFLOWIN;
NS_FLOW_PAIR_N03_CFLOWIN: ('?' S_SEPARATE_N03_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWIN)
                        | NS_FLOW_PAIR_ENTRY_N03_CFLOWIN;
NS_FLOW_PAIR_N04_CFLOWIN: ('?' S_SEPARATE_N04_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWIN)
                        | NS_FLOW_PAIR_ENTRY_N04_CFLOWIN;
NS_FLOW_PAIR_N05_CFLOWIN: ('?' S_SEPARATE_N05_CFLOWIN NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWIN)
                        | NS_FLOW_PAIR_ENTRY_N05_CFLOWIN;

NS_FLOW_PAIR_N01_CBLOCKKEY: ('?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CBLOCKKEY)
                        | NS_FLOW_PAIR_ENTRY_N01_CBLOCKKEY;
NS_FLOW_PAIR_N02_CBLOCKKEY: ('?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CBLOCKKEY)
                        | NS_FLOW_PAIR_ENTRY_N02_CBLOCKKEY;
NS_FLOW_PAIR_N03_CBLOCKKEY: ('?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CBLOCKKEY)
                        | NS_FLOW_PAIR_ENTRY_N03_CBLOCKKEY;
NS_FLOW_PAIR_N04_CBLOCKKEY: ('?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CBLOCKKEY)
                        | NS_FLOW_PAIR_ENTRY_N04_CBLOCKKEY;
NS_FLOW_PAIR_N05_CBLOCKKEY: ('?' S_SEPARATE_CBLOCKKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CBLOCKKEY)
                        | NS_FLOW_PAIR_ENTRY_N05_CBLOCKKEY;

NS_FLOW_PAIR_N01_CFLOWKEY: ('?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N01_CFLOWKEY)
                        | NS_FLOW_PAIR_ENTRY_N01_CFLOWKEY;
NS_FLOW_PAIR_N02_CFLOWKEY: ('?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N02_CFLOWKEY)
                        | NS_FLOW_PAIR_ENTRY_N02_CFLOWKEY;
NS_FLOW_PAIR_N03_CFLOWKEY: ('?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N03_CFLOWKEY)
                        | NS_FLOW_PAIR_ENTRY_N03_CFLOWKEY;
NS_FLOW_PAIR_N04_CFLOWKEY: ('?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N04_CFLOWKEY)
                        | NS_FLOW_PAIR_ENTRY_N04_CFLOWKEY;
NS_FLOW_PAIR_N05_CFLOWKEY: ('?' S_SEPARATE_CFLOWKEY NS_FLOW_MAP_EXPLICIT_ENTRY_N05_CFLOWKEY)
                        | NS_FLOW_PAIR_ENTRY_N05_CFLOWKEY;


// [151]	ns-flow-pair-entry(n,c)	::=	  ns-flow-pair-yaml-key-entry(n,c)
//                                  | c-ns-flow-map-empty-key-entry(n,c)
//                                  | c-ns-flow-pair-json-key-entry(n,c)
NS_FLOW_PAIR_ENTRY_N01_CFLOWOUT: NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWOUT
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWOUT
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWOUT;
NS_FLOW_PAIR_ENTRY_N02_CFLOWOUT: NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWOUT
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWOUT
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWOUT;
NS_FLOW_PAIR_ENTRY_N03_CFLOWOUT: NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWOUT
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWOUT
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWOUT;
NS_FLOW_PAIR_ENTRY_N04_CFLOWOUT: NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWOUT
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWOUT
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWOUT;
NS_FLOW_PAIR_ENTRY_N05_CFLOWOUT: NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWOUT
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWOUT
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWOUT;

NS_FLOW_PAIR_ENTRY_N01_CFLOWIN: NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWIN
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWIN
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWIN;
NS_FLOW_PAIR_ENTRY_N02_CFLOWIN: NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWIN
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWIN
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWIN;
NS_FLOW_PAIR_ENTRY_N03_CFLOWIN: NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWIN
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWIN
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWIN;
NS_FLOW_PAIR_ENTRY_N04_CFLOWIN: NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWIN
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWIN
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWIN;
NS_FLOW_PAIR_ENTRY_N05_CFLOWIN: NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWIN
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWIN
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWIN;

NS_FLOW_PAIR_ENTRY_N01_CBLOCKKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CBLOCKKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CBLOCKKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CBLOCKKEY;
NS_FLOW_PAIR_ENTRY_N02_CBLOCKKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CBLOCKKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CBLOCKKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CBLOCKKEY;
NS_FLOW_PAIR_ENTRY_N03_CBLOCKKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CBLOCKKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CBLOCKKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CBLOCKKEY;
NS_FLOW_PAIR_ENTRY_N04_CBLOCKKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CBLOCKKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CBLOCKKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CBLOCKKEY;
NS_FLOW_PAIR_ENTRY_N05_CBLOCKKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CBLOCKKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CBLOCKKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CBLOCKKEY;

NS_FLOW_PAIR_ENTRY_N01_CFLOWKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N01_CFLOWKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWKEY;
NS_FLOW_PAIR_ENTRY_N02_CFLOWKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N02_CFLOWKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWKEY;
NS_FLOW_PAIR_ENTRY_N03_CFLOWKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N03_CFLOWKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWKEY;
NS_FLOW_PAIR_ENTRY_N04_CFLOWKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N04_CFLOWKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWKEY;
NS_FLOW_PAIR_ENTRY_N05_CFLOWKEY: NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWKEY
                                | C_NS_FLOW_MAP_EMPTY_KEY_ENTRY_N05_CFLOWKEY
                                | C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWKEY;

// [152]	ns-flow-pair-yaml-key-entry(n,c) ::= ns-s-implicit-yaml-key(flow-key) c-ns-flow-map-separate-value(n,c)
NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWOUT: NS_S_IMPLICIT_YAML_KEY_CFLOWOUT C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWOUT;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWOUT: NS_S_IMPLICIT_YAML_KEY_CFLOWOUT C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWOUT;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWOUT: NS_S_IMPLICIT_YAML_KEY_CFLOWOUT C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWOUT;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWOUT: NS_S_IMPLICIT_YAML_KEY_CFLOWOUT C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWOUT;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWOUT: NS_S_IMPLICIT_YAML_KEY_CFLOWOUT C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWOUT;

NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWIN: NS_S_IMPLICIT_YAML_KEY_CFLOWIN C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWIN;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWIN: NS_S_IMPLICIT_YAML_KEY_CFLOWIN C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWIN;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWIN: NS_S_IMPLICIT_YAML_KEY_CFLOWIN C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWIN;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWIN: NS_S_IMPLICIT_YAML_KEY_CFLOWIN C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWIN;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWIN: NS_S_IMPLICIT_YAML_KEY_CFLOWIN C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWIN;

NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CBLOCKKEY: NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CBLOCKKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CBLOCKKEY: NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CBLOCKKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CBLOCKKEY: NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CBLOCKKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CBLOCKKEY: NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CBLOCKKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CBLOCKKEY: NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CBLOCKKEY;

NS_FLOW_PAIR_YAML_KEY_ENTRY_N01_CFLOWKEY: NS_S_IMPLICIT_YAML_KEY_CFLOWKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N01_CFLOWKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N02_CFLOWKEY: NS_S_IMPLICIT_YAML_KEY_CFLOWKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N02_CFLOWKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N03_CFLOWKEY: NS_S_IMPLICIT_YAML_KEY_CFLOWKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N03_CFLOWKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N04_CFLOWKEY: NS_S_IMPLICIT_YAML_KEY_CFLOWKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N04_CFLOWKEY;
NS_FLOW_PAIR_YAML_KEY_ENTRY_N05_CFLOWKEY: NS_S_IMPLICIT_YAML_KEY_CFLOWKEY C_NS_FLOW_MAP_SEPARATE_VALUE_N05_CFLOWKEY;


// [153]	c-ns-flow-pair-json-key-entry(n,c) ::= c-s-implicit-json-key(flow-key) c-ns-flow-map-adjacent-value(n,c)
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWOUT: C_S_IMPLICIT_JSON_KEY_CFLOWOUT C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWOUT;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWOUT: C_S_IMPLICIT_JSON_KEY_CFLOWOUT C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWOUT;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWOUT: C_S_IMPLICIT_JSON_KEY_CFLOWOUT C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWOUT;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWOUT: C_S_IMPLICIT_JSON_KEY_CFLOWOUT C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWOUT;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWOUT: C_S_IMPLICIT_JSON_KEY_CFLOWOUT C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWOUT;

C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWIN: C_S_IMPLICIT_JSON_KEY_CFLOWIN C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWIN;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWIN: C_S_IMPLICIT_JSON_KEY_CFLOWIN C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWIN;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWIN: C_S_IMPLICIT_JSON_KEY_CFLOWIN C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWIN;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWIN: C_S_IMPLICIT_JSON_KEY_CFLOWIN C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWIN;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWIN: C_S_IMPLICIT_JSON_KEY_CFLOWIN C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWIN;

C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CBLOCKKEY: C_S_IMPLICIT_JSON_KEY_CBLOCKKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CBLOCKKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CBLOCKKEY: C_S_IMPLICIT_JSON_KEY_CBLOCKKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CBLOCKKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CBLOCKKEY: C_S_IMPLICIT_JSON_KEY_CBLOCKKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CBLOCKKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CBLOCKKEY: C_S_IMPLICIT_JSON_KEY_CBLOCKKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CBLOCKKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CBLOCKKEY: C_S_IMPLICIT_JSON_KEY_CBLOCKKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CBLOCKKEY;

C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N01_CFLOWKEY: C_S_IMPLICIT_JSON_KEY_CFLOWKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N01_CFLOWKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N02_CFLOWKEY: C_S_IMPLICIT_JSON_KEY_CFLOWKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N02_CFLOWKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N03_CFLOWKEY: C_S_IMPLICIT_JSON_KEY_CFLOWKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N03_CFLOWKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N04_CFLOWKEY: C_S_IMPLICIT_JSON_KEY_CFLOWKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N04_CFLOWKEY;
C_NS_FLOW_PAIR_JSON_KEY_ENTRY_N05_CFLOWKEY: C_S_IMPLICIT_JSON_KEY_CFLOWKEY C_NS_FLOW_MAP_ADJACENT_VALUE_N05_CFLOWKEY;

// [154]	ns-s-implicit-yaml-key(c)	::=	ns-flow-yaml-node(n/a,c) s-separate-in-line?
// /* At most 1024 characters altogether */
//TODO try to understand what n/a means; meanwhile keep n/a=1 :)
NS_S_IMPLICIT_YAML_KEY_CFLOWOUT: NS_FLOW_YAML_NODE_N01_CFLOWOUT S_SEPARATE_IN_LINE?;
NS_S_IMPLICIT_YAML_KEY_CFLOWIN: NS_FLOW_YAML_NODE_N01_CFLOWIN S_SEPARATE_IN_LINE?;
NS_S_IMPLICIT_YAML_KEY_CBLOCKKEY: NS_FLOW_YAML_NODE_N01_CBLOCKKEY S_SEPARATE_IN_LINE?;
NS_S_IMPLICIT_YAML_KEY_CFLOWKEY: NS_FLOW_YAML_NODE_N01_CFLOWKEY S_SEPARATE_IN_LINE?;

// [155]	c-s-implicit-json-key(c)	::=	c-flow-json-node(n/a,c) s-separate-in-line?
// /* At most 1024 characters altogether */
//TODO try to understand what n/a means; meanwhile keep n/a=1 :)
C_S_IMPLICIT_JSON_KEY_CFLOWOUT: C_FLOW_JSON_NODE_N01_CFLOWOUT S_SEPARATE_IN_LINE?;  
C_S_IMPLICIT_JSON_KEY_CFLOWIN: C_FLOW_JSON_NODE_N01_CFLOWIN S_SEPARATE_IN_LINE?;  
C_S_IMPLICIT_JSON_KEY_CBLOCKKEY: C_FLOW_JSON_NODE_N01_CBLOCKKEY S_SEPARATE_IN_LINE?;
C_S_IMPLICIT_JSON_KEY_CFLOWKEY: C_FLOW_JSON_NODE_N01_CFLOWKEY S_SEPARATE_IN_LINE?;  


/*****************************************************************************
    7.5. Flow Nodes
*****************************************************************************/

// [156] ns-flow-yaml-content(n,c) ::= ns-plain(n,c)
NS_FLOW_YAML_CONTENT_N01_CFLOWOUT: NS_PLAIN_N01_CFLOWOUT;
NS_FLOW_YAML_CONTENT_N02_CFLOWOUT: NS_PLAIN_N02_CFLOWOUT;
NS_FLOW_YAML_CONTENT_N03_CFLOWOUT: NS_PLAIN_N03_CFLOWOUT;
NS_FLOW_YAML_CONTENT_N04_CFLOWOUT: NS_PLAIN_N04_CFLOWOUT;
NS_FLOW_YAML_CONTENT_N05_CFLOWOUT: NS_PLAIN_N05_CFLOWOUT;

NS_FLOW_YAML_CONTENT_N01_CFLOWIN: NS_PLAIN_N01_CFLOWIN;
NS_FLOW_YAML_CONTENT_N02_CFLOWIN: NS_PLAIN_N02_CFLOWIN;
NS_FLOW_YAML_CONTENT_N03_CFLOWIN: NS_PLAIN_N03_CFLOWIN;
NS_FLOW_YAML_CONTENT_N04_CFLOWIN: NS_PLAIN_N04_CFLOWIN;
NS_FLOW_YAML_CONTENT_N05_CFLOWIN: NS_PLAIN_N05_CFLOWIN;

NS_FLOW_YAML_CONTENT_N01_CBLOCKKEY: NS_PLAIN_CBLOCKKEY;
NS_FLOW_YAML_CONTENT_N02_CBLOCKKEY: NS_PLAIN_CBLOCKKEY;
NS_FLOW_YAML_CONTENT_N03_CBLOCKKEY: NS_PLAIN_CBLOCKKEY;
NS_FLOW_YAML_CONTENT_N04_CBLOCKKEY: NS_PLAIN_CBLOCKKEY;
NS_FLOW_YAML_CONTENT_N05_CBLOCKKEY: NS_PLAIN_CBLOCKKEY;

NS_FLOW_YAML_CONTENT_N01_CFLOWKEY: NS_PLAIN_CFLOWKEY;
NS_FLOW_YAML_CONTENT_N02_CFLOWKEY: NS_PLAIN_CFLOWKEY;
NS_FLOW_YAML_CONTENT_N03_CFLOWKEY: NS_PLAIN_CFLOWKEY;
NS_FLOW_YAML_CONTENT_N04_CFLOWKEY: NS_PLAIN_CFLOWKEY;
NS_FLOW_YAML_CONTENT_N05_CFLOWKEY: NS_PLAIN_CFLOWKEY;

// [157] c-flow-json-content(n,c) ::= c-flow-sequence(n,c) | c-flow-mapping(n,c) | c-single-quoted(n,c) | c-double-quoted(n,c)
C_FLOW_JSON_CONTENT_N01_CFLOWOUT: C_FLOW_SEQUENCE_N01_CFLOWOUT | C_FLOW_MAPPING_N01_CFLOWOUT
                                | C_SINGLE_QUOTED_N01_CFLOWOUT | C_DOUBLE_QUOTED_N01_CFLOWOUT;
C_FLOW_JSON_CONTENT_N02_CFLOWOUT: C_FLOW_SEQUENCE_N02_CFLOWOUT | C_FLOW_MAPPING_N02_CFLOWOUT
                                | C_SINGLE_QUOTED_N02_CFLOWOUT | C_DOUBLE_QUOTED_N02_CFLOWOUT;
C_FLOW_JSON_CONTENT_N03_CFLOWOUT: C_FLOW_SEQUENCE_N03_CFLOWOUT | C_FLOW_MAPPING_N03_CFLOWOUT
                                | C_SINGLE_QUOTED_N03_CFLOWOUT | C_DOUBLE_QUOTED_N03_CFLOWOUT;
C_FLOW_JSON_CONTENT_N04_CFLOWOUT: C_FLOW_SEQUENCE_N04_CFLOWOUT | C_FLOW_MAPPING_N04_CFLOWOUT
                                | C_SINGLE_QUOTED_N04_CFLOWOUT | C_DOUBLE_QUOTED_N04_CFLOWOUT;
C_FLOW_JSON_CONTENT_N05_CFLOWOUT: C_FLOW_SEQUENCE_N05_CFLOWOUT | C_FLOW_MAPPING_N05_CFLOWOUT
                                | C_SINGLE_QUOTED_N05_CFLOWOUT | C_DOUBLE_QUOTED_N05_CFLOWOUT;

C_FLOW_JSON_CONTENT_N01_CFLOWIN: C_FLOW_SEQUENCE_N01_CFLOWIN | C_FLOW_MAPPING_N01_CFLOWIN
                                | C_SINGLE_QUOTED_N01_CFLOWIN | C_DOUBLE_QUOTED_N01_CFLOWIN;
C_FLOW_JSON_CONTENT_N02_CFLOWIN: C_FLOW_SEQUENCE_N02_CFLOWIN | C_FLOW_MAPPING_N02_CFLOWIN
                                | C_SINGLE_QUOTED_N02_CFLOWIN | C_DOUBLE_QUOTED_N02_CFLOWIN;
C_FLOW_JSON_CONTENT_N03_CFLOWIN: C_FLOW_SEQUENCE_N03_CFLOWIN | C_FLOW_MAPPING_N03_CFLOWIN
                                | C_SINGLE_QUOTED_N03_CFLOWIN | C_DOUBLE_QUOTED_N03_CFLOWIN;
C_FLOW_JSON_CONTENT_N04_CFLOWIN: C_FLOW_SEQUENCE_N04_CFLOWIN | C_FLOW_MAPPING_N04_CFLOWIN
                                | C_SINGLE_QUOTED_N04_CFLOWIN | C_DOUBLE_QUOTED_N04_CFLOWIN;
C_FLOW_JSON_CONTENT_N05_CFLOWIN: C_FLOW_SEQUENCE_N05_CFLOWIN | C_FLOW_MAPPING_N05_CFLOWIN
                                | C_SINGLE_QUOTED_N05_CFLOWIN | C_DOUBLE_QUOTED_N05_CFLOWIN;

C_FLOW_JSON_CONTENT_N01_CBLOCKKEY: C_FLOW_SEQUENCE_N01_CBLOCKKEY | C_FLOW_MAPPING_N01_CBLOCKKEY
                                | C_SINGLE_QUOTED_N01_CBLOCKKEY | C_DOUBLE_QUOTED_N01_CBLOCKKEY;
C_FLOW_JSON_CONTENT_N02_CBLOCKKEY: C_FLOW_SEQUENCE_N02_CBLOCKKEY | C_FLOW_MAPPING_N02_CBLOCKKEY
                                | C_SINGLE_QUOTED_N02_CBLOCKKEY | C_DOUBLE_QUOTED_N02_CBLOCKKEY;
C_FLOW_JSON_CONTENT_N03_CBLOCKKEY: C_FLOW_SEQUENCE_N03_CBLOCKKEY | C_FLOW_MAPPING_N03_CBLOCKKEY
                                | C_SINGLE_QUOTED_N03_CBLOCKKEY | C_DOUBLE_QUOTED_N03_CBLOCKKEY;
C_FLOW_JSON_CONTENT_N04_CBLOCKKEY: C_FLOW_SEQUENCE_N04_CBLOCKKEY | C_FLOW_MAPPING_N04_CBLOCKKEY
                                | C_SINGLE_QUOTED_N04_CBLOCKKEY | C_DOUBLE_QUOTED_N04_CBLOCKKEY;
C_FLOW_JSON_CONTENT_N05_CBLOCKKEY: C_FLOW_SEQUENCE_N05_CBLOCKKEY | C_FLOW_MAPPING_N05_CBLOCKKEY
                                | C_SINGLE_QUOTED_N05_CBLOCKKEY | C_DOUBLE_QUOTED_N05_CBLOCKKEY;

C_FLOW_JSON_CONTENT_N01_CFLOWKEY: C_FLOW_SEQUENCE_N01_CFLOWKEY | C_FLOW_MAPPING_N01_CFLOWKEY
                                | C_SINGLE_QUOTED_N01_CFLOWKEY | C_DOUBLE_QUOTED_N01_CFLOWKEY;
C_FLOW_JSON_CONTENT_N02_CFLOWKEY: C_FLOW_SEQUENCE_N02_CFLOWKEY | C_FLOW_MAPPING_N02_CFLOWKEY
                                | C_SINGLE_QUOTED_N02_CFLOWKEY | C_DOUBLE_QUOTED_N02_CFLOWKEY;
C_FLOW_JSON_CONTENT_N03_CFLOWKEY: C_FLOW_SEQUENCE_N03_CFLOWKEY | C_FLOW_MAPPING_N03_CFLOWKEY
                                | C_SINGLE_QUOTED_N03_CFLOWKEY | C_DOUBLE_QUOTED_N03_CFLOWKEY;
C_FLOW_JSON_CONTENT_N04_CFLOWKEY: C_FLOW_SEQUENCE_N04_CFLOWKEY | C_FLOW_MAPPING_N04_CFLOWKEY
                                | C_SINGLE_QUOTED_N04_CFLOWKEY | C_DOUBLE_QUOTED_N04_CFLOWKEY;
C_FLOW_JSON_CONTENT_N05_CFLOWKEY: C_FLOW_SEQUENCE_N05_CFLOWKEY | C_FLOW_MAPPING_N05_CFLOWKEY
                                | C_SINGLE_QUOTED_N05_CFLOWKEY | C_DOUBLE_QUOTED_N05_CFLOWKEY;


// [158] ns-flow-content(n,c) ::= ns-flow-yaml-content(n,c) | c-flow-json-content(n,c)
NS_FLOW_CONTENT_N01_CFLOWOUT: NS_FLOW_YAML_CONTENT_N01_CFLOWOUT | C_FLOW_JSON_CONTENT_N01_CFLOWOUT;
NS_FLOW_CONTENT_N02_CFLOWOUT: NS_FLOW_YAML_CONTENT_N02_CFLOWOUT | C_FLOW_JSON_CONTENT_N02_CFLOWOUT;
NS_FLOW_CONTENT_N03_CFLOWOUT: NS_FLOW_YAML_CONTENT_N03_CFLOWOUT | C_FLOW_JSON_CONTENT_N03_CFLOWOUT;
NS_FLOW_CONTENT_N04_CFLOWOUT: NS_FLOW_YAML_CONTENT_N04_CFLOWOUT | C_FLOW_JSON_CONTENT_N04_CFLOWOUT;
NS_FLOW_CONTENT_N05_CFLOWOUT: NS_FLOW_YAML_CONTENT_N05_CFLOWOUT | C_FLOW_JSON_CONTENT_N05_CFLOWOUT;

NS_FLOW_CONTENT_N01_CFLOWIN: NS_FLOW_YAML_CONTENT_N01_CFLOWIN | C_FLOW_JSON_CONTENT_N01_CFLOWIN;
NS_FLOW_CONTENT_N02_CFLOWIN: NS_FLOW_YAML_CONTENT_N02_CFLOWIN | C_FLOW_JSON_CONTENT_N02_CFLOWIN;
NS_FLOW_CONTENT_N03_CFLOWIN: NS_FLOW_YAML_CONTENT_N03_CFLOWIN | C_FLOW_JSON_CONTENT_N03_CFLOWIN;
NS_FLOW_CONTENT_N04_CFLOWIN: NS_FLOW_YAML_CONTENT_N04_CFLOWIN | C_FLOW_JSON_CONTENT_N04_CFLOWIN;
NS_FLOW_CONTENT_N05_CFLOWIN: NS_FLOW_YAML_CONTENT_N05_CFLOWIN | C_FLOW_JSON_CONTENT_N05_CFLOWIN;

NS_FLOW_CONTENT_N01_CBLOCKKEY: NS_FLOW_YAML_CONTENT_N01_CBLOCKKEY | C_FLOW_JSON_CONTENT_N01_CBLOCKKEY;
NS_FLOW_CONTENT_N02_CBLOCKKEY: NS_FLOW_YAML_CONTENT_N02_CBLOCKKEY | C_FLOW_JSON_CONTENT_N02_CBLOCKKEY;
NS_FLOW_CONTENT_N03_CBLOCKKEY: NS_FLOW_YAML_CONTENT_N03_CBLOCKKEY | C_FLOW_JSON_CONTENT_N03_CBLOCKKEY;
NS_FLOW_CONTENT_N04_CBLOCKKEY: NS_FLOW_YAML_CONTENT_N04_CBLOCKKEY | C_FLOW_JSON_CONTENT_N04_CBLOCKKEY;
NS_FLOW_CONTENT_N05_CBLOCKKEY: NS_FLOW_YAML_CONTENT_N05_CBLOCKKEY | C_FLOW_JSON_CONTENT_N05_CBLOCKKEY;

NS_FLOW_CONTENT_N01_CFLOWKEY: NS_FLOW_YAML_CONTENT_N01_CFLOWKEY | C_FLOW_JSON_CONTENT_N01_CFLOWKEY;
NS_FLOW_CONTENT_N02_CFLOWKEY: NS_FLOW_YAML_CONTENT_N02_CFLOWKEY | C_FLOW_JSON_CONTENT_N02_CFLOWKEY;
NS_FLOW_CONTENT_N03_CFLOWKEY: NS_FLOW_YAML_CONTENT_N03_CFLOWKEY | C_FLOW_JSON_CONTENT_N03_CFLOWKEY;
NS_FLOW_CONTENT_N04_CFLOWKEY: NS_FLOW_YAML_CONTENT_N04_CFLOWKEY | C_FLOW_JSON_CONTENT_N04_CFLOWKEY;
NS_FLOW_CONTENT_N05_CFLOWKEY: NS_FLOW_YAML_CONTENT_N05_CFLOWKEY | C_FLOW_JSON_CONTENT_N05_CFLOWKEY;

// [159] ns-flow-yaml-node(n,c) ::= c-ns-alias-node
//                              | ns-flow-yaml-content(n,c)
//                              | ( c-ns-properties(n,c)
//                                  ( ( s-separate(n,c) ns-flow-yaml-content(n,c) )
//                                  | e-scalar ) )
NS_FLOW_YAML_NODE_N01_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N01_CFLOWOUT
                            | ( C_NS_PROPERTIES_N01_CFLOWOUT
                                ( (S_SEPARATE_N01_CFLOWOUT NS_FLOW_YAML_CONTENT_N01_CFLOWOUT)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N02_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N02_CFLOWOUT
                            | ( C_NS_PROPERTIES_N02_CFLOWOUT
                                ( (S_SEPARATE_N02_CFLOWOUT NS_FLOW_YAML_CONTENT_N02_CFLOWOUT)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N03_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N03_CFLOWOUT
                            | ( C_NS_PROPERTIES_N03_CFLOWOUT
                                ( (S_SEPARATE_N03_CFLOWOUT NS_FLOW_YAML_CONTENT_N03_CFLOWOUT)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N04_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N04_CFLOWOUT
                            | ( C_NS_PROPERTIES_N04_CFLOWOUT
                                ( (S_SEPARATE_N04_CFLOWOUT NS_FLOW_YAML_CONTENT_N04_CFLOWOUT)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N05_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N05_CFLOWOUT
                            | ( C_NS_PROPERTIES_N05_CFLOWOUT
                                ( (S_SEPARATE_N05_CFLOWOUT NS_FLOW_YAML_CONTENT_N05_CFLOWOUT)
                                | E_SCALAR));

NS_FLOW_YAML_NODE_N01_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N01_CFLOWIN
                            | ( C_NS_PROPERTIES_N01_CFLOWIN
                                ( (S_SEPARATE_N01_CFLOWIN NS_FLOW_YAML_CONTENT_N01_CFLOWIN)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N02_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N02_CFLOWIN
                            | ( C_NS_PROPERTIES_N02_CFLOWIN
                                ( (S_SEPARATE_N02_CFLOWIN NS_FLOW_YAML_CONTENT_N02_CFLOWIN)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N03_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N03_CFLOWIN
                            | ( C_NS_PROPERTIES_N03_CFLOWIN
                                ( (S_SEPARATE_N03_CFLOWIN NS_FLOW_YAML_CONTENT_N03_CFLOWIN)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N04_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N04_CFLOWIN
                            | ( C_NS_PROPERTIES_N04_CFLOWIN
                                ( (S_SEPARATE_N04_CFLOWIN NS_FLOW_YAML_CONTENT_N04_CFLOWIN)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N05_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N05_CFLOWIN
                            | ( C_NS_PROPERTIES_N05_CFLOWIN
                                ( (S_SEPARATE_N05_CFLOWIN NS_FLOW_YAML_CONTENT_N05_CFLOWIN)
                                | E_SCALAR));

NS_FLOW_YAML_NODE_N01_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N01_CBLOCKKEY
                            | ( C_NS_PROPERTIES_N01_CBLOCKKEY
                                ( (S_SEPARATE_CBLOCKKEY NS_FLOW_YAML_CONTENT_N01_CBLOCKKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N02_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N02_CBLOCKKEY
                            | ( C_NS_PROPERTIES_N02_CBLOCKKEY
                                ( (S_SEPARATE_CBLOCKKEY NS_FLOW_YAML_CONTENT_N02_CBLOCKKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N03_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N03_CBLOCKKEY
                            | ( C_NS_PROPERTIES_N03_CBLOCKKEY
                                ( (S_SEPARATE_CBLOCKKEY NS_FLOW_YAML_CONTENT_N03_CBLOCKKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N04_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N04_CBLOCKKEY
                            | ( C_NS_PROPERTIES_N04_CBLOCKKEY
                                ( (S_SEPARATE_CBLOCKKEY NS_FLOW_YAML_CONTENT_N04_CBLOCKKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N05_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N05_CBLOCKKEY
                            | ( C_NS_PROPERTIES_N05_CBLOCKKEY
                                ( (S_SEPARATE_CBLOCKKEY NS_FLOW_YAML_CONTENT_N05_CBLOCKKEY)
                                | E_SCALAR));

NS_FLOW_YAML_NODE_N01_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N01_CFLOWKEY
                            | ( C_NS_PROPERTIES_N01_CFLOWKEY
                                ( (S_SEPARATE_CFLOWKEY NS_FLOW_YAML_CONTENT_N01_CFLOWKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N02_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N02_CFLOWKEY
                            | ( C_NS_PROPERTIES_N02_CFLOWKEY
                                ( (S_SEPARATE_CFLOWKEY NS_FLOW_YAML_CONTENT_N02_CFLOWKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N03_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N03_CFLOWKEY
                            | ( C_NS_PROPERTIES_N03_CFLOWKEY
                                ( (S_SEPARATE_CFLOWKEY NS_FLOW_YAML_CONTENT_N03_CFLOWKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N04_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N04_CFLOWKEY
                            | ( C_NS_PROPERTIES_N04_CFLOWKEY
                                ( (S_SEPARATE_CFLOWKEY NS_FLOW_YAML_CONTENT_N04_CFLOWKEY)
                                | E_SCALAR));
NS_FLOW_YAML_NODE_N05_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_YAML_CONTENT_N05_CFLOWKEY
                            | ( C_NS_PROPERTIES_N05_CFLOWKEY
                                ( (S_SEPARATE_CFLOWKEY NS_FLOW_YAML_CONTENT_N05_CFLOWKEY)
                                | E_SCALAR));

// [160] c-flow-json-node(n,c) ::= ( c-ns-properties(n,c) s-separate(n,c) )? c-flow-json-content(n,c)
C_FLOW_JSON_NODE_N01_CFLOWOUT: (C_NS_PROPERTIES_N01_CFLOWOUT S_SEPARATE_N01_CFLOWOUT)? C_FLOW_JSON_CONTENT_N01_CFLOWOUT;
C_FLOW_JSON_NODE_N02_CFLOWOUT: (C_NS_PROPERTIES_N02_CFLOWOUT S_SEPARATE_N02_CFLOWOUT)? C_FLOW_JSON_CONTENT_N02_CFLOWOUT;
C_FLOW_JSON_NODE_N03_CFLOWOUT: (C_NS_PROPERTIES_N03_CFLOWOUT S_SEPARATE_N03_CFLOWOUT)? C_FLOW_JSON_CONTENT_N03_CFLOWOUT;
C_FLOW_JSON_NODE_N04_CFLOWOUT: (C_NS_PROPERTIES_N04_CFLOWOUT S_SEPARATE_N04_CFLOWOUT)? C_FLOW_JSON_CONTENT_N04_CFLOWOUT;
C_FLOW_JSON_NODE_N05_CFLOWOUT: (C_NS_PROPERTIES_N05_CFLOWOUT S_SEPARATE_N05_CFLOWOUT)? C_FLOW_JSON_CONTENT_N05_CFLOWOUT;

C_FLOW_JSON_NODE_N01_CFLOWIN: (C_NS_PROPERTIES_N01_CFLOWIN S_SEPARATE_N01_CFLOWIN)? C_FLOW_JSON_CONTENT_N01_CFLOWIN;
C_FLOW_JSON_NODE_N02_CFLOWIN: (C_NS_PROPERTIES_N02_CFLOWIN S_SEPARATE_N02_CFLOWIN)? C_FLOW_JSON_CONTENT_N02_CFLOWIN;
C_FLOW_JSON_NODE_N03_CFLOWIN: (C_NS_PROPERTIES_N03_CFLOWIN S_SEPARATE_N03_CFLOWIN)? C_FLOW_JSON_CONTENT_N03_CFLOWIN;
C_FLOW_JSON_NODE_N04_CFLOWIN: (C_NS_PROPERTIES_N04_CFLOWIN S_SEPARATE_N04_CFLOWIN)? C_FLOW_JSON_CONTENT_N04_CFLOWIN;
C_FLOW_JSON_NODE_N05_CFLOWIN: (C_NS_PROPERTIES_N05_CFLOWIN S_SEPARATE_N05_CFLOWIN)? C_FLOW_JSON_CONTENT_N05_CFLOWIN;

C_FLOW_JSON_NODE_N01_CBLOCKKEY: (C_NS_PROPERTIES_N01_CBLOCKKEY S_SEPARATE_CBLOCKKEY)? C_FLOW_JSON_CONTENT_N01_CBLOCKKEY;
C_FLOW_JSON_NODE_N02_CBLOCKKEY: (C_NS_PROPERTIES_N02_CBLOCKKEY S_SEPARATE_CBLOCKKEY)? C_FLOW_JSON_CONTENT_N02_CBLOCKKEY;
C_FLOW_JSON_NODE_N03_CBLOCKKEY: (C_NS_PROPERTIES_N03_CBLOCKKEY S_SEPARATE_CBLOCKKEY)? C_FLOW_JSON_CONTENT_N03_CBLOCKKEY;
C_FLOW_JSON_NODE_N04_CBLOCKKEY: (C_NS_PROPERTIES_N04_CBLOCKKEY S_SEPARATE_CBLOCKKEY)? C_FLOW_JSON_CONTENT_N04_CBLOCKKEY;
C_FLOW_JSON_NODE_N05_CBLOCKKEY: (C_NS_PROPERTIES_N05_CBLOCKKEY S_SEPARATE_CBLOCKKEY)? C_FLOW_JSON_CONTENT_N05_CBLOCKKEY;

C_FLOW_JSON_NODE_N01_CFLOWKEY: (C_NS_PROPERTIES_N01_CFLOWKEY S_SEPARATE_CFLOWKEY)? C_FLOW_JSON_CONTENT_N01_CFLOWKEY;
C_FLOW_JSON_NODE_N02_CFLOWKEY: (C_NS_PROPERTIES_N02_CFLOWKEY S_SEPARATE_CFLOWKEY)? C_FLOW_JSON_CONTENT_N02_CFLOWKEY;
C_FLOW_JSON_NODE_N03_CFLOWKEY: (C_NS_PROPERTIES_N03_CFLOWKEY S_SEPARATE_CFLOWKEY)? C_FLOW_JSON_CONTENT_N03_CFLOWKEY;
C_FLOW_JSON_NODE_N04_CFLOWKEY: (C_NS_PROPERTIES_N04_CFLOWKEY S_SEPARATE_CFLOWKEY)? C_FLOW_JSON_CONTENT_N04_CFLOWKEY;
C_FLOW_JSON_NODE_N05_CFLOWKEY: (C_NS_PROPERTIES_N05_CFLOWKEY S_SEPARATE_CFLOWKEY)? C_FLOW_JSON_CONTENT_N05_CFLOWKEY;

// [161] ns-flow-node(n,c) ::= c-ns-alias-node | ns-flow-content(n,c)
//                          | ( c-ns-properties(n,c) (
//                              ( s-separate(n,c) ns-flow-content(n,c) )
//                              | e-scalar ) )
NS_FLOW_NODE_N01_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N01_CFLOWOUT
                        | (C_NS_PROPERTIES_N01_CFLOWOUT (
                            (S_SEPARATE_N01_CFLOWOUT NS_FLOW_CONTENT_N01_CFLOWOUT)
                            | E_SCALAR));
NS_FLOW_NODE_N02_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N02_CFLOWOUT
                        | (C_NS_PROPERTIES_N02_CFLOWOUT (
                            (S_SEPARATE_N02_CFLOWOUT NS_FLOW_CONTENT_N02_CFLOWOUT)
                            | E_SCALAR));
NS_FLOW_NODE_N03_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N03_CFLOWOUT
                        | (C_NS_PROPERTIES_N03_CFLOWOUT (
                            (S_SEPARATE_N03_CFLOWOUT NS_FLOW_CONTENT_N03_CFLOWOUT)
                            | E_SCALAR));
NS_FLOW_NODE_N04_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N04_CFLOWOUT
                        | (C_NS_PROPERTIES_N04_CFLOWOUT (
                            (S_SEPARATE_N04_CFLOWOUT NS_FLOW_CONTENT_N04_CFLOWOUT)
                            | E_SCALAR));
NS_FLOW_NODE_N05_CFLOWOUT: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N05_CFLOWOUT
                        | (C_NS_PROPERTIES_N05_CFLOWOUT (
                            (S_SEPARATE_N05_CFLOWOUT NS_FLOW_CONTENT_N05_CFLOWOUT)
                            | E_SCALAR));

NS_FLOW_NODE_N01_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N01_CFLOWIN
                        | (C_NS_PROPERTIES_N01_CFLOWIN (
                            (S_SEPARATE_N01_CFLOWIN NS_FLOW_CONTENT_N01_CFLOWIN)
                            | E_SCALAR));
NS_FLOW_NODE_N02_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N02_CFLOWIN
                        | (C_NS_PROPERTIES_N02_CFLOWIN (
                            (S_SEPARATE_N02_CFLOWIN NS_FLOW_CONTENT_N02_CFLOWIN)
                            | E_SCALAR));
NS_FLOW_NODE_N03_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N03_CFLOWIN
                        | (C_NS_PROPERTIES_N03_CFLOWIN (
                            (S_SEPARATE_N03_CFLOWIN NS_FLOW_CONTENT_N03_CFLOWIN)
                            | E_SCALAR));
NS_FLOW_NODE_N04_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N04_CFLOWIN
                        | (C_NS_PROPERTIES_N04_CFLOWIN (
                            (S_SEPARATE_N04_CFLOWIN NS_FLOW_CONTENT_N04_CFLOWIN)
                            | E_SCALAR));
NS_FLOW_NODE_N05_CFLOWIN: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N05_CFLOWIN
                        | (C_NS_PROPERTIES_N05_CFLOWIN (
                            (S_SEPARATE_N05_CFLOWIN NS_FLOW_CONTENT_N05_CFLOWIN)
                            | E_SCALAR));

NS_FLOW_NODE_N01_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N01_CBLOCKKEY
                        | (C_NS_PROPERTIES_N01_CBLOCKKEY (
                            (S_SEPARATE_CBLOCKKEY NS_FLOW_CONTENT_N01_CBLOCKKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N02_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N02_CBLOCKKEY
                        | (C_NS_PROPERTIES_N02_CBLOCKKEY (
                            (S_SEPARATE_CBLOCKKEY NS_FLOW_CONTENT_N02_CBLOCKKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N03_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N03_CBLOCKKEY
                        | (C_NS_PROPERTIES_N03_CBLOCKKEY (
                            (S_SEPARATE_CBLOCKKEY NS_FLOW_CONTENT_N03_CBLOCKKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N04_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N04_CBLOCKKEY
                        | (C_NS_PROPERTIES_N04_CBLOCKKEY (
                            (S_SEPARATE_CBLOCKKEY NS_FLOW_CONTENT_N04_CBLOCKKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N05_CBLOCKKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N05_CBLOCKKEY
                        | (C_NS_PROPERTIES_N05_CBLOCKKEY (
                            (S_SEPARATE_CBLOCKKEY NS_FLOW_CONTENT_N05_CBLOCKKEY)
                            | E_SCALAR));

NS_FLOW_NODE_N01_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N01_CFLOWKEY
                        | (C_NS_PROPERTIES_N01_CFLOWKEY (
                            (S_SEPARATE_CFLOWKEY NS_FLOW_CONTENT_N01_CFLOWKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N02_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N02_CFLOWKEY
                        | (C_NS_PROPERTIES_N02_CFLOWKEY (
                            (S_SEPARATE_CFLOWKEY NS_FLOW_CONTENT_N02_CFLOWKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N03_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N03_CFLOWKEY
                        | (C_NS_PROPERTIES_N03_CFLOWKEY (
                            (S_SEPARATE_CFLOWKEY NS_FLOW_CONTENT_N03_CFLOWKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N04_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N04_CFLOWKEY
                        | (C_NS_PROPERTIES_N04_CFLOWKEY (
                            (S_SEPARATE_CFLOWKEY NS_FLOW_CONTENT_N04_CFLOWKEY)
                            | E_SCALAR));
NS_FLOW_NODE_N05_CFLOWKEY: C_NS_ALIAS_NODE | NS_FLOW_CONTENT_N05_CFLOWKEY
                        | (C_NS_PROPERTIES_N05_CFLOWKEY (
                            (S_SEPARATE_CFLOWKEY NS_FLOW_CONTENT_N05_CFLOWKEY)
                            | E_SCALAR));






















