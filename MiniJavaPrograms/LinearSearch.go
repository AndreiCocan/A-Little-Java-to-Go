package main
import "fmt"

type LS struct{
  number []int

  size int

}

func (this *LS) Init(sz int) int {
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

func (this *LS) Print() int {
  var j int
  _ = j

  j = 1
  for j < this.size {
    {
      fmt.Println(this.number[j])
      j = j + 1
    }
  }
  return 0
}

func (this *LS) Search(num int) int {
  var aux01 int
  _ = aux01

  var aux02 int
  _ = aux02

  var ifound int
  _ = ifound

  var j int
  _ = j

  var ls01 bool
  _ = ls01

  var nt int
  _ = nt

  j = 1
  ls01 = false
  ifound = 0
  for j < this.size {
    {
      aux01 = this.number[j]
      aux02 = num + 1
      if aux01 < num {
        nt = 0
      } else {
        if !(aux01 < aux02) {
          nt = 0
        } else {
          {
            ls01 = true
            ifound = 1
            j = this.size
          }
        }
      }
      j = j + 1
    }
  }
  return ifound
}

func (this *LS) Start(sz int) int {
  var aux01 int
  _ = aux01

  var aux02 int
  _ = aux02

  aux01 = this.Init(sz)
  aux02 = this.Print()
  fmt.Println(9999)
  fmt.Println(this.Search(8))
  fmt.Println(this.Search(12))
  fmt.Println(this.Search(17))
  fmt.Println(this.Search(50))
  return 55
}


func main(){
  fmt.Println((&LS{}).Start(10))
}

