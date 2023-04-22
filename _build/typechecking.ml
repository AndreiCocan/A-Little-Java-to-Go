open LMJ
open Printf

module SM = StringMap
module S = StringSet

type method_type = java_type list * java_type 

type method_env = method_type SM.t

type attribute_env = java_type SM.t

type class_type = attribute_env * method_env

type class_env = class_type SM.t

type variable_env = java_type SM.t

exception Error of string

let error (location : 'a Location.t) (msg : string) =
  raise (Error (sprintf "%s:\n%s"
                  (Error.positions (Location.startpos location) (Location.endpos location))
                  msg))
let errors (locations : 'a Location.t list) (msg : string) =
  raise (Error (sprintf "%s%s"
                  (List.fold_right (fun location acc ->
                      sprintf "%s:\n%s" (Error.positions (Location.startpos location) (Location.endpos location)) acc
                   ) locations "") msg))

let lookup (msg : string) (id : identifier) (env : 'a SM.t) =
  try
    SM.find (Location.content id) env
  with Not_found ->
    error id (sprintf "%s %s is undefined" msg (Location.content id))


let vlookup : identifier -> variable_env -> java_type = lookup "variable"


let mlookup : identifier -> method_env -> method_type = lookup "method"


let alookup : identifier -> attribute_env -> java_type = lookup "attribute"


let clookup : identifier -> class_env -> class_type = lookup "class"



let rec compatible (typ1 : java_type) (typ2 : java_type) (instanceof : identifier -> identifier -> bool) : bool =
  match typ1, typ2 with
  | TypeInt, TypeInt
  | TypeBool, TypeBool
  | TypeIntArray, TypeIntArray -> true
  | Type t1, Type t2 -> instanceof t1 t2
  | _, _ -> false


let rec type_to_string : java_type -> string = function
  | TypeInt -> "integer"
  | TypeBool -> "boolean"
  | TypeIntArray -> "int[]"
  | Type t -> Location.content t


let rec typecheck_call (cenv : class_env) (venv : variable_env) (vinit : S.t)
  (instanceof : identifier -> identifier -> bool)
  (o : expression)
  (callee : identifier)
  (expressions : expression list) : java_type =
  let o_type = typecheck_expression cenv venv vinit instanceof o in
  match o_type with
  | Type t ->
    begin
      let _, method_env = clookup t cenv in
      let (arguments : java_type list), (return_type : java_type) = mlookup callee method_env in
      try
        List.iter2 (typecheck_expression_expecting cenv venv vinit instanceof) arguments expressions;
        return_type
      with Invalid_argument _ ->
        error callee
          (sprintf "Invalid function call, expected %d arguments, got %d"
              (List.length arguments)
              (List.length expressions))
    end
  | _ -> error o (sprintf "A class is expected, got %s" (type_to_string o_type))




and typecheck_expression_expecting (cenv : class_env) (venv : variable_env) (vinit : S.t)
(instanceof : identifier -> identifier -> bool)
(typ1 : java_type)
(e : expression) : unit =
let typ2 = typecheck_expression cenv venv vinit instanceof e in
if not (compatible typ2 typ1 instanceof) then
error e
  (sprintf "Type mismatch, expected %s, got %s" (type_to_string typ1) (type_to_string typ2))


and typecheck_expression (cenv : class_env) (venv : variable_env) (vinit : S.t)
(instanceof : identifier -> identifier -> bool)
(e : expression) : java_type =
match Location.content e with
| EConst (ConstBool _) -> TypeBool

| EConst (ConstInt _) -> TypeInt

| EGetVar v ->
 let java_type = vlookup v venv in
 let v' = Location.content v in
 if not (S.mem v' vinit) then
   error v (sprintf "Variable %s has not been initialized" v');
 java_type

| EUnOp (op, e) ->
  let expected, returned =
    match op with
    | UOpNot -> TypeBool, TypeBool
  in
  typecheck_expression_expecting cenv venv vinit instanceof expected e;
  returned

| EBinOp (op, e1, e2) ->
  let expected, returned =
    match op with
    | OpAdd
    | OpSub
    | OpMul -> TypeInt, TypeInt
    | OpLt  -> TypeInt, TypeBool
    | OpAnd -> TypeBool, TypeBool
  in
  typecheck_expression_expecting cenv venv vinit instanceof expected e1;
  typecheck_expression_expecting cenv venv vinit instanceof expected e2;
  returned

| EMethodCall (o, callee, expressions) ->
 typecheck_call cenv venv vinit instanceof o callee expressions

| EArrayGet (earray, eindex) ->
typecheck_expression_expecting cenv venv vinit instanceof TypeInt eindex;
typecheck_expression_expecting cenv venv vinit instanceof TypeIntArray earray;
TypeInt

| EArrayAlloc elength ->
typecheck_expression_expecting cenv venv vinit instanceof TypeInt elength;
TypeIntArray

| EArrayLength earray ->
typecheck_expression_expecting cenv venv vinit instanceof TypeIntArray earray;
TypeInt

| EThis ->
 vlookup (Location.make (Location.startpos e) (Location.endpos e) "this") venv

| EObjectAlloc id ->
  clookup id cenv |> ignore;
  Type id


let rec typecheck_statement (cenv : class_env) (venv : variable_env) (vinit : S.t)
(instanceof : identifier -> identifier -> bool)
(inst : statement) : S.t =
match inst with
| SSetVar (v, e) ->
 let vinit =
   S.add (Location.content v) vinit
 in
 typecheck_expression_expecting cenv venv vinit instanceof (vlookup v venv) e;
 vinit

| SArraySet (earray, eindex, evalue) ->
typecheck_expression_expecting cenv venv vinit instanceof TypeIntArray
  (Location.make (Location.startpos earray) (Location.endpos earray) (EGetVar earray));
typecheck_expression_expecting cenv venv vinit instanceof TypeInt eindex;
typecheck_expression_expecting cenv venv vinit instanceof TypeInt evalue;
vinit

| SBlock statements ->
 List.fold_left
   (fun vinit inst ->
     typecheck_statement cenv venv vinit instanceof inst)
   vinit
   statements

| SIf (cond, ithen, ielse) ->
typecheck_expression_expecting cenv venv vinit instanceof TypeBool cond;
let vinit1 =
  typecheck_statement cenv venv vinit instanceof ithen
in
let vinit2 =
  typecheck_statement cenv venv vinit instanceof ielse
in
S.inter vinit1 vinit2

| SWhile (cond, imethod_statements) ->
typecheck_expression_expecting cenv venv vinit instanceof TypeBool cond;
typecheck_statement cenv venv vinit instanceof imethod_statements

| SSysou e ->
 typecheck_expression_expecting cenv venv vinit instanceof TypeInt e;
 vinit


let occurrences (x : string) (bindings : (identifier * 'a) list) : identifier list =
List.map fst (List.filter (fun (id, _) -> x = Location.content id) bindings)


let map_of_association_list (entity : string) (bindings : (identifier * 'a) list) : 'a SM.t =
try
SM.of_association_list (List.map (fun (id, data) -> (Location.content id, data)) bindings)
with SM.Duplicate x ->
errors (occurrences x bindings) (sprintf "%s %s is declared more than once" entity x)



let variable_map (decls : (identifier * java_type) list) : variable_env =
map_of_association_list "Variable" decls



let method_map (decls : (identifier * method_type) list) : method_env =
map_of_association_list "Method" decls



let typecheck_method (cenv : class_env) (venv : variable_env)
(instanceof : identifier -> identifier -> bool)
(m : java_method) : unit =

let arguments = m.arguments
and method_declarations = m.method_declarations in

let marguments = variable_map arguments
and mmethod_declarations = variable_map method_declarations in

begin
try
  let x =
    StringSet.choose
      (StringSet.inter
         (SM.domain marguments)
         (SM.domain mmethod_declarations))
  in
  errors (occurrences x arguments @ occurrences x method_declarations)
    "A formal parameter and a local variable cannot carry the same name"
with Not_found ->
  ()
end;

let venv =
SM.addm marguments venv
|> SM.addm mmethod_declarations
in

let vinit =
S.diff (SM.domain venv) (SM.domain mmethod_declarations)
in
let vinit =
typecheck_statement cenv venv vinit instanceof (SBlock m.method_statements)
in
typecheck_expression_expecting cenv venv vinit instanceof m.return_type m.return_expression


let typecheck_class (cenv : class_env) (instanceof : identifier -> identifier -> bool)
((name, c) : identifier * java_class) : unit =
let attribute_env, _ = clookup name cenv in
let venv = SM.add "this" (Type name) attribute_env in
List.iter (typecheck_method cenv venv instanceof) (List.map snd c.methods)


let extract_method_type (m : java_method) : method_type =
(List.map snd m.arguments, m.return_type)


let extract_class_type (c : java_class) : class_type =
(variable_map c.attributes,
method_map (List.map (fun (id, m) -> (id, extract_method_type m)) c.methods))


let class_map (decls : (identifier * java_class) list) : java_class SM.t =
map_of_association_list "Class" decls


let create_instanceof (cmap : java_class SM.t) : identifier -> identifier -> bool =
let rec instanceof id1 id2 =
if id1 = id2 then true
else
  try
    match (SM.find id1 cmap).extends with
    | None -> false
    | Some id3 -> instanceof (Location.content id3) id2
  with Not_found -> false
in
fun id1 id2 ->
instanceof (Location.content id1) (Location.content id2)


let add_method
  (cmap : java_class SM.t)
  (instanceof : identifier -> identifier -> bool)
: java_class SM.t =
let test_compatible_signature ((name, m) : identifier * java_method) ((name', m') : identifier * java_method) : unit =
let typecheck_params (java_type : java_type) (java_type' : java_type) : unit =
  if not (compatible java_type java_type'
            (fun t1 t2 -> Location.content t1 = Location.content t2))
  then
    errors [name; name']
      (sprintf "Type mismatch in params of overriden method, expected %s, got %s" (type_to_string java_type) (type_to_string java_type'))
in
let typecheck_return_type (java_type : java_type) (java_type' : java_type) : unit =
  if not (compatible java_type' java_type instanceof) then
      errors [name; name']
        (sprintf "Type mismatch in return_type of overriden method, expected %s, got %s" (type_to_string java_type) (type_to_string java_type'))
in
let arguments, return_type = extract_method_type m
and arguments', return_type' = extract_method_type m' in
try
  List.iter2 typecheck_params arguments arguments';
  typecheck_return_type return_type return_type'
with Invalid_argument _ ->
  errors [name; name']
    (sprintf "A function that overrides another one must have the same number of parameters" )
in


let rec complete (parent : identifier option) (c : java_class) : java_class =
match parent with
| None -> c
| Some id ->
  let c' = SM.find (Location.content id) cmap in
  complete c'.extends
    {
      c with
        attributes =
        (List.filter
           (fun (name, _) ->
             not (List.exists (fun (name', _) -> Location.content name = Location.content name') c.attributes)
           )
           c'.attributes) @ c.attributes;

        methods =
        (List.filter
           (fun (name, m) ->
             try
               List.find (fun (name', _) -> Location.content name = Location.content name') c.methods
               |> test_compatible_signature (name, m);
               false
             with Not_found -> true
           )
           c'.methods) @ c.methods
    }
in
SM.map (fun c -> complete c.extends c) cmap 

let typecheck_program (p : program) : unit = 
  let cmap = class_map p.defs in
  let instanceof = create_instanceof cmap in
  let cenv =
    add_method cmap instanceof
      |> SM.map extract_class_type
  in
  List.iter (typecheck_class cenv instanceof) p.defs;
  let venv = SM.singleton "this" (Type p.name) in
  typecheck_statement cenv venv S.empty instanceof p.main
  |> ignore

