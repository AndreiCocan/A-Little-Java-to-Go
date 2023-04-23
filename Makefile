all:
	ocamlbuild -use-menhir -menhir "menhir --explain --dump" main.native
	mv main.native ljava2go

clean:
	ocamlbuild -clean
	rm -f ljava2go
