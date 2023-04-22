open MJ
open Print
open Printf
let indentation = 2

let constant2go () = function
  | ConstBool true -> "true"
  | ConstBool false -> "false"
  | ConstInt i -> sprintf "%ld" i

let binop2go () = function
  | OpAdd -> sprintf "+"
  | OpSub -> sprintf "-"
  | OpMul -> sprintf "*"
  | OpLt  -> sprintf "<"
  | OpAnd -> sprintf "&&"

let obj_cast () t = 
  match t with
  | Type t -> sprintf ".(*%s)" t
  | _ -> sprintf ""

(*Check if the variable is in the class attributes to put this before*)
let var2go class_attribute method_declarations var_name =
  if StringMap.mem var_name method_declarations then
    sprintf "%s" var_name
  else if StringMap.mem var_name class_attribute then
    sprintf "this.%s" var_name
  else
    sprintf "%s" var_name

let var2go_method_call class_attribute method_declarations var_name =
  if StringMap.mem var_name method_declarations then
    sprintf "%s%a" var_name obj_cast (StringMap.find var_name method_declarations)

  else if StringMap.mem var_name class_attribute then
    sprintf "this.%s" var_name
  else
    sprintf "%s" var_name
let expression2go class_attribute method_declarations e = 
  let rec expr2go_method_call () e =
    match e with
    | EGetVar var-> sprintf "%s" 
      (var2go_method_call class_attribute method_declarations var)
    |_-> sprintf "%a" 
      expr2go e
  and expr2go () e =
    match e with
    | EConst const -> sprintf  "%a" 
      constant2go const

    | EGetVar var -> sprintf  "%s" 
      (var2go class_attribute method_declarations var)

    | EThis -> sprintf "this"

    | EMethodCall (java_object,method_name,args) -> (match java_object with
                                                    |EThis -> sprintf "%a.%s(%a)"
                                                    |_-> sprintf "%a.%s(%a)")
                                                    expr2go java_object
                                                    method_name 
                                                    (seplist comma expr2go_method_call) args


    | EArrayAlloc size -> sprintf "make([]int,%a)" 
      expr2go size

    | EObjectAlloc class_name -> sprintf "(&%s{})" 
      class_name
    
    | EArrayGet (array,index) -> sprintf "%a[%a]" 
      expr2go array
      expr2go index

    | EArrayLength array -> sprintf "len(%a)" 
      expr2go array
    
    | EUnOp (UOpNot, e) -> sprintf "!(%a)" 
    expr2go e

    | EBinOp (op, e1, e2) -> sprintf "%a %a %a" 
    expr2go e1 
    binop2go op 
    expr2go e2
  in
  expr2go e

let expression2go_method_call class_attribute method_declarations e = 
  let rec expr2go_method_call () e =
    match e with
    | EGetVar var-> sprintf "%s" 
      (var2go_method_call class_attribute method_declarations var)
    |_-> sprintf "%a" 
      (expression2go class_attribute method_declarations) e
  in 
  expr2go_method_call e

let statement2go class_attribute method_declarations stat = 
  let rec statement2go () stat =
    match stat with 
    | SBlock statements -> sprintf"{%a%t}" 
    (indent indentation (seplist nl statement2go)) statements 
    nl

    | SIf(ex,stmnt1,stmnt2) -> sprintf "if %a {%a%t} else {%a%t}" 
      (expression2go class_attribute method_declarations) ex 
      (indent indentation (statement2go)) stmnt1
      nl
      (indent indentation (statement2go)) stmnt2
      nl

    | SWhile (ex, stmnt) -> sprintf "for %a {%a%t}" 
      (expression2go class_attribute method_declarations) ex 
      (indent indentation (statement2go)) stmnt
      nl

    | SSysou ex -> sprintf "fmt.Println(%a)" 
      (expression2go class_attribute method_declarations) ex 

    | SSetVar (var,ex) -> sprintf "%s = %a" 
      (var2go class_attribute method_declarations var) 
      (expression2go class_attribute method_declarations) ex 

    | SArraySet (array, index, ex) -> sprintf "%s[%a] = %a"
      (var2go class_attribute method_declarations array)
      (expression2go class_attribute method_declarations) index 
      (expression2go class_attribute method_declarations) ex
  in statement2go stat

