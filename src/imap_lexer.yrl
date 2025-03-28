Terminals atom identifier null string open_paren close_paren open_square 
close_square asterisk plus equal break digit.

Nonterminals message word_sequence message_body literal tag word list.

Rootsymbol message.

message -> tag atom message_body break : {tagged, unwrap('$2'), '$3'}.
message -> asterisk message_body break : {untagged, '$2'}.
message -> plus word_sequence : {continuation, '$2'}.

word_sequence -> word word_sequence : {word, ['$1' | '$2']}.
word_sequence -> word break: {word, ['$1']}.

message_body -> list : '$1'.
message_body -> literal message_body : ['$1' | '$2'].
message_body -> literal : ['$1'].

list -> open_paren message_body close_paren: '$2'.
list -> open_square message_body close_square: '$2'.

word -> identifier : unwrap('$1').

tag -> identifier : unwrap('$1').
tag -> digit : unwrap('$1').

literal -> atom : unwrap('$1').
literal -> string : unwrap('$1').
literal -> null : unwrap('$1').
literal -> digit : unwrap('$1').
literal -> atom equal literal : {unwrap('$1'), '$3'}.

literal -> word_sequence : '$1'.

Erlang code.

unwrap({_, _, Value}) -> Value.
