# d-meta
Meta repo for all D stuff. Hope to combine compatible dmd+phobos+druntime+dlang.org as submodules.

Compiler changes often coincides with changes to the one or both of the D runtime libraries.
Not having a matching compiler and libraries makes testing impossible.

Furthermore, this repo also provides a top-level Makefile which can be used to build all the libraries,
in all their flavors, including running all the tests.

## Cloning
This repository is using GIT submodules. With version 1.6.5 of Git and later, you can use:
```
git clone --recursive git@github.com:lionello/d-meta.git
```
For already cloned repos, or older Git versions, just use:
```
git clone git@github.com:lionello/d-meta.git
cd d-meta
git submodule update --init --recursive
```
