# redo

A better bash script version of djb's redo build system. Redo allows you to rebuild files from source files when they've
changed.

## Usage

redo is rather simple to use. Write a `${TARGET}.do` script or executable (that is, a "dofile"), and everything written
to stdout is sent to the target. Give it permission to execute or it'll be called with `sh -c`.

    # hello.txt.do
    echo "Hello World"

When you execute `redo hello.txt`, redo looks for the script `hello.txt.do`. If it has never been run, has been modified
or the output doesn't exist, the script will run and `hello.txt` will be created.

    $ echo "echo \"Hello World\"" > hello.txt.do
    $ redo hello.txt
    redo hello.txt
    $ cat hello.txt
    Hello World

If your script requires a output file path rather than stdout, the following variables can be used:

  - `$1` - Target basename (`hello` for a `/home/user/hello.txt.do` target)
  - `$2` - Target path and basename (`/home/user/hello`)
  - `$3` - Temporary file that will atomically become your target if the dofile returns with success

Rather than requiring every target to have its own specific dofile, you can can create generic dofiles based on the file
extension. Generic dofiles should be at the same directory of your source file or at the build directory root.

    # default.txt.do
    pandoc -t plain $2.markdown

You can pass multiple targets at once. You also can invoke redo from outside the build directory (read the Makefile).

There are no command-line options, nor a default target when you invoke redo with no arguments. It will just return
after doing nothing.

### Dependencies

Adding build dependencies requires calling `redo-ifchange <list of deps>` from your script or executable.

    # quux.do
    DEPS="foo.o bar.o"
    redo-ifchange $DEPS
    gcc -o $3 $DEPS

If you attempt to `redo quux`, redo will check for changes in `foo.o` and `bar.o` files. If these files are targets,
then their dependencies will be checked too. redo will traverse the dependency tree from top to bottom and only rebuild
what is required.

Dependencies are rebuilt based on file changes, using checksum hashes rather than timestamps.

redo only considers a file that has a dofile as a target, otherwise it will be treated as a source. redo does not try to modify source files.

### Required Creates

If you need a file to not exist prior to building, call `redo-ifcreate <list of deps>` to mark it as a non-existent
dependency. If any file in the list exists when rebuilding the current target, the build will fail. If it doesn't exist you must provide a dofile or create it somehow. If that doesn't work, redo can fail.

    # common.h.do
    redo-ifcreate version.txt
    echo "#define VERSION $(cat version.txt)"

If `redo common.h` is run and `version.txt` exits then it will fail. Otherwise you should see:

    $ redo common.h
    redo version.txt
    redo common.h

## Troubleshooting

If you ever run into issues (I doubt you will) and just want to rebuild the entire system, remove the `.redo` directory
inside the build directory and run `redo` again.

## Example

Try out the example code with `make example` or run `redo example/build/example` directly.

## Installation

    make install
    redo install
    sh install.do

## License

I'm releasing this work into the Public Domain.

## More Info

For more information about redo see [djb's site](http://cr.yp.to/redo.html).

A [youtube video](https://www.youtube.com/watch?v=zZ_nI9E9g0I) by jekor goes through creating a version of redo written
in Haskell.

This [thesis paper](http://grosskurth.ca/papers/mmath-thesis.pdf) by
A. Grosskurth goes through many build systems and then details redo.
