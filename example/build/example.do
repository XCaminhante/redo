#!/bin/bash
DEPS=("bar bar.o" "foo foo.o" "quux/baz.o")
redo-ifchange "${DEPS[@]}"
gcc -o "$3" "${DEPS[@]}"
