Definitions.

Whitespace = [\s\t]
Break = \r\n
Atom = [A-Z\.]+
XProp = X-[A-Z\-]+
Path = [0-9]+(\.[0-9]+)+
Digit = [0-9]+
String = "([^"\\]*(\\.[^"\\]*)*)"
LParen = \(
RParen = \)
LSquare = \[
RSquare = \]
Equal = \=
Asterisk = \*
Plus = \+
Dot = \.
Nil = NIL
Flag = \\[A-Z][a-z]+
Identifier = [a-zA-Z0-9]+
OctetCount = \{{Digit}\}

Rules.

{Whitespace}  : skip_token.
{Atom}        : {token,     {atom,         TokenLine, TokenChars}}.
{Digit}       : {token,     {number,       TokenLine, list_to_integer(TokenChars)}}.
{String}      : {token,     {string,       TokenLine, trim_string(TokenChars, "\"")}}.
{OctetCount}  : {token,     {octet_count,  TokenLine, list_to_integer(trim_string(TokenChars, "{", "}"))}}.
{LParen}      : {token,     {lparen,       TokenLine, '('}}.
{RParen}      : {token,     {rparen,       TokenLine, ')'}}.
{LSquare}     : {token,     {lsquare,      TokenLine, '['}}.
{RSquare}     : {token,     {rsquare,      TokenLine, ']'}}.
{Asterisk}    : {token,     {asterisk,     TokenLine, '*'}}.
{XProp}       : {token,     {xprop,        TokenLine, TokenChars}}.
{Equal}       : {token,     {equal,        TokenLine, '='}}.
{Path}        : {token,     {path,         TokenLine, parse_path(TokenChars)}}.
{Break}       : {end_token, {break,        TokenLine, break}}.
{Plus}        : {token,     {plus,         TokenLine, '+'}}.
{Nil}         : {token,     {nil_value,    TokenLine, nil_value}}.
{Dot}         : {token,     {dot,          TokenLine, '.'}}.
{Identifier}  : {token,     {identifier,   TokenLine, TokenChars}}.


Erlang code.

trim_string(Chars, Left) -> 
  trim_string(Chars, Left, Left).

trim_string(Chars, Left, Right) -> 
  string:trim(string:trim(Chars, leading, Left), trailing, Right).

parse_path(Chars) ->
  Splitted = string:split(Chars, ".", all),
  lists:map(fun(String) -> 
    {Int, _} = string:to_integer(String),
    Int
  end, Splitted).
