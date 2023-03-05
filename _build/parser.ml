
type token = 
  | WHILE
  | VOID
  | TIMES
  | THIS
  | SYSO
  | STRING
  | STATIC
  | SEMICOLON
  | RPAREN
  | RETURN
  | RBRACKET
  | RBRACE
  | PUBLIC
  | PLUS
  | NOT
  | NEW
  | MINUS
  | MAIN
  | LT
  | LPAREN
  | LENGTH
  | LBRACKET
  | LBRACE
  | INT_CONST of (
# 5 "parser.mly"
       (int32)
# 30 "parser.ml"
)
  | INTEGER
  | IF
  | IDENT of (
# 8 "parser.mly"
       (string Location.t)
# 37 "parser.ml"
)
  | EXTENDS
  | EOF
  | ELSE
  | DOT
  | COMMA
  | CLASS
  | BOOL_CONST of (
# 6 "parser.mly"
       (bool)
# 48 "parser.ml"
)
  | BOOLEAN
  | ASSIGN
  | AND

# 1 "parser.mly"
  
  open LMJ

# 58 "parser.ml"

let menhir_begin_marker =
  0

and (xv_program, xv_main_class, xv_instruction, xv_defs) =
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 27 "parser.mly"
                         _3
# 67 "parser.ml"
   : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 27 "parser.mly"
                 d
# 71 "parser.ml"
   : 'tv_defs) (_startpos_d_ : Lexing.position) (_endpos_d_ : Lexing.position) (_startofs_d_ : int) (_endofs_d_ : int) (_loc_d_ : Lexing.position * Lexing.position) (
# 27 "parser.mly"
  m
# 75 "parser.ml"
   : 'tv_main_class) (_startpos_m_ : Lexing.position) (_endpos_m_ : Lexing.position) (_startofs_m_ : int) (_endofs_m_ : int) (_loc_m_ : Lexing.position * Lexing.position) ->
    ((
# 28 "parser.mly"
   (
     let c, a, i = m in
     {
       name = c;
       defs = d;
       main_args = a;
       main = i
     }
   )
# 88 "parser.ml"
     : 'tv_program) : (
# 22 "parser.mly"
      (LMJ.program)
# 92 "parser.ml"
    )) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 44 "parser.mly"
         _17
