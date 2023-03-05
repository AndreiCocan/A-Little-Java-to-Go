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

  formals: (string * typ) list;

  result: typ;

  locals: typ StringMap.t;

  body: instruction;

  return: expression

}

and java_class = {

  extends: string option;

  attributes: typ StringMap.t;

  methods: metho StringMap.t;

}

and program = {

  name: string;

  defs: clas StringMap.t;

  main_args: string;

  main: instruction

}
