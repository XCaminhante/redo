redo-ifchange "$2.c"
gcc -MD -MF "$2.d" -c -o "$3" "$2.c"
cat <<EOF | sh
redo-ifchange $(sed -r 's_^.+---redoing: __;' "$2.d")
EOF
