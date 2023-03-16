package main
import "fmt"

type A interface {
  Air() int
}

type AImpl struct {
  a int
}

func (a *AImpl) Air() int{
  return a.a
}

type B struct {
  AImpl // Embed the AImpl struct into B to achieve inheritance-like functionality
  // Define any additional fields for B here
  b int
}
func main() {
  var a A
  a = &B{} // Create an instance of B and assign it to a variable of type A
  // Use a as an instance of A here
  fmt.Println(a.a)
}


