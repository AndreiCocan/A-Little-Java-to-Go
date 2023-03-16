package main
import "fmt"

type QS struct{
  number []int

  size int

}

func (this *QS) Init(sz int) int {
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

func (this *QS) Print() int {
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

func (this *QS) Sort(left int, right int) int {
  var aux03 int
  _ = aux03

  var cont01 bool
  _ = cont01

  var cont02 bool
  _ = cont02

  var i int
  _ = i

  var j int
  _ = j

  var nt int
  _ = nt

  var t int
  _ = t

  var v int
  _ = v

  t = 0
  if left < right {
    {
      v = this.number[right]
      i = left - 1
      j = right
      cont01 = true
      for cont01 {
        {
          cont02 = true
          for cont02 {
            {
              i = i + 1
              aux03 = this.number[i]
              if !(aux03 < v) {
                cont02 = false
              } else {
                cont02 = true
              }
            }
          }
          cont02 = true
          for cont02 {
            {
              j = j - 1
              aux03 = this.number[j]
              if !(v < aux03) {
                cont02 = false
              } else {
                cont02 = true
              }
            }
          }
          t = this.number[i]
          this.number[i] = this.number[j]
          this.number[j] = t
          if j < i + 1 {
            cont01 = false
          } else {
            cont01 = true
          }
        }
      }
      this.number[j] = this.number[i]
      this.number[i] = this.number[right]
      this.number[right] = t
      nt = this.Sort(left, i - 1)
      nt = this.Sort(i + 1, right)
    }
  } else {
    nt = 0
  }
  return 0
}

func (this *QS) Start(sz int) int {
  var aux01 int
  _ = aux01

  aux01 = this.Init(sz)
  aux01 = this.Print()
  fmt.Println(9999)
  aux01 = this.size - 1
  aux01 = this.Sort(0, aux01)
  aux01 = this.Print()
  return 0
}


func main(){
  fmt.Println((&QS{}).Start(10))
}

