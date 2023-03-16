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

(*Check if the variable is in the class attributes to put this before*)
let var2go class_attribute var_name =
  try 
  StringMap.find var_name class_attribute;
  sprintf "this.%s" var_name;
  with Not_found ->  sprintf "%s" var_name

let expression2go class_attribute e = 
  let rec expr2go () e =
    match e with
    | EConst const -> sprintf  "%a" 
      constant2go const

    | EGetVar var -> sprintf  "%s" 
      (var2go class_attribute var)

    | EThis -> sprintf "this"

    | EMethodCall (java_object,method_name,args) -> (match java_object with
                                                    |EThis -> sprintf "%a.%s(%a)"
                                                    |_-> sprintf "%a.%s(%a)")
                                                    expr2go java_object
                                                    method_name 
                                                    (seplist comma expr2go) args


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

let statement2go class_attribute stat = 
  let rec statement2go () stat =
    match stat with 
    | SBlock statements -> sprintf"{%a%t}" 
    (indent indentation (seplist nl statement2go)) statements 
    nl

    | SIf(ex,stmnt1,stmnt2) -> sprintf "if %a {%a%t} else {%a%t}" 
      (expression2go class_attribute) ex 
      (indent indentation (statement2go)) stmnt1
      nl
      (indent indentation (statement2go)) stmnt2
      nl

    | SWhile (ex, stmnt) -> sprintf "for %a {%a%t}" 
      (expression2go class_attribute) ex 
      (indent indentation (statement2go)) stmnt
      nl

    | SSysou ex -> sprintf "fmt.Println(%a)" 
      (expression2go class_attribute) ex 

    | SSetVar (var,ex) -> sprintf "%s = %a" 
      (var2go class_attribute var) 
      (expression2go class_attribute) ex 

    | SArraySet (array, index, ex) -> sprintf "%s[%a] = %a"
      (var2go class_attribute array)
      (expression2go class_attribute) index 
      (expression2go class_attribute) ex
  in statement2go stat

let java_type2go () = function
  | TypeInt -> sprintf "int"
  | TypeBool -> sprintf "bool"
  | TypeIntArray -> sprintf "[]int"
  | Type t -> sprintf "* %s" t


let decl2go() (var_name, t)=
  sprintf "%s %a" var_name java_type2go t

let decl_var2go () (var_name, t) =
  sprintf "var %s %a%t_ = %s" 
  var_name 
  java_type2go t
  nl
  var_name
 
let method2go () (method_name, m, class_name,java_class)  =
  let return2go () expr = 
    sprintf "return %a" (expression2go java_class.attributes) expr
  in
  sprintf "func (this *%s) %s(%a) %a {%a%a%a%t}%t%t"
    class_name
    method_name
    (seplist comma decl2go) m.arguments
    java_type2go m.return_type
    (termlist nl (indent indentation decl_var2go)) (StringMap.to_association_list m.method_declarations)
    (list (indent indentation (statement2go java_class.attributes))) m.method_statements
    (indent indentation return2go) m.return_expression
    nl
    nl
    nl
let class2go () (class_name, java_class) =
  (match java_class.extends with
  | None -> sprintf "type %s struct{%a%t}%t%t%a" class_name 
  | Some ex_name -> sprintf "type %s struct {%a%t%a%t}%t%t%a" 
    class_name 
    (indent indentation (fun () -> sprintf "*%s%t" ex_name)) nl
    nl
  )
    (termlist nl (indent indentation decl2go)) (StringMap.to_association_list java_class.attributes)
    nl
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
    (termlist nl class2go) (StringMap.to_association_list p.defs)   
    (*Main*)
    (indent indentation (statement2go (StringMap.of_association_list []))) p.main
  )

