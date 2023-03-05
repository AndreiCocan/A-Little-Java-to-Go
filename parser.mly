%{
  open LMJ
%}

%token <int32> INT_CONST
%token <bool> BOOL_CONST
%token INTEGER BOOLEAN
%token <string Location.t> IDENT
%token CLASS PUBLIC STATIC VOID MAIN STRING EXTENDS RETURN
%token PLUS MINUS MULTIPLY NOT LT AND
%token COMMA SEMICOLON
%token ASSIGN
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE
%token THIS NEW DOT LENGTH
%token SYSOU
%token IF ELSE WHILE
%token EOF


%start program

%type <LMJ.program> program

%%

program:
| m = main_class d = defs EOF
   {
     let c, a, i = m in
     {
       name = c;
       defs = d;
       main_args = a;
       main = i
     }
   }

main_class:
| CLASS c = IDENT
   LBRACE
   PUBLIC STATIC VOID MAIN LPAREN STRING LBRACKET RBRACKET a = IDENT RPAREN
   LBRACE
   i = statement
   RBRACE
   RBRACE
   { (c, a, i) }

java_class:
|  CLASS 
   class_name = IDENT 
   class_extends = option(preceded(EXTENDS,IDENT)) 
   LBRACE
   attribute_list= list(pair(java_type,terminated(IDENT,SEMICOLON))) //CHANGE THAT
   method_list= list(java_method)
   RBRACE
   { class_name,
      {
         extends=class_extends;
         attributes = attribute_list;
         methods= method_list;
      } 
   }

defs:
| c = list(java_class) { c }

java_method:
| PUBLIC
   method_type = java_type 
   method_name = IDENT
   LPAREN
   method_args = separated_list(COMMA, pair(java_type, IDENT))
   RPAREN
   LBRACE
   var_decls_and_statemnts = var_declarations_and_statements
   RETURN return_expr = expression SEMICOLON
   RBRACE
   {
      let declarations = fst var_declarations_and_statements and statements = snd var_declarations_and_statements in 
      method_name,
      {
         arguments = method_args;
         return_type = method_type;
         method_declarations = declarations;
         method_statements = statements;
         return_expression = return_expr;
      }
   }

var_declarations_and_statements:
| var_type = java_type 
   var_name = IDENT SEMICOLON 
   rest_dec_and_stat = var_declarations_and_statements
   {
      let declarations,statements = rest_dec_and_stat in
      ((var_name, var_type) :: declarations,statements)
   }
| statements = list(statement)
   { 
      ([],statements) 
   }

statement:
| stmnt_blck = statement_block 
   { stmnt_blck }

| IF LPAREN if_expr = expression RPAREN if_stmnt = statement ELSE else_stmnt = statement
   { SIf (if_expr,if_stmnt,else_stmnt) }

| WHILE LPAREN while_expr = expression RPAREN while_stmnt = statement
   { SWhile (while_expr,while_stmnt) }

| SYSOU LPAREN print_expr = expression RPAREN SEMICOLON
   { SSysou print_expr}

| var_name = IDENT ASSIGN expr = expression SEMICOLON
   { SSetVar (var_name,expr) }

| var_array_name = IDENT LBRACKET array_expr = expression RBRACKET ASSIGN expr = expression SEMICOLON
   { SArraySet (var_array_name, array_expr, expr) }

expression:
|  e = raw_expression
   { Location.make $startpos $endpos e }

| LPAREN e = expression RPAREN
   { e }

raw_expression:
| i = INT_CONST
   { EConst (ConstInt i) }

java_type:
| INTEGER                   { TypeInt }
| INTEGER LBRACKET RBRACKET {TypeIntArray}
| BOOLEAN                   { TypeBool }
| 


