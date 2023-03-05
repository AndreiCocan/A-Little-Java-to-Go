type identifier = string Location.t

type expression = raw_expression Location.t

and raw_expression =
| EConst of constant
| EGetVar of identifier
| EUnOp of unop * expression
| EBinOp of binop * expression * expression
| EMethodCall of expression * identifier * expression list
| EArrayGet of expression * expression
| EArrayAlloc of expression
| EArrayLength of expression
| EThis
| EObjectAlloc of identifier

and constant =
| ConstBool of bool
| ConstInt of int32

and binop =
| OpAdd
| OpSub
| OpMul
| OpLt
| OpAnd

and unop = UOpNot

and statement =
| SBlock of statement list
| SIf of expression * statement * statement
| SWhile of expression * statement
| SSysou of expression
| SSetVar of identifier * expression
| SArraySet of identifier * expression * expression

and java_type =
| TypeInt
| TypeBool
| TypeIntArray
| Type of identifier

and java_method = {

  arguments: (identifier * java_type) list;

  return_type: java_type;

  method_declarations: (identifier * java_type) list;

  method_statements: statement;

  return_expression: expression

}

and java_class = {

  extends: identifier option;

  attributes: (identifier * java_type) list;

  methods: (identifier * java_method) list

}

and program = {

  name: identifier;

  defs: (identifier * java_class) list;

  main_args: identifier;

  main: statement

}
