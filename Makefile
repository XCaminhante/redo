all: example

install: FORCE
	@redo $@

example: FORCE
	@redo example/build/example

clean: FORCE
	@redo example/build/clean

FORCE: ;
