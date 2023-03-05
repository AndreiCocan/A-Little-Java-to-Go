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
| LMJ.SBlock is -> MJ.SBlock (List.map translate_instruction is)
| LMJ.SIf (c, i1, i2) -> MJ.SIf (translate_expression c, translate_instruction i1, translate_instruction i2)
| LMJ.SWhile (c, i) -> MJ.SWhile (translate_expression c, translate_instruction i)
| LMJ.SSysou e -> MJ.SSysou (translate_expression e)
| LMJ.SSetVar (id, e) -> MJ.SSetVar (Location.content id, translate_expression e)
| LMJ.SArraySet (a, e1, e2) -> MJ.SArraySet (Location.content a, translate_expression e1, translate_expression e2)

let translate_java_type = function
| LMJ.TypeInt -> MJ.TypeInt
| LMJ.TypeBool -> MJ.TypeBool
| LMJ.TypeIntArray -> MJ.TypeeIntArray
| LMJ.Type id -> MJ.Type (Location.content id)

let translate_binding f (id, t) = (Location.content id, f t)

let translate_bindings f bindings =
  StringMap.of_association_list (List.map (translate_binding f) bindings)

let translate_java_method m =
  {
    MJ.formals = List.map (fun (id, t) -> (Location.content id, translate_typ t)) m.LMJ.formals;
    MJ.result  = translate_typ m.LMJ.result;
    MJ.locals  = translate_bindings translate_typ m.LMJ.locals;
    MJ.body    = translate_instruction m.LMJ.body;
    MJ.return  = translate_expression m.LMJ.return
  }

let translate_java_class c =
  {
    MJ.extends =
      (match c.LMJ.extends with
      | None -> None
      | Some id -> Some (Location.content id));
    MJ.attributes = translate_bindings translate_typ c.LMJ.attributes;
    MJ.methods = translate_bindings translate_metho c.LMJ.methods
  }

let translate_program p =
  {
    MJ.name = Location.content p.LMJ.name;
    MJ.defs = translate_bindings translate_clas p.LMJ.defs;
    MJ.main = translate_instruction p.LMJ.main;
    MJ.main_args = Location.content p.LMJ.main_args
  }
