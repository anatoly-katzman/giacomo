lexer grammar MyYaml;

//--- Dummy piece, just copied from a sample
/*
ID : [a-zA-Z]+ ; // match identifiers
INT : [0-9]+ ; // match integers
NEWLINE:'\r'? '\n' ; // return newlines to parser (is end-statement signal)
WS : [ \t]+ -> skip ; // toss out whitespace
*/
//--- Dummy piece, just copied from a sample


//[1]	c-printable	::=	  #x9 | #xA | #xD | [#x20-#x7E]        /* 8 bit */
//                    | #x85 | [#xA0-#xD7FF] | [#xE000-#xFFFD] /* 16 bit */
//                    | [#x10000-#x10FFFF]                     /* 32 bit */
C_PRINTABLE: '\u0009' | '\u000A' | '\u000D' | [\u0020-\u007e]
            | '\u0085' | [\u00a0-\ud7ff] | [\ue000-\ufffd]
            | [\u{10000}-\u{10ffff}];

// [2]	nb-json	::=	#x9 | [#x20-#x10FFFF]
NB_JSON: '\u0009' | [\u0020-\u{10ffff}];

// [3]	c-byte-order-mark	::=	#xFEFF
C_BYTE_ORDER_MARK: '\ufeff';

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

//--- Line Break Characters
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

//--- White Space Characters
// [31]	s-space	::=	#x20 /* SP */
S_SPACE: '\u0020';

// [32]	s-tab	::=	#x9  /* TAB */
S_TAB: '\u0009';

// [33]	s-white	::=	s-space | s-tab
S_WHITE: S_SPACE | S_TAB;

// [34]	ns-char	::=	nb-char - s-white
NS_CHAR: ~[\u0020\u0009];

//--- Miscellaneous Characters

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


//--- Escaped Characters
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


//--- Indentation Spaces
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

//--- Separation Spaces
S_SEPARATE_IN_LINE:	S_WHITE+; // | <Start of line> TODO how to express <Start of line>?!


//--- Line Prefixes
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

//--- Empty Lines
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

//-- Line Folding

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

//--- Comments
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
