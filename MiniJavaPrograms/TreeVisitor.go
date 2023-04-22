package main
import "fmt"

type MyVisitorI interface{
  visit(n * Tree) int
}

type MyVisitor struct {
  Visitor}

func (this *MyVisitor) visit(n * Tree) int {
  var nti int
  _ = nti

  if n.GetHas_Right() {
    {
      r = n.GetRight()
      ntil = r.accept(this)
    }
  } else {
    ntil = 0
  }
  fmt.Println(n.GetKey())
  if n.GetHas_Left() {
    {
      l = n.GetLeft()
      ntil = l.accept(this)
    }
  } else {
    ntil = 0
  }
  return 0
}


type TVI interface{
  Start() int
}

type TV struct{}

func (this *TV) Start() int {
  var ntb bool
  _ = ntb

  var nti int
  _ = nti

  var root TreeI
  _ = root

  var v MyVisitorI
  _ = v

  rootl = (&Tree{})
  ntbl = rootl.Init(16)
  ntbl = rootl.Print()
  fmt.Println(100000000)
  ntbl = rootl.Insert(8)
  ntbl = rootl.Insert(24)
  ntbl = rootl.Insert(4)
  ntbl = rootl.Insert(12)
  ntbl = rootl.Insert(20)
  ntbl = rootl.Insert(28)
  ntbl = rootl.Insert(14)
  ntbl = rootl.Print()
  fmt.Println(100000000)
  vl = (&MyVisitor{})
  fmt.Println(50000000)
  ntil = rootl.accept(vl)
  fmt.Println(100000000)
  fmt.Println(rootl.Search(24))
  fmt.Println(rootl.Search(12))
  fmt.Println(rootl.Search(16))
  fmt.Println(rootl.Search(50))
  fmt.Println(rootl.Search(12))
  ntbl = rootl.Delete(12)
  ntbl = rootl.Print()
  fmt.Println(rootl.Search(12))
  return 0
}


type TreeI interface{
  Compare(num1 int, num2 int) bool
  Delete(v_key int) bool
  GetHas_Left() bool
  GetHas_Right() bool
  GetKey() int
  GetLeft() * Tree
  GetRight() * Tree
  Init(v_key int) bool
  Insert(v_key int) bool
  Print() bool
  RecPrint(node * Tree) bool
  Remove(p_node * Tree, c_node * Tree) bool
  RemoveLeft(p_node * Tree, c_node * Tree) bool
  RemoveRight(p_node * Tree, c_node * Tree) bool
  Search(v_key int) int
  SetHas_Left(val bool) bool
  SetHas_Right(val bool) bool
  SetKey(v_key int) bool
  SetLeft(ln * Tree) bool
  SetRight(rn * Tree) bool
  accept(v * Visitor) int
}

type Tree struct{
  has_left bool

  has_right bool

  key int

  left * Tree

  my_null * Tree

  right * Tree
}

func (this *Tree) Compare(num1 int, num2 int) bool {
  var ntb bool
  _ = ntb

  var nti int
  _ = nti

  ntbl = false
  ntil = num2 + 1
  if num1 < num2 {
    ntbl = false
  } else {
    if !(num1 < ntil) {
      ntbl = false
    } else {
      ntbl = true
    }
  }
  return ntbl
}

func (this *Tree) Delete(v_key int) bool {
  var cont bool
  _ = cont

  var current_node TreeI
  _ = current_node

  var found bool
  _ = found

  var is_root bool
  _ = is_root

  var key_aux int
  _ = key_aux

  var ntb bool
  _ = ntb

  var parent_node TreeI
  _ = parent_node

  current_nodel = this
  parent_nodel = this
  contl = true
  foundl = false
  is_rootl = true
  for contl {
    {
      key_auxl = current_nodel.GetKey()
      if v_key < key_auxl {
        if current_nodel.GetHas_Left() {
          {
            parent_nodel = current_nodel
            current_nodel = current_nodel.GetLeft()
          }
        } else {
          contl = false
        }
      } else {
        if key_auxl < v_key {
          if current_nodel.GetHas_Right() {
            {
              parent_nodel = current_nodel
              current_nodel = current_nodel.GetRight()
            }
          } else {
            contl = false
          }
        } else {
          {
            if is_rootl {
              if !(current_nodel.GetHas_Right() && !(current_nodel.GetHas_Left())) {
                ntbl = true
              } else {
                ntbl = this.Remove(parent_nodel, current_nodel)
              }
            } else {
              ntbl = this.Remove(parent_nodel, current_nodel)
            }
            foundl = true
            contl = false
          }
        }
      }
      is_rootl = false
    }
  }
  return foundl
}

func (this *Tree) GetHas_Left() bool {
  return this.has_left
}

func (this *Tree) GetHas_Right() bool {
  return this.has_right
}

func (this *Tree) GetKey() int {
  return this.key
}

func (this *Tree) GetLeft() * Tree {
  return this.left
}

func (this *Tree) GetRight() * Tree {
  return this.right
}

func (this *Tree) Init(v_key int) bool {
  this.key = v_key
  this.has_left = false
  this.has_right = false
  return true
}

