Terminals atom number string lparen rparen lsquare rsquare asterisk
xprop equal plus identifier break dot.

Nonterminals line content tag.

Rootsymbol line.

line -> tag content : {tagged, '$2'}.
line -> asterisk content : {untagged, '$2'}.
line -> plus content : {continuation, '$2'}.

content -> atom tag : {unwrap('$1'), '$2'}.

tag -> identifier : unwrap('$1').

Erlang code.
unwrap({_, _, Value}) -> Value.
