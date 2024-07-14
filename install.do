# Install using sh or using redo
# Obviously use sh only on the first install
# /bin/sh install.do
#    or
# redo install

BINDIR=$HOME/.local/bin

which redo-ifchange 1>/dev/null
[ $? -ne 0 ] || redo-ifchange redo

[ ! -e $BINDIR/redo ] || rm -f $BINDIR/redo
[ ! -e $BINDIR/redo-ifcreate ] || rm -f $BINDIR/redo-ifcreate
[ ! -e $BINDIR/redo-ifchange ] || rm -f $BINDIR/redo-ifchange

install redo $BINDIR
ln -sf $BINDIR/redo{,-ifchange}
ln -sf $BINDIR/redo{,-ifcreate}
