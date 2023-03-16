package main
import "fmt"

type Main struct{
}

func (this *Main) createArray(n int) []int {
  var a []int
  _ = a

  var i int
  _ = i

  a = make([]int,n)
  i = 0
  for i < n {
    {
      a[i] = i
      i = i + 1
    }
  }
  return a
}

func (this *Main) init() int {
  return this.createArray(42)[3]
}


func main(){
  fmt.Println((&Main{}).init())
}

