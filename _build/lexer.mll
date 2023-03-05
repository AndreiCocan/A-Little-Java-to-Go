{
  open Lexing
  open Parser

  exception Error of string

  let newline lexbuf =
    let pos = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <-
      { pos with pos_lnum = pos.pos_lnum + 1; pos_bol = pos.pos_cnum }
}

let digit = ['0'-'9']
let integer = digit+
let space = [' ' '\t']
let letter = ['a'-'z''A'-'Z''_']
let ident = letter (digit | letter)*

rule get_token = parse
  | '\n'      { newline lexbuf; get_token lexbuf }
  | space+    { get_token lexbuf }
  | "/*"      { parse_comment lexbuf }
  | "public"  { PUBLIC }
  | "static"  { STATIC }
  | "main"    { MAIN }
  | "return"  { RETURN }
  | "class"   { CLASS }
  | "extends" { EXTENDS }
  | "this"    { THIS }
  | "new"     { NEW }
  | "void"    { VOID }
  | "String"  { STRING }
  | "&&"      { AND }
  | "<"       { LT }
  | "+"       { PLUS }  
  | "-"       { MINUS }
  | "*"       { MULTIPLY }
  | '['       { LBRACKET }
  | ']'       { RBRACKET }
  | '('       { LPAREN }
  | ')'       { RPAREN }
  | '{'       { LBRACE }
  | '}'       { RBRACE }
  | '.'       { DOT }
  | ';'       { SEMICOLON }
  | '='       { ASSIGN }
  | ","       { COMMA }
  | "boolean" { BOOLEAN }
  | "true"    { BOOL_CONST true }
  | "false"   { BOOL_CONST false }
  | "!"       { NOT }
  | "int"     { INTEGER }
  | "System.out.println" { SYSOU }
  | "if"      { IF }
  | "else"    { ELSE }
  | "while"   { WHILE }
  | integer as i
      {
        try
          INT_CONST (Int32.of_string i)
        with Failure _ ->
          raise (Error "Invalid integer constant")
      }
  | ident as id { IDENT (Location.make (lexeme_start_p lexbuf) (lexeme_end_p lexbuf) id) }
  | eof     { EOF }
  | _ as c  { raise (Error ("Illegal character: " ^ String.make 1 c)) }

and parse_comment = parse
  | '\n' { newline lexbuf; parse_comment lexbuf}
  | "*/" {get_token lexbuf}
  | eof  { raise Error "Unexpected end of the file before the end of a comment"}
  | _    { comment lexbuf }
