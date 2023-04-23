# Little Java to Go - A MiniJava to Golang transpiler

`Little Java to Go` is a transpiler written in Ocaml from [MiniJava](https://www.cambridge.org/resources/052182060X/), which is a subset of [Java](https://en.wikipedia.org/wiki/Java_%28programming_language%29), to [Golang](https://go.dev).

It was made in the context of a compilation class and proved to be a challenging project.

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
See the installation process of `go` documented [here](https://go.dev/doc/install) 

## Download, Compile and Run
Once you have the dependencies (see above), run the following commands in your terminal.
```bash
git clone https://github.com/AndreiCocan/A-Little-Java-to-Go
make
./mini-java file.java
```
