package main
import "fmt"

type BS struct{
  number []int

  size int

}

func (this *BS) Compare(num1 int, num2 int) bool {
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

func (this *BS) Div(num int) int {
  var aux03 int
  _ = aux03

  var count01 int
  _ = count01

  var count02 int
  _ = count02

  count01 = 0
  count02 = 0
  aux03 = num - 1
  for count02 < aux03 {
    {
      count01 = count01 + 1
      count02 = count02 + 2
    }
  }
  return count01
}

func (this *BS) Init(sz int) int {
  var aux01 int
  _ = aux01

  var aux02 int
  _ = aux02

  var j int
  _ = j

  var k int
  _ = k

  this.size = sz
  this.number = make([]int,sz)
  j = 1
  k = this.size + 1
  for j < this.size {
    {
      aux01 = 2 * j
      aux02 = k - 3
      this.number[j] = aux01 + aux02
      j = j + 1
      k = k - 1
    }
  }
  return 0
}

func (this *BS) Print() int {
  var j int
  _ = j

  j = 1
  for j < this.size {
    {
      fmt.Println(this.number[j])
      j = j + 1
    }
  }
  fmt.Println(99999)
  return 0
}

func (this *BS) Search(num int) bool {
  var aux01 int
  _ = aux01

  var bs01 bool
  _ = bs01

  var left int
  _ = left

  var medium int
  _ = medium

  var nt int
  _ = nt

  var right int
  _ = right

  var var_cont bool
  _ = var_cont

  aux01 = 0
  bs01 = false
  right = len(this.number)
  right = right - 1
  left = 0
  var_cont = true
  for var_cont {
    {
      medium = left + right
      medium = this.Div(medium)
      aux01 = this.number[medium]
      if num < aux01 {
        right = medium - 1
      } else {
        left = medium + 1
      }
      if this.Compare(aux01, num) {
        var_cont = false
      } else {
        var_cont = true
      }
      if right < left {
        var_cont = false
      } else {
        nt = 0
      }
    }
  }
  if this.Compare(aux01, num) {
    bs01 = true
  } else {
    bs01 = false
  }
  return bs01
}

func (this *BS) Start(sz int) int {
  var aux01 int
  _ = aux01

  var aux02 int
  _ = aux02

  aux01 = this.Init(sz)
  aux02 = this.Print()
  if this.Search(8) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(19) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(20) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(21) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(37) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(38) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(39) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  if this.Search(50) {
    fmt.Println(1)
  } else {
    fmt.Println(0)
  }
  return 999
}


func main(){
  fmt.Println((&BS{}).Start(20))
}

