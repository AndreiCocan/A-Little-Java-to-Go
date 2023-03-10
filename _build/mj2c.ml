open MJ
open Print
open ClassInfoModule
let expression2v (method_name : string) (class_info : ClassInfo.t) out (expr : MJ.expression) : unit =
  let rec expression2v out ex =
    match ex with
    | EConst const -> fprintf out "%a" constant2v const
    | EGetVar var -> variable2v method_name class_info out var
    | EUnOp (UOpNot, expr) -> fprintf out "!(%a)" expression2v expr
    | EBinOp (binop,ex1,ex2) -> fprintf out "%a %a %a" (expression2v ex1) (e1 binop2c op) (expression2 ex2)
    | EMethodCall (java_object,method_name,args) -> fprintf out "%a.%s(%a)" (expression2v java_object) method_name ((seplist comma expression2v) args)
    | EArrayGet (array,index) -> fprintf out "%a[%a]" (expression2v array) (expression2v index)
    | EArrayAlloc size -> fprintf out "[]int{len: %a, init: 0}" expression2v size
    | EArrayLength array -> fprintf out "%a.len" (expression2v array)
    | EThis -> fprintf out "this"
    | EObjectAlloc class_name -> fprintf out "%s{}" class_name
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

let statement2v (method_name : string) (class_info : ClassInfo.t) out (stat : MJ.statement) : unit =
  let rec statement2v out stat = 
    match stat with
    | SBlock statements -> fprint out "{%a%t}" (indent indentation (seplist nl statement2v)) statements nl
      
    | SIf(ex,stmnt1,stmnt2) -> fprint out "if %a %a%telse %a" 
      (expression2v method_name class_info) ex
      statement2v stmnt1
      nl
      statement2v stmnt2
    | SWhile (ex, stmnt) -> fprintf out "for %a {%a%t}" (expression2v method_name class_info) ex statement2v stmnt nl
    | SSysou ex -> fprintf out "println(%a)" (expr2c method_name class_info) e
    | SSetVar (var,ex) -> fprintf out "%a = %a" (variable2v method_name class_info) var (expression2v method_name class_info) ex
    | SArraySet (array, index, ex) -> fprintf out "%a[%a] = %a"
      (variable2v method_name class_info) array
      (expression2v method_name class_info) index
      (expression2v method_name class_info) ex
  in
  statement2v out stat
  
let java_type2v out (java_type : MJ.java_type) : unit =
  match java_type with
  | TypeInt -> fprintf out "int"
  | TypeBool -> fprintf out "bool"
  | TypeIntArray -> fprintf out "[]int"
  | Type t -> fprintf out "%s" t


let variable2v (method_name : string) (class_info : ClassInfo.t) out (var : string) : unit =
  if ClassInfo.is_attribute method_name var class_info 
  then 
    let class_origin = ClassInfo.attribute_class_origin var class_info
    in 
    fprintf out "%s.%s" (String.get class_origin 0 |> Char.lowercase_ascii) var
  else 
    fprintf out "%s" var

let decl2v out ((var_name, t) : string * MJ.java_type) : unit =
  fprintf out "%s %a" var_name java_type2v t

let decl_mut2v out ((var_name, t) : string * MJ.java_type) : unit =
  fprintf out "mut %s %a" var_name java_type2v t 
 
let method_definition2v out ((class_name, java_class) : string * MJ.java_class) : unit =
  let class_info = get_class_info class_name in 
  let method_definition2v out (method_name, m) =
    let return2v out expr = 
      fprintf out "return %a" (expression2v method_name class_info) expr
    in 
    fprintf out "fn (%s %s) %s(%a) %s {\n%a%a%a\n}"
      (String.get class_name 0 |> Char.lowercase_ascii)
      class_name
      method_name
      (seplist comma decl2v) m.arguments
      m.return_type
      (termlist semicolon (indent indentation decl_mut2v)) m.method_declarations
      (list (indent indentation (statement2v method_name class_info))) m.method_statements
      (indent indentation return2v) m.return
  in 
  fprintf out "%a" (seplist nl method_definition2v) java_class.methods

let class_definition2v out ((class_name, java_class) : string * MJ.java_class) : unit =
  let attributes_names =
    get_class_info class_name
    |> ClassInfo.get_attributes
  in
  fprintf out "struct %s {%t%a}"
    class_name
    (indent_t indentation (fun out -> fprintf out "mut:"))
    (termlist nl (indent indentation decl2v)) attributes_names

let program2v (p : MJ.program) : unit = 
  init_class_infos p;
  fprintf out 
  "%a\
   %a\
   fn main(){\
   %a\
   }\n"
  (*Classes*)
  (termlist nl class_definition2v) p.defs   
  (*Methods*)
  (termlist nl method_definition2v) (List.filter (fun (_, c) -> c.methods <> []) p.defs)
  (*Main*)
  (indent indentation (instr2c "main" (get_class_info p.name))) p.main