func (this *Tree) Insert(v_key int) bool {
  var cont bool
  _ = cont

  var current_node TreeI
  _ = current_node

  var key_aux int
  _ = key_aux

  var new_node TreeI
  _ = new_node

  var ntb bool
  _ = ntb

  new_nodel = (&Tree{})
  ntbl = new_nodel.Init(v_key)
  current_nodel = this
  contl = true
  for contl {
    {
      key_auxl = current_nodel.GetKey()
      if v_key < key_auxl {
        {
          if current_nodel.GetHas_Left() {
            current_nodel = current_nodel.GetLeft()
          } else {
            {
              contl = false
              ntbl = current_nodel.SetHas_Left(true)
              ntbl = current_nodel.SetLeft(new_nodel)
            }
          }
        }
      } else {
        {
          if current_nodel.GetHas_Right() {
            current_nodel = current_nodel.GetRight()
          } else {
            {
              contl = false
              ntbl = current_nodel.SetHas_Right(true)
              ntbl = current_nodel.SetRight(new_nodel)
            }
          }
        }
      }
    }
  }
  return true
}

func (this *Tree) Print() bool {
  var current_node TreeI
  _ = current_node

  var ntb bool
  _ = ntb

  current_nodel = this
  ntbl = this.RecPrint(current_nodel)
  return true
}

func (this *Tree) RecPrint(node * Tree) bool {
  var ntb bool
  _ = ntb

  if node.GetHas_Left() {
    {
      ntbl = this.RecPrint(node.GetLeft())
    }
  } else {
    ntbl = true
  }
  fmt.Println(node.GetKey())
  if node.GetHas_Right() {
    {
      ntbl = this.RecPrint(node.GetRight())
    }
  } else {
    ntbl = true
  }
  return true
}

func (this *Tree) Remove(p_node * Tree, c_node * Tree) bool {
  var auxkey1 int
  _ = auxkey1

  var auxkey2 int
  _ = auxkey2

  var ntb bool
  _ = ntb

  if c_node.GetHas_Left() {
    ntbl = this.RemoveLeft(p_node, c_node)
  } else {
    if c_node.GetHas_Right() {
      ntbl = this.RemoveRight(p_node, c_node)
    } else {
      {
        auxkey1l = c_node.GetKey()
        auxkey2l = p_node.GetLeft().GetKey()
        if this.Compare(auxkey1l, auxkey2l) {
          {
            ntbl = p_node.SetLeft(this.my_null)
            ntbl = p_node.SetHas_Left(false)
          }
        } else {
          {
            ntbl = p_node.SetRight(this.my_null)
            ntbl = p_node.SetHas_Right(false)
          }
        }
      }
    }
  }
  return true
}

func (this *Tree) RemoveLeft(p_node * Tree, c_node * Tree) bool {
  var ntb bool
  _ = ntb

  for c_node.GetHas_Left() {
    {
      ntbl = c_node.SetKey(c_node.GetLeft().GetKey())
      p_node = c_node
      c_node = c_node.GetLeft()
    }
  }
  ntbl = p_node.SetLeft(this.my_null)
  ntbl = p_node.SetHas_Left(false)
  return true
}

func (this *Tree) RemoveRight(p_node * Tree, c_node * Tree) bool {
  var ntb bool
  _ = ntb

  for c_node.GetHas_Right() {
    {
      ntbl = c_node.SetKey(c_node.GetRight().GetKey())
      p_node = c_node
      c_node = c_node.GetRight()
    }
  }
  ntbl = p_node.SetRight(this.my_null)
  ntbl = p_node.SetHas_Right(false)
  return true
}

func (this *Tree) Search(v_key int) int {
  var cont bool
  _ = cont

  var current_node TreeI
  _ = current_node

  var ifound int
  _ = ifound

  var key_aux int
  _ = key_aux

  current_nodel = this
  contl = true
  ifoundl = 0
  for contl {
    {
      key_auxl = current_nodel.GetKey()
      if v_key < key_auxl {
        if current_nodel.GetHas_Left() {
          current_nodel = current_nodel.GetLeft()
        } else {
          contl = false
        }
      } else {
        if key_auxl < v_key {
          if current_nodel.GetHas_Right() {
            current_nodel = current_nodel.GetRight()
          } else {
            contl = false
          }
        } else {
          {
            ifoundl = 1
            contl = false
          }
        }
      }
    }
  }
  return ifoundl
}

func (this *Tree) SetHas_Left(val bool) bool {
  this.has_left = val
  return true
}

func (this *Tree) SetHas_Right(val bool) bool {
  this.has_right = val
  return true
}

func (this *Tree) SetKey(v_key int) bool {
  this.key = v_key
  return true
}

func (this *Tree) SetLeft(ln * Tree) bool {
  this.left = ln
  return true
}

func (this *Tree) SetRight(rn * Tree) bool {
  this.right = rn
  return true
}

func (this *Tree) accept(v * Visitor) int {
  var nti int
  _ = nti

  fmt.Println(333)
  ntil = v.visit(this)
  return 0
}


type VisitorI interface{
  visit(n * Tree) int
}

type Visitor struct{
  l * Tree

  r * Tree
}

func (this *Visitor) visit(n * Tree) int {
  var nti int
  _ = nti

  if n.GetHas_Right() {
    {
      this.r = n.GetRight()
      ntil = this.r.accept(this)
    }
  } else {
    ntil = 0
  }
  if n.GetHas_Left() {
    {
      this.l = n.GetLeft()
      ntil = this.l.accept(this)
    }
  } else {
    ntil = 0
  }
  return 0
}


func main(){
  fmt.Println((&TV{}).Start())
}

