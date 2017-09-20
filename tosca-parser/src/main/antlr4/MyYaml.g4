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
S_INDENT_01: S_SPACE;
S_INDENT_02: S_INDENT_01 S_SPACE;
S_INDENT_03: S_INDENT_02 S_SPACE;
S_INDENT_04: S_INDENT_03 S_SPACE;
S_INDENT_05: S_INDENT_04 S_SPACE;

// [64]	s-indent(<n)	::=	s-space × m /* Where m < n */
S_INDENT_LT_N_02: S_INDENT_01;
S_INDENT_LT_N_03: S_INDENT_01 | S_INDENT_02;
S_INDENT_LT_N_04: S_INDENT_01 | S_INDENT_02 | S_INDENT_03;
S_INDENT_LT_N_05: S_INDENT_01 | S_INDENT_02 | S_INDENT_03 | S_INDENT_04;

// [65]	s-indent(≤n)	::=	s-space × m /* Where m ≤ n */
S_INDENT_LE_N_02: S_INDENT_LT_N_02 | S_INDENT_02;
S_INDENT_LE_N_03: S_INDENT_LT_N_03 | S_INDENT_03;
S_INDENT_LE_N_04: S_INDENT_LT_N_04 | S_INDENT_04;
S_INDENT_LE_N_05: S_INDENT_LT_N_05 | S_INDENT_05;

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
S_LINE_PREFIX_01: S_BLOCK_LINE_PREFIX_01 | S_FLOW_LINE_PREFIX_01;
S_LINE_PREFIX_02: S_BLOCK_LINE_PREFIX_02 | S_FLOW_LINE_PREFIX_02;
S_LINE_PREFIX_03: S_BLOCK_LINE_PREFIX_03 | S_FLOW_LINE_PREFIX_03;
S_LINE_PREFIX_04: S_BLOCK_LINE_PREFIX_04 | S_FLOW_LINE_PREFIX_04;
S_LINE_PREFIX_05: S_BLOCK_LINE_PREFIX_05 | S_FLOW_LINE_PREFIX_05;

/*
mode BLOCK_IN;
TEMP_POP_BLOCK_IN: '$$$' -> popMode; // TODO: find a real popMode token for this mode
fragment S_LINE_PREFIX_01: S_BLOCK_LINE_PREFIX_01;

mode BLOCK_OUT;
// Rule [67], 	s-line-prefix(n,c)	::=	c = block-in ⇒ s-block-line-prefix(n)
TEMP_POP_BLOCK_OUT: '$$$' -> popMode; // TODO: find a real popMode token for this mode
fragment S_LINE_PREFIX_01ZZZ: S_BLOCK_LINE_PREFIX_01;

mode FLOW_IN;
TEMP_POP_FLOW_IN: '$$$' -> popMode; // TODO: find a real popMode token for this mode

mode FLOW_OUT;
TEMP_POP_FLOW_OUT: '$$$' -> popMode; // TODO: find a real popMode token for this mode
*/

// [68]	s-block-line-prefix(n)	::=	s-indent(n)
S_BLOCK_LINE_PREFIX_01: S_INDENT_01;
S_BLOCK_LINE_PREFIX_02: S_INDENT_02;
S_BLOCK_LINE_PREFIX_03: S_INDENT_03;
S_BLOCK_LINE_PREFIX_04: S_INDENT_04;
S_BLOCK_LINE_PREFIX_05: S_INDENT_05;

// [69]	s-flow-line-prefix(n)	::=	s-indent(n) s-separate-in-line?
S_FLOW_LINE_PREFIX_01: S_INDENT_01 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_02: S_INDENT_02 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_03: S_INDENT_03 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_04: S_INDENT_04 S_SEPARATE_IN_LINE?;
S_FLOW_LINE_PREFIX_05: S_INDENT_05 S_SEPARATE_IN_LINE?;

/*****************************************************************************
    6.4. Empty Lines
*****************************************************************************/

