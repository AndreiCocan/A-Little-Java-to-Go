type identifier = string

type expression =
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

and constant = LMJ.constant =
| ConstBool of bool
| ConstInt of int32

and binop = LMJ.binop =
| OpAdd
| OpSub
| OpMul
| OpLt
| OpAnd

and unop = LMJ.unop = UOpNot

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

  arguments: (string * java_type) list;

  return_type: java_type;

  method_declarations: java_type StringMap.t;

  method_statements: statement;

  return_expression: expression

}

and java_class = {

  extends: string option;

  attributes: java_type StringMap.t;

  methods: java_method StringMap.t;

}

and program = {

  name: string;

  defs: java_class StringMap.t;

  main_args: string;

  main: statement

}
