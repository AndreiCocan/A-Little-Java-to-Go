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
| SBlock of instruction list
| SIf of expression * instruction * instruction
| SWhile of expression * instruction
| SSysou of expression
| SSetVar of identifier * expression
| SArraySet of identifier * expression * expression

and java_type =
| TypeInt
| TypeBool
| TypeIntArray
| Type of identifier

and java_method = {

  formals: (identifier * typ) list;

  result: typ;

  locals: (identifier * typ) list;

  body: instruction;

  return: expression

}

and java_class = {

  extends: identifier option;

  attributes: (identifier * typ) list;

  methods: (identifier * metho) list

}

and program = {

  name: identifier;

  defs: (identifier * clas) list;

  main_args: identifier;

  main: instruction

}