// [70]	l-empty(n,c)	::=	( s-line-prefix(n,c) | s-indent(<n) ) b-as-line-feed
L_EMPTY_01_BLOCK_IN: (S_BLOCK_LINE_PREFIX_01)? B_AS_LINE_FEED;
L_EMPTY_02_BLOCK_IN: (S_BLOCK_LINE_PREFIX_02 | S_INDENT_LT_N_02) B_AS_LINE_FEED;
L_EMPTY_03_BLOCK_IN: (S_BLOCK_LINE_PREFIX_03 | S_INDENT_LT_N_03) B_AS_LINE_FEED;
L_EMPTY_04_BLOCK_IN: (S_BLOCK_LINE_PREFIX_04 | S_INDENT_LT_N_04) B_AS_LINE_FEED;
L_EMPTY_05_BLOCK_IN: (S_BLOCK_LINE_PREFIX_05 | S_INDENT_LT_N_05) B_AS_LINE_FEED;

L_EMPTY_01_BLOCK_OUT: (S_BLOCK_LINE_PREFIX_01)? B_AS_LINE_FEED;
L_EMPTY_02_BLOCK_OUT: (S_BLOCK_LINE_PREFIX_02 | S_INDENT_LT_N_02) B_AS_LINE_FEED;
L_EMPTY_03_BLOCK_OUT: (S_BLOCK_LINE_PREFIX_03 | S_INDENT_LT_N_03) B_AS_LINE_FEED;
L_EMPTY_04_BLOCK_OUT: (S_BLOCK_LINE_PREFIX_04 | S_INDENT_LT_N_04) B_AS_LINE_FEED;
L_EMPTY_05_BLOCK_OUT: (S_BLOCK_LINE_PREFIX_05 | S_INDENT_LT_N_05) B_AS_LINE_FEED;

L_EMPTY_01_FLOW_IN: (S_FLOW_LINE_PREFIX_01)? B_AS_LINE_FEED;
L_EMPTY_02_FLOW_IN: (S_FLOW_LINE_PREFIX_02 | S_INDENT_LT_N_02) B_AS_LINE_FEED;
L_EMPTY_03_FLOW_IN: (S_FLOW_LINE_PREFIX_03 | S_INDENT_LT_N_03) B_AS_LINE_FEED;
L_EMPTY_04_FLOW_IN: (S_FLOW_LINE_PREFIX_04 | S_INDENT_LT_N_04) B_AS_LINE_FEED;
L_EMPTY_05_FLOW_IN: (S_FLOW_LINE_PREFIX_05 | S_INDENT_LT_N_05) B_AS_LINE_FEED;

L_EMPTY_01_FLOW_OUT: (S_FLOW_LINE_PREFIX_01)? B_AS_LINE_FEED;
L_EMPTY_02_FLOW_OUT: (S_FLOW_LINE_PREFIX_02 | S_INDENT_LT_N_02) B_AS_LINE_FEED;
L_EMPTY_03_FLOW_OUT: (S_FLOW_LINE_PREFIX_03 | S_INDENT_LT_N_03) B_AS_LINE_FEED;
L_EMPTY_04_FLOW_OUT: (S_FLOW_LINE_PREFIX_04 | S_INDENT_LT_N_04) B_AS_LINE_FEED;
L_EMPTY_05_FLOW_OUT: (S_FLOW_LINE_PREFIX_05 | S_INDENT_LT_N_05) B_AS_LINE_FEED;


/*****************************************************************************
    6.5. Line Folding
*****************************************************************************/

// [71]	b-l-trimmed(n,c)	::=	b-non-content l-empty(n,c)+
B_L_TRIMMED_01_BLOCK_IN: B_NON_CONTENT L_EMPTY_01_BLOCK_IN+;
B_L_TRIMMED_02_BLOCK_IN: B_NON_CONTENT L_EMPTY_02_BLOCK_IN+;
B_L_TRIMMED_03_BLOCK_IN: B_NON_CONTENT L_EMPTY_03_BLOCK_IN+;
B_L_TRIMMED_04_BLOCK_IN: B_NON_CONTENT L_EMPTY_04_BLOCK_IN+;
B_L_TRIMMED_05_BLOCK_IN: B_NON_CONTENT L_EMPTY_05_BLOCK_IN+;

B_L_TRIMMED_01_BLOCK_OUT: B_NON_CONTENT L_EMPTY_01_BLOCK_OUT+;
B_L_TRIMMED_02_BLOCK_OUT: B_NON_CONTENT L_EMPTY_02_BLOCK_OUT+;
B_L_TRIMMED_03_BLOCK_OUT: B_NON_CONTENT L_EMPTY_03_BLOCK_OUT+;
B_L_TRIMMED_04_BLOCK_OUT: B_NON_CONTENT L_EMPTY_04_BLOCK_OUT+;
B_L_TRIMMED_05_BLOCK_OUT: B_NON_CONTENT L_EMPTY_05_BLOCK_OUT+;

