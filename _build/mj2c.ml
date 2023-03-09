open MJ
open Print
module CI = ClassInfo
let expression2v (method_name : string) (class_info : ClassInfo.t) out (expr : MJ.expression) : unit =
  let rec expression2v out ex =
    match ex with
    | EConst const -> fprintf out "%a" constant2v const
    | EGetVar var -> variable2v method_name class_info out var
    | EUnOp (UOpNot, expr) -> fprintf out "!(%a)" expression2v expr
    | EBinOp (binop,ex1,ex2) -> fprintf out "%a %a %a" (expression2v ex1) (e1 binop2c op) (expression2 ex2)
    | EMethodCall (java_object,method_name,args) -> fprintf out "%a.%s(%a)" (expression2v java_object) method_name ((seplist comma expression2v) args)
  in 
  expression2v out expr
let constant2v out (const : MJ.constant) : unit = 
  match const with
  | ConstBool true -> fprintf out "true"
  | ConstBool false -> fprintf out "false"
  | ConstInt i -> fprintf out "%ld" i

let binop2v out (binop : MJ.binop) : unit =
  match op with 
  | OpAdd -> fprintf out "+"
  | OpSub -> fprintf out "-"
  | OpMul -> fprintf out "*"
  | OpLt  -> fprintf out "<"
  | OpAnd -> fprintf out "&&"

let java_type2v out (java_type : MJ.java_type) : unit =
  match java_type with
  | TypeInt -> fprintf out "int"
  | TypeBool -> fprintf out "bool"
  | TypeIntArray -> fprintf out "[]int"
  | Type t -> fprintf out "%s" t


let variable2v (method_name : string) (class_info : CI.t) out (var : string) : unit =
  if CI.is_attribute method_name var class_info 
  then 
    let class_origin = ClassInfo.attribute_class_origin var class_info
    in 
    fprintf out "%s.%s" (String.get class_origin 0 |> Char.lowercase_ascii) var
  else 
    fprintf out "%s" var



(** [class_definition2v out (name, c)] defines the V structure representing the class [name] with type [v] on the output channel [out]. *)
let class_definition2v out ((class_name,java_class) : string * MJ.java_class):unit =
  let field_name =
      get_class_info class_name |> 

let program2v (p : MJ.program) : unit = ()
