open MJ
open Print
open Printf

let indentation = 2

let constant2v () = function
  | ConstBool true -> "true"
  | ConstBool false -> "false"
  | ConstInt i -> sprintf "%ld" i

let binop2v = function
  | OpAdd -> sprintf "+"
  | OpSub -> sprintf "-"
  | OpMul -> sprintf "*"
  | OpLt  -> sprintf "<"
  | OpAnd -> sprintf "&&"

  let rec expr0 () = function
  | EConst const -> sprintf  "%a" constant2v const
  | EGetVar var -> sprintf "%s" var
  | EThis -> "this"
  | EMethodCall (java_object,method_name,args) -> sprintf "%a.%s(%a)" expr0 java_object method_name (seplist comma expression2v) args
  | EArrayGet (array,index) -> sprintf "%a[%a]" expr0 array expression2v index
  | EArrayLength array -> sprintf "%a.len" expr0 array
  | EObjectAlloc class_name -> sprintf "%s{}" class_name
  | e -> sprintf "(%a)" expression2v e
and expr1 () = function
  | EArrayAlloc size -> sprintf "[]int{len: %a, init: 0}" expression2v size
  | e -> expr0 () e

and expr2 () = function
  | EUnOp (UOpNot, e) -> sprintf "!%a" expr2 e
  | e -> expr1 () e

and expr3 () = function
  | EBinOp (OpMul as op, e1, e2) -> sprintf "%a %s %a" expr3 e1 (binop2v op) expr3 e2
  | e -> expr2 () e

and expr4 () = function
  | EBinOp (OpSub as op, e1, e2) -> sprintf "%a %s %a" expr4 e1 (binop2v op) expr3 e2
  | e -> expr3 () e

and expr5 () = function
  | EBinOp (OpAdd as op, e1, e2) -> sprintf "%a %s %a" expr5 e1 (binop2v op) expr5 e2
  | e -> expr4 () e

and expr6 () = function
  | EBinOp ((OpLt | OpAnd) as op, e1, e2) -> sprintf "%a %s %a" expr6 e1 (binop2v op) expr6 e2
  | e -> expr5 () e

and expression2v () e = expr6 () e


let rec statement2v out stat = 
  match stat with
  | SBlock statements -> sprintf"{%a%t}" (indent indentation (seplist nl statement2v)) statements nl
  | SIf(ex,stmnt1,stmnt2) -> sprintf "if %a {\n%a%t\n} else {\n%a\n}" 
    (expression2v) ex
    statement2v stmnt1
    nl
    statement2v stmnt2
  | SWhile (ex, stmnt) -> sprintf "for %a {\n%a\n}" expression2v ex statement2v stmnt
  | SSysou ex -> sprintf "fmt.Println(%a)" expression2v ex
  | SSetVar (var,ex) -> sprintf "%s = %a" var expression2v ex
  | SArraySet (array, index, ex) -> sprintf "%s[%a] = %a"
    array
    expression2v index
    expression2v ex
  
let java_type2v () = function
  | TypeInt -> sprintf "int"
  | TypeBool -> sprintf "bool"
  | TypeIntArray -> sprintf "[]int"
  | Type t -> sprintf "%s" t


let decl2v() (var_name, t)=
  sprintf "%s %a" var_name java_type2v t

let decl_var2v () (var_name, t) =
  match t with
  | TypeInt -> sprintf "var %s int" var_name
  | TypeBool -> sprintf "var %s := false" var_name
  | TypeIntArray | Type _ -> sprintf "mut %s := %a{}" var_name java_type2v t
 
let method2v () (method_name, m, class_name,java_class)  =
  let return2v () expr = 
    sprintf "return %a" expression2v expr
  in 
  sprintf "func (this %s) %s(%a) %a {\n%a%a%a\n}\n"
    class_name
    (String.lowercase_ascii method_name)
    (seplist comma decl2v) m.arguments
    java_type2v m.return_type
    (termlist nl (indent indentation decl_var2v)) (StringMap.to_association_list m.method_declarations)
    (list (indent indentation statement2v)) m.method_statements
    (indent indentation return2v) m.return_expression

let class2v () (class_name, java_class) =
  (match java_class.extends with
  | None -> sprintf "type %s struct{\n%a\n}\n%a" class_name
  | Some ex_name -> sprintf "type %s struct {%a\n%a}\n%a" 
    class_name 
    (indent indentation (fun () -> sprintf "*%s%t" ex_name)) nl
  )
    (termlist nl (indent indentation decl2v)) (StringMap.to_association_list java_class.attributes)
    (*Methods for the class*)
    (list method2v) (List.map (fun (x, y) -> (x, y, class_name,java_class)) (StringMap.to_association_list java_class.methods))

let program2v p = 
  Printf.fprintf stdout "%s\n%!"
  (
    sprintf 
    "package main\n\
    import \"fmt\"\n\n\
    %a\
    fn main(){\
    %a\
    \n}\n"
    (*Classes*)
    (termlist nl class2v) (StringMap.to_association_list p.defs)   
    (*Main*)
    (indent indentation statement2v) p.main
  )