B_L_TRIMMED_01_FLOW_IN: B_NON_CONTENT L_EMPTY_01_FLOW_IN+;
B_L_TRIMMED_02_FLOW_IN: B_NON_CONTENT L_EMPTY_02_FLOW_IN+;
B_L_TRIMMED_03_FLOW_IN: B_NON_CONTENT L_EMPTY_03_FLOW_IN+;
B_L_TRIMMED_04_FLOW_IN: B_NON_CONTENT L_EMPTY_04_FLOW_IN+;
B_L_TRIMMED_05_FLOW_IN: B_NON_CONTENT L_EMPTY_05_FLOW_IN+;

B_L_TRIMMED_01_FLOW_OUT: B_NON_CONTENT L_EMPTY_01_FLOW_OUT+;
B_L_TRIMMED_02_FLOW_OUT: B_NON_CONTENT L_EMPTY_02_FLOW_OUT+;
B_L_TRIMMED_03_FLOW_OUT: B_NON_CONTENT L_EMPTY_03_FLOW_OUT+;
B_L_TRIMMED_04_FLOW_OUT: B_NON_CONTENT L_EMPTY_04_FLOW_OUT+;
B_L_TRIMMED_05_FLOW_OUT: B_NON_CONTENT L_EMPTY_05_FLOW_OUT+;

// [72]	b-as-space	::=	b-break
B_AS_SPACE: B_BREAK;

// [73]	b-l-folded(n,c)	::=	b-l-trimmed(n,c) | b-as-space
B_L_FOLDED_01_BLOCK_IN: B_L_TRIMMED_01_BLOCK_IN | B_AS_SPACE;
B_L_FOLDED_02_BLOCK_IN: B_L_TRIMMED_02_BLOCK_IN | B_AS_SPACE;
B_L_FOLDED_03_BLOCK_IN: B_L_TRIMMED_03_BLOCK_IN | B_AS_SPACE;
B_L_FOLDED_04_BLOCK_IN: B_L_TRIMMED_04_BLOCK_IN | B_AS_SPACE;
B_L_FOLDED_05_BLOCK_IN: B_L_TRIMMED_05_BLOCK_IN | B_AS_SPACE;

B_L_FOLDED_01_BLOCK_OUT: B_L_TRIMMED_01_BLOCK_OUT | B_AS_SPACE;
B_L_FOLDED_02_BLOCK_OUT: B_L_TRIMMED_02_BLOCK_OUT | B_AS_SPACE;
B_L_FOLDED_03_BLOCK_OUT: B_L_TRIMMED_03_BLOCK_OUT | B_AS_SPACE;
B_L_FOLDED_04_BLOCK_OUT: B_L_TRIMMED_04_BLOCK_OUT | B_AS_SPACE;
B_L_FOLDED_05_BLOCK_OUT: B_L_TRIMMED_05_BLOCK_OUT | B_AS_SPACE;

B_L_FOLDED_01_FLOW_IN: B_L_TRIMMED_01_FLOW_IN | B_AS_SPACE;
B_L_FOLDED_02_FLOW_IN: B_L_TRIMMED_02_FLOW_IN | B_AS_SPACE;
B_L_FOLDED_03_FLOW_IN: B_L_TRIMMED_03_FLOW_IN | B_AS_SPACE;
B_L_FOLDED_04_FLOW_IN: B_L_TRIMMED_04_FLOW_IN | B_AS_SPACE;
B_L_FOLDED_05_FLOW_IN: B_L_TRIMMED_05_FLOW_IN | B_AS_SPACE;

B_L_FOLDED_01_FLOW_OUT: B_L_TRIMMED_01_FLOW_OUT | B_AS_SPACE;
B_L_FOLDED_02_FLOW_OUT: B_L_TRIMMED_02_FLOW_OUT | B_AS_SPACE;
B_L_FOLDED_03_FLOW_OUT: B_L_TRIMMED_03_FLOW_OUT | B_AS_SPACE;
B_L_FOLDED_04_FLOW_OUT: B_L_TRIMMED_04_FLOW_OUT | B_AS_SPACE;
B_L_FOLDED_05_FLOW_OUT: B_L_TRIMMED_05_FLOW_OUT | B_AS_SPACE;

