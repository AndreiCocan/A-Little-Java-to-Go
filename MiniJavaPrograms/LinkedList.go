package main
import "fmt"

type ElementI interface{
  Compare(num1 int, num2 int) bool
  Equal(other * Element) bool
  GetAge() int
  GetMarried() bool
  GetSalary() int
  Init(v_Age int, v_Salary int, v_Married bool) bool
}

type Element struct{
  Age int

  Married bool

  Salary int
}

func (this *Element) Compare(num1 int, num2 int) bool {
  var aux02 int
  _ = aux02

  var retval bool
  _ = retval

  retval = false
  aux02 = num2 + 1
  if num1 < num2 {
    retval = false
  } else {
    if !(num1 < aux02) {
      retval = false
    } else {
      retval = true
    }
  }
  return retval
}

func (this *Element) Equal(other * Element) bool {
  var aux01 int
  _ = aux01

  var aux02 int
  _ = aux02

  var nt int
  _ = nt

  var ret_val bool
  _ = ret_val

  ret_val = true
  aux01 = other.GetAge()
  if !(this.Compare(aux01, this.Age)) {
    ret_val = false
  } else {
    {
      aux02 = other.GetSalary()
      if !(this.Compare(aux02, this.Salary)) {
        ret_val = false
      } else {
        if this.Married {
          if !(other.GetMarried()) {
            ret_val = false
          } else {
            nt = 0
          }
        } else {
          if other.GetMarried() {
            ret_val = false
          } else {
            nt = 0
          }
        }
      }
    }
  }
  return ret_val
}

func (this *Element) GetAge() int {
  return this.Age
}

func (this *Element) GetMarried() bool {
  return this.Married
}

func (this *Element) GetSalary() int {
  return this.Salary
}

func (this *Element) Init(v_Age int, v_Salary int, v_Married bool) bool {
  this.Age = v_Age
  this.Salary = v_Salary
  this.Married = v_Married
  return true
}


type LLI interface{
  Start() int
}

type LL struct{}

func (this *LL) Start() int {
  var aux01 bool
  _ = aux01

  var el01 ElementI
  _ = el01

  var el02 ElementI
  _ = el02

  var el03 ElementI
  _ = el03

  var head ListI
  _ = head

  var last_elem ListI
  _ = last_elem

  last_elem = (&List{})
  aux01 = last_elem.Init()
  head = last_elem
  aux01 = head.Init()
  aux01 = head.Print()
  el01 = (&Element{})
  aux01 = el01.Init(25, 37000, false)
  head = head.Insert(el01.(*Element))
  aux01 = head.Print()
  fmt.Println(10000000)
  el01 = (&Element{})
  aux01 = el01.Init(39, 42000, true)
  el02 = el01
  head = head.Insert(el01.(*Element))
  aux01 = head.Print()
  fmt.Println(10000000)
  el01 = (&Element{})
  aux01 = el01.Init(22, 34000, false)
  head = head.Insert(el01.(*Element))
  aux01 = head.Print()
  el03 = (&Element{})
  aux01 = el03.Init(27, 34000, false)
  fmt.Println(head.Search(el02.(*Element)))
  fmt.Println(head.Search(el03.(*Element)))
  fmt.Println(10000000)
  el01 = (&Element{})
  aux01 = el01.Init(28, 35000, false)
  head = head.Insert(el01.(*Element))
  aux01 = head.Print()
  fmt.Println(2220000)
  head = head.Delete(el02.(*Element))
  aux01 = head.Print()
  fmt.Println(33300000)
  head = head.Delete(el01.(*Element))
  aux01 = head.Print()
  fmt.Println(44440000)
  return 0
}


type ListI interface{
  Delete(e * Element) * List
  GetElem() * Element
  GetEnd() bool
  GetNext() * List
  Init() bool
  InitNew(v_elem * Element, v_next * List, v_end bool) bool
  Insert(new_elem * Element) * List
  Print() bool
  Search(e * Element) int
  SetNext(v_next * List) bool
}

type List struct{
  elem * Element

  end bool

  next * List
}

func (this *List) Delete(e * Element) * List {
  var aux01 ListI
  _ = aux01

  var aux04 int
  _ = aux04

  var aux05 bool
  _ = aux05

  var my_head ListI
  _ = my_head

  var nt int
  _ = nt

  var prev ListI
  _ = prev

  var ret_val bool
  _ = ret_val

  var var_elem ElementI
  _ = var_elem

  var var_end bool
  _ = var_end

  my_head = this
  ret_val = false
  aux04 = 0 - 1
  aux01 = this
  prev = this
  var_end = this.end
  var_elem = this.elem
  for !(var_end) && !(ret_val) {
    {
      if e.Equal(var_elem.(*Element)) {
        {
          ret_val = true
          if aux04 < 0 {
            {
              my_head = aux01.GetNext()
            }
          } else {
            {
              fmt.Println(0 - 555)
              aux05 = prev.SetNext(aux01.GetNext())
              fmt.Println(0 - 555)
            }
          }
        }
      } else {
        nt = 0
      }
      if !(ret_val) {
        {
          prev = aux01
          aux01 = aux01.GetNext()
          var_end = aux01.GetEnd()
          var_elem = aux01.GetElem()
          aux04 = 1
        }
      } else {
        nt = 0
      }
    }
  }
  return my_head.(*List)
}

func (this *List) GetElem() * Element {
  return this.elem
}

func (this *List) GetEnd() bool {
  return this.end
}

func (this *List) GetNext() * List {
  return this.next
}

func (this *List) Init() bool {
  this.end = true
  return true
}

func (this *List) InitNew(v_elem * Element, v_next * List, v_end bool) bool {
  this.end = v_end
  this.elem = v_elem
  this.next = v_next
  return true
}

func (this *List) Insert(new_elem * Element) * List {
  var aux02 ListI
  _ = aux02

  var aux03 ListI
  _ = aux03

  var ret_val bool
  _ = ret_val

  aux03 = this
  aux02 = (&List{})
  ret_val = aux02.InitNew(new_elem, aux03.(*List), false)
  return aux02.(*List)
}

func (this *List) Print() bool {
  var aux01 ListI
  _ = aux01

  var var_elem ElementI
  _ = var_elem

  var var_end bool
  _ = var_end

  aux01 = this
  var_end = this.end
  var_elem = this.elem
  for !(var_end) {
    {
      fmt.Println(var_elem.GetAge())
      aux01 = aux01.GetNext()
      var_end = aux01.GetEnd()
      var_elem = aux01.GetElem()
    }
  }
  return true
}

func (this *List) Search(e * Element) int {
  var aux01 ListI
  _ = aux01

  var int_ret_val int
  _ = int_ret_val

  var nt int
  _ = nt

  var var_elem ElementI
  _ = var_elem

  var var_end bool
  _ = var_end

  int_ret_val = 0
  aux01 = this
  var_end = this.end
  var_elem = this.elem
  for !(var_end) {
    {
      if e.Equal(var_elem.(*Element)) {
        {
          int_ret_val = 1
        }
      } else {
        nt = 0
      }
      aux01 = aux01.GetNext()
      var_end = aux01.GetEnd()
      var_elem = aux01.GetElem()
    }
  }
  return int_ret_val
}

func (this *List) SetNext(v_next * List) bool {
  this.next = v_next
  return true
}


func main(){
  fmt.Println((&LL{}).Start())
}