# 98 "parser.ml"
   : unit) (_startpos__17_ : Lexing.position) (_endpos__17_ : Lexing.position) (_startofs__17_ : int) (_endofs__17_ : int) (_loc__17_ : Lexing.position * Lexing.position) (
# 43 "parser.mly"
                  _16
# 103 "parser.ml"
   : unit) (_startpos__16_ : Lexing.position) (_endpos__16_ : Lexing.position) (_startofs__16_ : int) (_endofs__16_ : int) (_loc__16_ : Lexing.position * Lexing.position) (
# 43 "parser.mly"
   i
# 107 "parser.ml"
   : 'tv_instruction) (_startpos_i_ : Lexing.position) (_endpos_i_ : Lexing.position) (_startofs_i_ : int) (_endofs_i_ : int) (_loc_i_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                                                           _14
# 112 "parser.ml"
   : unit) (_startpos__14_ : Lexing.position) (_endpos__14_ : Lexing.position) (_startofs__14_ : int) (_endofs__14_ : int) (_loc__14_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                                                    _13
# 116 "parser.ml"
   : unit) (_startpos__13_ : Lexing.position) (_endpos__13_ : Lexing.position) (_startofs__13_ : int) (_endofs__13_ : int) (_loc__13_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                                           a
# 120 "parser.ml"
   : (
# 8 "parser.mly"
       (string Location.t)
# 124 "parser.ml"
  )) (_startpos_a_ : Lexing.position) (_endpos_a_ : Lexing.position) (_startofs_a_ : int) (_endofs_a_ : int) (_loc_a_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                                 _11
# 128 "parser.ml"
   : unit) (_startpos__11_ : Lexing.position) (_endpos__11_ : Lexing.position) (_startofs__11_ : int) (_endofs__11_ : int) (_loc__11_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                        _10
# 132 "parser.ml"
   : unit) (_startpos__10_ : Lexing.position) (_endpos__10_ : Lexing.position) (_startofs__10_ : int) (_endofs__10_ : int) (_loc__10_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                                 _9
# 136 "parser.ml"
   : unit) (_startpos__9_ : Lexing.position) (_endpos__9_ : Lexing.position) (_startofs__9_ : int) (_endofs__9_ : int) (_loc__9_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                          _8
# 140 "parser.ml"
   : unit) (_startpos__8_ : Lexing.position) (_endpos__8_ : Lexing.position) (_startofs__8_ : int) (_endofs__8_ : int) (_loc__8_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                     _7
# 144 "parser.ml"
   : unit) (_startpos__7_ : Lexing.position) (_endpos__7_ : Lexing.position) (_startofs__7_ : int) (_endofs__7_ : int) (_loc__7_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
                _6
# 148 "parser.ml"
   : unit) (_startpos__6_ : Lexing.position) (_endpos__6_ : Lexing.position) (_startofs__6_ : int) (_endofs__6_ : int) (_loc__6_ : Lexing.position * Lexing.position) (
# 41 "parser.mly"
         _5
# 152 "parser.ml"
   : unit) (_startpos__5_ : Lexing.position) (_endpos__5_ : Lexing.position) (_startofs__5_ : int) (_endofs__5_ : int) (_loc__5_ : Lexing.position * Lexing.position) (
# 40 "parser.mly"
         _4
# 157 "parser.ml"
   : unit) (_startpos__4_ : Lexing.position) (_endpos__4_ : Lexing.position) (_startofs__4_ : int) (_endofs__4_ : int) (_loc__4_ : Lexing.position * Lexing.position) (
# 39 "parser.mly"
                 _3
# 162 "parser.ml"
   : unit) (_startpos__3_ : Lexing.position) (_endpos__3_ : Lexing.position) (_startofs__3_ : int) (_endofs__3_ : int) (_loc__3_ : Lexing.position * Lexing.position) (
# 39 "parser.mly"
        c
# 166 "parser.ml"
   : (
# 8 "parser.mly"
       (string Location.t)
# 170 "parser.ml"
  )) (_startpos_c_ : Lexing.position) (_endpos_c_ : Lexing.position) (_startofs_c_ : int) (_endofs_c_ : int) (_loc_c_ : Lexing.position * Lexing.position) (
# 39 "parser.mly"
 _1
# 174 "parser.ml"
   : unit) (_startpos__1_ : Lexing.position) (_endpos__1_ : Lexing.position) (_startofs__1_ : int) (_endofs__1_ : int) (_loc__1_ : Lexing.position * Lexing.position) ->
    (
# 46 "parser.mly"
   ( (c, a, i) )
# 179 "parser.ml"
     : 'tv_main_class) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 64 "parser.mly"
  i
# 184 "parser.ml"
   : (
# 5 "parser.mly"
       (int32)
# 188 "parser.ml"
  )) (_startpos_i_ : Lexing.position) (_endpos_i_ : Lexing.position) (_startofs_i_ : int) (_endofs_i_ : int) (_loc_i_ : Lexing.position * Lexing.position) ->
    (
# 65 "parser.mly"
   ( EConst (ConstInt i) )
# 193 "parser.ml"
     : 'tv_instruction) in
  let _ = fun (_startpos : Lexing.position) (_endpos : Lexing.position) (_endpos__0_ : Lexing.position) (_symbolstartpos : Lexing.position) (_startofs : int) (_endofs : int) (_endofs__0_ : int) (_symbolstartofs : int) (_sloc : Lexing.position * Lexing.position) (_loc : Lexing.position * Lexing.position) (
# 49 "parser.mly"
  i
# 198 "parser.ml"
   : (
# 5 "parser.mly"
       (int32)
# 202 "parser.ml"
  )) (_startpos_i_ : Lexing.position) (_endpos_i_ : Lexing.position) (_startofs_i_ : int) (_endofs_i_ : int) (_loc_i_ : Lexing.position * Lexing.position) ->
    (
# 50 "parser.mly"
   ( EConst (ConstInt i) )
# 207 "parser.ml"
     : 'tv_defs) in
  ((let rec diverge() = diverge() in diverge()) : 'tv_program * 'tv_main_class * 'tv_instruction * 'tv_defs)

and menhir_end_marker =
  0