// [74]	s-flow-folded(n)	::=	s-separate-in-line? b-l-folded(n,flow-in) s-flow-line-prefix(n)
S_FLOW_FOLDED_01: S_SEPARATE_IN_LINE? B_L_FOLDED_01_FLOW_IN S_FLOW_LINE_PREFIX_01;
S_FLOW_FOLDED_02: S_SEPARATE_IN_LINE? B_L_FOLDED_02_FLOW_IN S_FLOW_LINE_PREFIX_02;
S_FLOW_FOLDED_03: S_SEPARATE_IN_LINE? B_L_FOLDED_03_FLOW_IN S_FLOW_LINE_PREFIX_03;
S_FLOW_FOLDED_04: S_SEPARATE_IN_LINE? B_L_FOLDED_04_FLOW_IN S_FLOW_LINE_PREFIX_04;
S_FLOW_FOLDED_05: S_SEPARATE_IN_LINE? B_L_FOLDED_05_FLOW_IN S_FLOW_LINE_PREFIX_05;

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
S_SEPARATE_01_BLOCK_OUT: S_SEPARATE_LINES_01;
S_SEPARATE_02_BLOCK_OUT: S_SEPARATE_LINES_02;
S_SEPARATE_03_BLOCK_OUT: S_SEPARATE_LINES_03;
S_SEPARATE_04_BLOCK_OUT: S_SEPARATE_LINES_04;
S_SEPARATE_05_BLOCK_OUT: S_SEPARATE_LINES_05;

S_SEPARATE_01_BLOCK_IN: S_SEPARATE_LINES_01;
S_SEPARATE_02_BLOCK_IN: S_SEPARATE_LINES_02;
S_SEPARATE_03_BLOCK_IN: S_SEPARATE_LINES_03;
S_SEPARATE_04_BLOCK_IN: S_SEPARATE_LINES_04;
S_SEPARATE_05_BLOCK_IN: S_SEPARATE_LINES_05;

S_SEPARATE_01_FLOW_OUT: S_SEPARATE_LINES_01;
S_SEPARATE_02_FLOW_OUT: S_SEPARATE_LINES_02;
S_SEPARATE_03_FLOW_OUT: S_SEPARATE_LINES_03;
S_SEPARATE_04_FLOW_OUT: S_SEPARATE_LINES_04;
S_SEPARATE_05_FLOW_OUT: S_SEPARATE_LINES_05;

S_SEPARATE_01_FLOW_IN: S_SEPARATE_LINES_01;
S_SEPARATE_02_FLOW_IN: S_SEPARATE_LINES_02;
S_SEPARATE_03_FLOW_IN: S_SEPARATE_LINES_03;
S_SEPARATE_04_FLOW_IN: S_SEPARATE_LINES_04;
S_SEPARATE_05_FLOW_IN: S_SEPARATE_LINES_05;

S_SEPARATE_BLOCK_KEY: S_SEPARATE_IN_LINE;
S_SEPARATE_FLOW_KEY: S_SEPARATE_IN_LINE;

// [81]	s-separate-lines(n)	::=	( s-l-comments s-flow-line-prefix(n) )
//                          | s-separate-in-line
S_SEPARATE_LINES_01: (S_L_COMMENTS S_FLOW_LINE_PREFIX_01) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_02: (S_L_COMMENTS S_FLOW_LINE_PREFIX_02) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_03: (S_L_COMMENTS S_FLOW_LINE_PREFIX_03) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_04: (S_L_COMMENTS S_FLOW_LINE_PREFIX_04) | S_SEPARATE_IN_LINE;
S_SEPARATE_LINES_05: (S_L_COMMENTS S_FLOW_LINE_PREFIX_05) | S_SEPARATE_IN_LINE;

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


