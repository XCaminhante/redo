#!/bin/bash
PROJECTDIR="$(dirname "$BUILDDIR")"
CFILE="${PROJECTDIR}${2/$BUILDDIR/}.c"
DFILE="${BUILDDIR}${2/$BUILDDIR/}.d"

redo-ifchange "$CFILE"
gcc -MD -MF "$DFILE" -c -o "$3" "$CFILE"
redo-ifchange "$DFILE"
cat <<EOF | sh
redo-ifchange $(sed -r 's_^.+--redoing: __' "$DFILE")
EOF
