package main
import "fmt"

type BBSI interface{
  Init(sz int) int
  Print() int
  Sort() int
  Start(sz int) int
}

type BBS struct{
  number []int

  size int
}

func (this *BBS) Init(sz int) int {
  this.size = sz
  this.number = make([]int,sz)
  this.number[0] = 20
  this.number[1] = 7
  this.number[2] = 12
  this.number[3] = 18
  this.number[4] = 2
  this.number[5] = 11
  this.number[6] = 6
  this.number[7] = 9
  this.number[8] = 19
  this.number[9] = 5
  return 0
}

func (this *BBS) Print() int {
  var j int
  _ = j

  j = 0
  for j < this.size {
    {
      fmt.Println(this.number[j])
      j = j + 1
    }
  }
  return 0
}

func (this *BBS) Sort() int {
  var aux02 int
  _ = aux02

  var aux04 int
  _ = aux04

  var aux05 int
  _ = aux05

  var aux06 int
  _ = aux06

  var aux07 int
  _ = aux07

  var i int
  _ = i

  var j int
  _ = j

  var nt int
  _ = nt

  var t int
  _ = t

  i = this.size - 1
  aux02 = 0 - 1
  for aux02 < i {
    {
      j = 1
      for j < i + 1 {
        {
          aux07 = j - 1
          aux04 = this.number[aux07]
          aux05 = this.number[j]
          if aux05 < aux04 {
            {
              aux06 = j - 1
              t = this.number[aux06]
              this.number[aux06] = this.number[j]
              this.number[j] = t
            }
          } else {
            nt = 0
          }
          j = j + 1
        }
      }
      i = i - 1
    }
  }
  return 0
}

func (this *BBS) Start(sz int) int {
  var aux01 int
  _ = aux01

  aux01 = this.Init(sz)
  aux01 = this.Print()
  fmt.Println(99999)
  aux01 = this.Sort()
  aux01 = this.Print()
  return 0
}


type arrayI interface{
}

type array struct{}


type array_I interface{
}

type array_ struct{}


func main(){
  fmt.Println((&BBS{}).Start(10))
}