// [110]	nb-double-text(n,c)	::=	c = flow-out  ⇒ nb-double-multi-line(n)
//                              c = flow-in   ⇒ nb-double-multi-line(n)
//                              c = block-key ⇒ nb-double-one-line
//                              c = flow-key  ⇒ nb-double-one-line
fragment NB_DOUBLE_TEXT_01_FLOW_OUT: NB_DOUBLE_MULTI_LINE_01;
fragment NB_DOUBLE_TEXT_02_FLOW_OUT: NB_DOUBLE_MULTI_LINE_02;
fragment NB_DOUBLE_TEXT_03_FLOW_OUT: NB_DOUBLE_MULTI_LINE_03;
fragment NB_DOUBLE_TEXT_04_FLOW_OUT: NB_DOUBLE_MULTI_LINE_04;
fragment NB_DOUBLE_TEXT_05_FLOW_OUT: NB_DOUBLE_MULTI_LINE_05;

fragment NB_DOUBLE_TEXT_01_FLOW_IN: NB_DOUBLE_MULTI_LINE_01;
fragment NB_DOUBLE_TEXT_02_FLOW_IN: NB_DOUBLE_MULTI_LINE_02;
fragment NB_DOUBLE_TEXT_03_FLOW_IN: NB_DOUBLE_MULTI_LINE_03;
fragment NB_DOUBLE_TEXT_04_FLOW_IN: NB_DOUBLE_MULTI_LINE_04;
fragment NB_DOUBLE_TEXT_05_FLOW_IN: NB_DOUBLE_MULTI_LINE_05;

fragment NB_DOUBLE_TEXT_01_BLOCK_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_02_BLOCK_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_03_BLOCK_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_04_BLOCK_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_05_BLOCK_KEY: NB_DOUBLE_ONE_LINE;

fragment NB_DOUBLE_TEXT_01_FLOW_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_02_FLOW_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_03_FLOW_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_04_FLOW_KEY: NB_DOUBLE_ONE_LINE;
fragment NB_DOUBLE_TEXT_05_FLOW_KEY: NB_DOUBLE_ONE_LINE;

// [111]	nb-double-one-line	::=	nb-double-char*
fragment NB_DOUBLE_ONE_LINE: NB_DOUBLE_CHAR*;

// [112]	s-double-escaped(n)	::=	s-white* “\” b-non-content
//                              l-empty(n,flow-in)* s-flow-line-prefix(n)
S_DOUBLE_ESCAPED_01: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_01_FLOW_IN* S_FLOW_LINE_PREFIX_01;
S_DOUBLE_ESCAPED_02: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_02_FLOW_IN* S_FLOW_LINE_PREFIX_02;
S_DOUBLE_ESCAPED_03: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_03_FLOW_IN* S_FLOW_LINE_PREFIX_03;
S_DOUBLE_ESCAPED_04: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_04_FLOW_IN* S_FLOW_LINE_PREFIX_04;
S_DOUBLE_ESCAPED_05: S_WHITE* '\\' B_NON_CONTENT L_EMPTY_05_FLOW_IN* S_FLOW_LINE_PREFIX_05;

// [113]	s-double-break(n)	::=	s-double-escaped(n) | s-flow-folded(n)
S_DOUBLE_BREAK_01: S_DOUBLE_ESCAPED_01 | S_FLOW_FOLDED_01;
S_DOUBLE_BREAK_02: S_DOUBLE_ESCAPED_02 | S_FLOW_FOLDED_02;
S_DOUBLE_BREAK_03: S_DOUBLE_ESCAPED_03 | S_FLOW_FOLDED_03;
S_DOUBLE_BREAK_04: S_DOUBLE_ESCAPED_04 | S_FLOW_FOLDED_04;
S_DOUBLE_BREAK_05: S_DOUBLE_ESCAPED_05 | S_FLOW_FOLDED_05;

// [114]	nb-ns-double-in-line	::=	( s-white* ns-double-char )*
fragment NB_NS_DOUBLE_IN_LINE: (S_WHITE NS_DOUBLE_CHAR)*;

// [115]	s-double-next-line(n)	::=	s-double-break(n)
//                                  ( ns-double-char nb-ns-double-in-line
//                                  ( s-double-next-line(n) | s-white* ) )?
S_DOUBLE_NEXT_LINE_01: S_DOUBLE_BREAK_01
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_01 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_02: S_DOUBLE_BREAK_02
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_02 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_03: S_DOUBLE_BREAK_03
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_03 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_04: S_DOUBLE_BREAK_04
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_04 | S_WHITE*))?;
S_DOUBLE_NEXT_LINE_05: S_DOUBLE_BREAK_05
                       (NS_DOUBLE_CHAR NB_NS_DOUBLE_IN_LINE
                          (S_DOUBLE_NEXT_LINE_05 | S_WHITE*))?;

