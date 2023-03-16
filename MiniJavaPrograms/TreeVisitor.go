package main
import "fmt"

type MyVisitor struct {
  *Visitor
  

}

func (this *MyVisitor) visit(n * Tree) int {
  var nti int
  _ = nti

  if n.GetHas_Right() {
    {
      this.r = n.GetRight()
      nti = this.r.accept(this)
    }
  } else {
    nti = 0
  }
  fmt.Println(n.GetKey())
  if n.GetHas_Left() {
    {
      l = n.GetLeft()
      nti = l.accept(this)
    }
  } else {
    nti = 0
  }
  return 0
}


type TV struct{
}

func (this *TV) Start() int {
  var ntb bool
  _ = ntb

  var nti int
  _ = nti

  var root * Tree
  _ = root

  var v * MyVisitor
  _ = v

  root = (&Tree{})
  ntb = root.Init(16)
  ntb = root.Print()
  fmt.Println(100000000)
  ntb = root.Insert(8)
  ntb = root.Insert(24)
  ntb = root.Insert(4)
  ntb = root.Insert(12)
  ntb = root.Insert(20)
  ntb = root.Insert(28)
  ntb = root.Insert(14)
  ntb = root.Print()
  fmt.Println(100000000)
  v = (&MyVisitor{})
  fmt.Println(50000000)
  nti = root.accept(v)
  fmt.Println(100000000)
  fmt.Println(root.Search(24))
  fmt.Println(root.Search(12))
  fmt.Println(root.Search(16))
  fmt.Println(root.Search(50))
  fmt.Println(root.Search(12))
  ntb = root.Delete(12)
  ntb = root.Print()
  fmt.Println(root.Search(12))
  return 0
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

  ntb = false
  nti = num2 + 1
  if num1 < num2 {
    ntb = false
  } else {
    if !(num1 < nti) {
      ntb = false
    } else {
      ntb = true
    }
  }
  return ntb
}

func (this *Tree) Delete(v_key int) bool {
  var cont bool
  _ = cont

  var current_node * Tree
  _ = current_node

  var found bool
  _ = found

  var is_root bool
  _ = is_root

  var key_aux int
  _ = key_aux

  var ntb bool
  _ = ntb

  var parent_node * Tree
  _ = parent_node

  current_node = this
  parent_node = this
  cont = true
  found = false
  is_root = true
  for cont {
    {
      key_aux = current_node.GetKey()
      if v_key < key_aux {
        if current_node.GetHas_Left() {
          {
            parent_node = current_node
            current_node = current_node.GetLeft()
          }
        } else {
          cont = false
        }
      } else {
        if key_aux < v_key {
          if current_node.GetHas_Right() {
            {
              parent_node = current_node
              current_node = current_node.GetRight()
            }
          } else {
            cont = false
          }
        } else {
          {
            if is_root {
              if !(current_node.GetHas_Right() && !(current_node.GetHas_Left())) {
                ntb = true
              } else {
                ntb = this.Remove(parent_node, current_node)
              }
            } else {
              ntb = this.Remove(parent_node, current_node)
            }
            found = true
            cont = false
          }
        }
      }
      is_root = false
    }
  }
  return found
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

  var current_node * Tree
  _ = current_node

  var key_aux int
  _ = key_aux

  var new_node * Tree
  _ = new_node

  var ntb bool
  _ = ntb

  new_node = (&Tree{})
  ntb = new_node.Init(v_key)
  current_node = this
  cont = true
  for cont {
    {
      key_aux = current_node.GetKey()
      if v_key < key_aux {
        {
          if current_node.GetHas_Left() {
            current_node = current_node.GetLeft()
          } else {
            {
              cont = false
              ntb = current_node.SetHas_Left(true)
              ntb = current_node.SetLeft(new_node)
            }
          }
        }
      } else {
        {
          if current_node.GetHas_Right() {
            current_node = current_node.GetRight()
          } else {
            {
              cont = false
              ntb = current_node.SetHas_Right(true)
              ntb = current_node.SetRight(new_node)
            }
          }
        }
      }
    }
  }
  return true
}

func (this *Tree) Print() bool {
  var current_node * Tree
  _ = current_node

  var ntb bool
  _ = ntb

  current_node = this
  ntb = this.RecPrint(current_node)
  return true
}

func (this *Tree) RecPrint(node * Tree) bool {
  var ntb bool
  _ = ntb

  if node.GetHas_Left() {
    {
      ntb = this.RecPrint(node.GetLeft())
    }
  } else {
    ntb = true
  }
  fmt.Println(node.GetKey())
  if node.GetHas_Right() {
    {
      ntb = this.RecPrint(node.GetRight())
    }
  } else {
    ntb = true
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
    ntb = this.RemoveLeft(p_node, c_node)
  } else {
    if c_node.GetHas_Right() {
      ntb = this.RemoveRight(p_node, c_node)
    } else {
      {
        auxkey1 = c_node.GetKey()
        auxkey2 = p_node.GetLeft().GetKey()
        if this.Compare(auxkey1, auxkey2) {
          {
            ntb = p_node.SetLeft(this.my_null)
            ntb = p_node.SetHas_Left(false)
          }
        } else {
          {
            ntb = p_node.SetRight(this.my_null)
            ntb = p_node.SetHas_Right(false)
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
      ntb = c_node.SetKey(c_node.GetLeft().GetKey())
      p_node = c_node
      c_node = c_node.GetLeft()
    }
  }
  ntb = p_node.SetLeft(this.my_null)
  ntb = p_node.SetHas_Left(false)
  return true
}

func (this *Tree) RemoveRight(p_node * Tree, c_node * Tree) bool {
  var ntb bool
  _ = ntb

  for c_node.GetHas_Right() {
    {
      ntb = c_node.SetKey(c_node.GetRight().GetKey())
      p_node = c_node
      c_node = c_node.GetRight()
    }
  }
  ntb = p_node.SetRight(this.my_null)
  ntb = p_node.SetHas_Right(false)
  return true
}

func (this *Tree) Search(v_key int) int {
  var cont bool
  _ = cont

  var current_node * Tree
  _ = current_node

  var ifound int
  _ = ifound

  var key_aux int
  _ = key_aux

  current_node = this
  cont = true
  ifound = 0
  for cont {
    {
      key_aux = current_node.GetKey()
      if v_key < key_aux {
        if current_node.GetHas_Left() {
          current_node = current_node.GetLeft()
        } else {
          cont = false
        }
      } else {
        if key_aux < v_key {
          if current_node.GetHas_Right() {
            current_node = current_node.GetRight()
          } else {
            cont = false
          }
        } else {
          {
            ifound = 1
            cont = false
          }
        }
      }
    }
  }
  return ifound
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
  nti = v.visit(this)
  return 0
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
      nti = this.r.accept(this)
    }
  } else {
    nti = 0
  }
  if n.GetHas_Left() {
    {
      this.l = n.GetLeft()
      nti = this.l.accept(this)
    }
  } else {
    nti = 0
  }
  return 0
}


func main(){
  fmt.Println((&TV{}).Start())
}