let java_type2go () = function
  | TypeInt -> sprintf "int"
  | TypeBool -> sprintf "bool"
  | TypeIntArray -> sprintf "[]int"
  | Type t -> sprintf "* %s" t

let java_type2go_without_pointers () = function
  | TypeInt -> sprintf "int"
  | TypeBool -> sprintf "bool"
  | TypeIntArray -> sprintf "[]int"
  | Type t -> sprintf "%s" t


let decl2go() (var_name, t)=
  sprintf "%s %a" var_name java_type2go t

let decl_var2go () (var_name, t) = 
  (match t with
  | Type t ->  sprintf "var %s %aI%t_ = %s" 
  | _ ->  sprintf "var %s %a%t_ = %s")
  var_name 
  java_type2go_without_pointers t
  nl
  var_name
 
let method2go () (method_name, m, class_name,java_class)  =
  let return2go () expr =
    sprintf "return %a" 
    (expression2go_method_call java_class.attributes m.method_declarations) expr
  in
  sprintf "func (this *%s) %s(%a) %a {%a%a%a%t}%t%t"
    class_name
    method_name
    (seplist comma decl2go) m.arguments
    java_type2go m.return_type
    (termlist nl (indent indentation decl_var2go)) (StringMap.to_association_list m.method_declarations)
    (list (indent indentation (statement2go java_class.attributes m.method_declarations))) m.method_statements
    (indent indentation return2go) m.return_expression
    nl
    nl
    nl

let method_decl2go () (method_name,m)=
  sprintf "%s(%a) %a"
  method_name
  (seplist comma decl2go) m.arguments
  java_type2go m.return_type

let create_go_interface () (class_name, class_methods) =
  sprintf "type %sI interface{%a%t}%t" 
  class_name
  (list (indent indentation (method_decl2go))) (StringMap.to_association_list class_methods)
  nl
  nl


let union_with_a a b =
  let f _key a_opt b_opt =
    match a_opt with
    | Some a_val -> Some a_val
    | None -> b_opt
  in
  StringMap.merge f a b

let add_extends_method_to_methods_decl (java_class,ex_name, defs) =
  let ex_class = StringMap.find ex_name defs in
  union_with_a java_class.methods ex_class.methods


let class2go () (class_name, java_class, defs) =
  (match java_class.extends with
  | None -> sprintf "%a%ttype %s struct{%a}%t%t%a"
    create_go_interface (class_name, java_class.methods)
    nl
    class_name 

  | Some ex_name -> sprintf "%a%ttype %s struct {%a%a}%t%t%a"
    create_go_interface (class_name, add_extends_method_to_methods_decl (java_class,ex_name, defs))
    nl
    class_name 
    (indent indentation (fun () -> sprintf "%s" )) ex_name
  )
    (termlist nl (indent indentation decl2go)) (StringMap.to_association_list java_class.attributes)
    nl
    nl
    (*Methods for the class*)
    (list method2go) (List.map (fun (x, y) -> (x, y, class_name,java_class)) (StringMap.to_association_list java_class.methods))

let program2go out p = 
  Printf.fprintf out "%s\n%!"
  (
    sprintf 
    "package main\n\
    import \"fmt\"\n\n\
    %a\
    func main(){\
    %a\
    \n}\n"
    (*Classes*)
    (termlist nl class2go) (List.map (fun (x, y) -> (x, y, p.defs)) (StringMap.to_association_list p.defs)) 
    (*Main*)
    (indent indentation (statement2go (StringMap.of_association_list []) (StringMap.of_association_list []))) p.main
  )