// [116]	nb-double-multi-line(n)	::=	nb-ns-double-in-line
//                                  (s-double-next-line(n) | s-white* )
fragment NB_DOUBLE_MULTI_LINE_01: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_01 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_02: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_02 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_03: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_03 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_04: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_04 | S_WHITE*);
fragment NB_DOUBLE_MULTI_LINE_05: NB_NS_DOUBLE_IN_LINE (S_DOUBLE_NEXT_LINE_05 | S_WHITE*);

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

// [121]	nb-single-text(n,c)	::=	c = flow-out  ⇒ nb-single-multi-line(n)
//                              c = flow-in   ⇒ nb-single-multi-line(n)
//                              c = block-key ⇒ nb-single-one-line
//                              c = flow-key  ⇒ nb-single-one-line
fragment NB_SINGLE_TEXT01_FLOW_OUT: NB_SINGLE_MULTI_LINE_01;
fragment NB_SINGLE_TEXT02_FLOW_OUT: NB_SINGLE_MULTI_LINE_02;
fragment NB_SINGLE_TEXT03_FLOW_OUT: NB_SINGLE_MULTI_LINE_03;
fragment NB_SINGLE_TEXT04_FLOW_OUT: NB_SINGLE_MULTI_LINE_04;
fragment NB_SINGLE_TEXT05_FLOW_OUT: NB_SINGLE_MULTI_LINE_05;

fragment NB_SINGLE_TEXT01_FLOW_IN: NB_SINGLE_MULTI_LINE_01;
fragment NB_SINGLE_TEXT02_FLOW_IN: NB_SINGLE_MULTI_LINE_02;
fragment NB_SINGLE_TEXT03_FLOW_IN: NB_SINGLE_MULTI_LINE_03;
fragment NB_SINGLE_TEXT04_FLOW_IN: NB_SINGLE_MULTI_LINE_04;
fragment NB_SINGLE_TEXT05_FLOW_IN: NB_SINGLE_MULTI_LINE_05;

fragment NB_SINGLE_TEXT01_BLOCK_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT02_BLOCK_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT03_BLOCK_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT04_BLOCK_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT05_BLOCK_KEY: NB_SINGLE_ONE_LINE;

fragment NB_SINGLE_TEXT_01_FLOW_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_02_FLOW_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_03_FLOW_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_04_FLOW_KEY: NB_SINGLE_ONE_LINE;
fragment NB_SINGLE_TEXT_05_FLOW_KEY: NB_SINGLE_ONE_LINE;

// [122]	nb-single-one-line	::=	nb-single-char*
fragment NB_SINGLE_ONE_LINE: NB_SINGLE_CHAR*;

// [123]	nb-ns-single-in-line	::=	( s-white* ns-single-char )*
fragment NB_NS_SINGLE_IN_LINE: (S_WHITE* NS_SINGLE_CHAR)*;

// [124]	s-single-next-line(n)	::=	s-flow-folded(n)
//                                  ( ns-single-char nb-ns-single-in-line
//                                    ( s-single-next-line(n) | s-white* ) )?
S_SINGLE_NEXT_LINE_01: S_FLOW_FOLDED_01
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_01 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_02: S_FLOW_FOLDED_02
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_02 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_03: S_FLOW_FOLDED_03
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_03 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_04: S_FLOW_FOLDED_04
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_04 | S_WHITE*))?;
S_SINGLE_NEXT_LINE_05: S_FLOW_FOLDED_05
                       ( NS_SINGLE_CHAR NB_NS_DOUBLE_IN_LINE
                         ( S_SINGLE_NEXT_LINE_05 | S_WHITE*))?;

// [125]	nb-single-multi-line(n)	::=	nb-ns-single-in-line
//                                  ( s-single-next-line(n) | s-white* )
fragment NB_SINGLE_MULTI_LINE_01: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_01 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_02: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_02 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_03: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_03 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_04: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_04 | S_WHITE)*;
fragment NB_SINGLE_MULTI_LINE_05: NB_NS_SINGLE_IN_LINE (S_SINGLE_NEXT_LINE_05 | S_WHITE)*;

//--- Plain Style

