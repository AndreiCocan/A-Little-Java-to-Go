# Little Java to Go - A MiniJava to Golang transpiler

`Little Java to Go` is a transpiler written in [Ocaml](https://ocaml.org) from [MiniJava](https://www.cambridge.org/resources/052182060X/), which is a subset of [Java](https://en.wikipedia.org/wiki/Java_%28programming_language%29), to [Golang](https://go.dev).

---
It was made in the context of a compilation class and proved to be a challenging project.
The program currently supports translation from `MiniJava` to `Golang` but some cases of java polymorphism still remains untranslatable due to fundamental differences between the two languages. 

Indeed, `MiniJava` allows for dynamic method dispatch through the use of virtual method tables and runtime type information, which allows it to handle **method overriding** and **inheritance** in a more flexible manner. `Golang`, on the other hand, uses  **interfaces** and **struct embedding** to achieve similar functionality, but with a more **static and explicit approach**.

This means that some cases of Java polymorphism **may not be directly translatable** to `Golang` without significant changes to the code, which we chose to limit. In particular, cases that rely heavily on **inheritance and dynamic method dispatch** are difficult to replicate in `Golang`.

However, it is still possible to translate many `MiniJava` programs to `Golang` using the `Little Java to Go` transpiler. By understanding the limitations of `Golang` and using the appropriate language constructs, it is possible to create Golang code that captures the essence of original `MiniJava` programs.

## Dependencies
### Ocaml 
```bash
sudo apt-get install ocaml opam
opam init -a -y
eval `opam config env`
opam switch -y 4.07.0
eval `opam config env`
opam install -y ocamlbuild ocamlfind menhir
```
### Golang
See the installation process of `Go` documented [here](https://go.dev/doc/install) 

## Download, Compile and Run
Once you have the dependencies (see above), run the following commands in your terminal.
```bash
git clone https://github.com/AndreiCocan/A-Little-Java-to-Go
cd A-Little-Java-to-Go
make
```
To translate a java file run the following command.
```bash
./ljava2go file.java
```
A `file.go` file will now be created at the same location as `file.java`

Then, you first need to create the module your code will be in. To do that, create a folder in which you will put the `file.go` and init the go module:
```bash
mkdir translatedJava2Go
cd translatedJava2Go
go mod init translatedJava2Go
```
To run the Go file, use:
```bash
go run file.go
```
