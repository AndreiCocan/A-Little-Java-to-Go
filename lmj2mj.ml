let rec translate_expression e = translate_raw_expression (Location.content e)

and translate_raw_expression = function
| LMJ.EConst c -> MJ.EConst c
| LMJ.EGetVar id -> MJ.EGetVar (Location.content id)
| LMJ.EUnOp (op, e) -> MJ.EUnOp (op, translate_expression e)
| LMJ.EBinOp (op, e1, e2) -> MJ.EBinOp (op, translate_expression e1, translate_expression e2)
| LMJ.EMethodCall (o, id, args) -> MJ.EMethodCall (translate_expression o, Location.content id, List.map translate_expression args)
| LMJ.EArrayGet (a, i) -> MJ.EArrayGet (translate_expression a, translate_expression i)
| LMJ.EArrayAlloc e -> MJ.EArrayAlloc (translate_expression e)
| LMJ.EArrayLength e -> MJ.EArrayLength (translate_expression e)
| LMJ.EThis -> MJ.EThis
| LMJ.EObjectAlloc id -> MJ.EObjectAlloc (Location.content id)

and translate_statement = function
| LMJ.SBlock is -> MJ.SBlock (List.map translate_statement is)
| LMJ.SIf (c, i1, i2) -> MJ.SIf (translate_expression c, translate_statement i1, translate_statement i2)
| LMJ.SWhile (c, i) -> MJ.SWhile (translate_expression c, translate_statement i)
| LMJ.SSysou e -> MJ.SSysou (translate_expression e)
| LMJ.SSetVar (id, e) -> MJ.SSetVar (Location.content id, translate_expression e)
| LMJ.SArraySet (a, e1, e2) -> MJ.SArraySet (Location.content a, translate_expression e1, translate_expression e2)

let translate_java_type = function
| LMJ.TypeInt -> MJ.TypeInt
| LMJ.TypeBool -> MJ.TypeBool
| LMJ.TypeIntArray -> MJ.TypeIntArray
| LMJ.Type id -> MJ.Type (Location.content id)

let translate_binding f (id, t) = (Location.content id, f t)

let translate_bindings f bindings =
  StringMap.of_association_list (List.map (translate_binding f) bindings)

let translate_java_method m =
  {
    MJ.arguments = List.map (fun (id, t) -> (Location.content id, translate_java_type t)) m.LMJ.arguments;
    MJ.return_type  = translate_java_type m.LMJ.return_type;
    MJ.method_declarations  = translate_bindings translate_java_type m.LMJ.method_declarations;
    MJ.method_statements    = List.map translate_statement m.LMJ.method_statements;
    MJ.return_expression  = translate_expression m.LMJ.return_expression
  }

let translate_java_class c =
  {
    MJ.extends =
      (match c.LMJ.extends with
      | None -> None
      | Some id -> Some (Location.content id));
    MJ.attributes = translate_bindings translate_java_type c.LMJ.attributes;
    MJ.methods = translate_bindings translate_java_method c.LMJ.methods
  }

let translate_program p =
  {
    MJ.name = Location.content p.LMJ.name;
    MJ.defs = translate_bindings translate_java_class p.LMJ.defs;
    MJ.main = translate_statement p.LMJ.main;
    MJ.main_args = Location.content p.LMJ.main_args
  }
