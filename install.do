# sh install.do
# redo install
# make install

BINDIR="$HOME"/bin

[ -e "$BINDIR"/redo ] && rm -f "$BINDIR"/redo
[ -e "$BINDIR"/redo-ifcreate ] && rm -f "$BINDIR"/redo-ifcreate
[ -e "$BINDIR"/redo-ifchange ] && rm -f "$BINDIR"/redo-ifchange
[ -e "$BINDIR"/redo-ifcomputedchange ] && rm -f "$BINDIR"/redo-ifcomputedchange

install redo "$BINDIR"
ln -sf ./redo "$BINDIR"/redo-ifcomputedchange
ln -sf ./redo "$BINDIR"/redo-ifchange
ln -sf ./redo "$BINDIR"/redo-ifcreate
