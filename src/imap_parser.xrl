Definitions.

Whitespace = [\s\t]
Terminator = \r\n

Atom = [A-Z]+
Digit = [0-9]+
Identifier = [a-zA-Z0-9]+
String = "([^"\\]*(\\.[^"\\]*)*)"
Nil = NIL
OpenParen = \(
CloseParen = \)
OpenSquare = \[
CloseSquare = \]
Asterisk = \*
Plus = \+
Equal = \=

Rules.

{Whitespace}     : skip_token.
{Terminator}     : {token, {break,         TokenLine, break}}.
{Atom}           : {token, {atom,          TokenLine, TokenChars}}.
{Indentifier}    : {token, {identifier,    TokenLine, TokenChars}}.
{Digit}          : {token, {digit,         TokenLine, TokenChars}}.
{Nil}            : {token, {null,          TokenLine, nil}}.
{String}         : {token, {string,        TokenLine, string:trim(TokenChars, both, "\"")}}.
{OpenParen}      : {token, {open_paren,    TokenLine, list_to_atom(TokenChars)}}.
{CloseParen}     : {token, {close_paren,   TokenLine, list_to_atom(TokenChars)}}.
{OpenSquare}     : {token, {open_square,   TokenLine, list_to_atom(TokenChars)}}.
{CloseSquare}    : {token, {close_square,  TokenLine, list_to_atom(TokenChars)}}.
{Asterisk}       : {token, {asterisk,      TokenLine, list_to_atom(TokenChars)}}.
{Plus}           : {token, {plus,          TokenLine, list_to_atom(TokenChars)}}.
{Equal}          : {token, {equal,         TokenLine, list_to_atom(TokenChars)}}.

Erlang code.

