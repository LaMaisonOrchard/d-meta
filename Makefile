.PHONY: dmd phobos druntime test ddmd ddmd32 ddmd64 \
	phobos32 phobos64 druntime32 druntime64 \
	all clean fetch sync checkout tag

all: phobos

tag:
	-git -C dmd tag "$(TAG)"
	-git -C druntime tag "$(TAG)"
	-git -C phobos tag "$(TAG)"
	-git -C dlang.org tag "$(TAG)"
	git commit -m"Added $(TAG)" -- dmd druntime phobos dlang.org
	git tag -f "$(TAG)"

checkout:
	git -C dmd checkout "$(REV)"
	git -C druntime checkout "$(REV)"
	git -C phobos checkout "$(REV)"
	git -C dlang.org checkout "$(REV)"

sync:
	git -C dmd pull --ff-only upstream master
	git -C dlang.org pull --ff-only upstream master
	git -C druntime pull --ff-only upstream master
	git -C phobos pull --ff-only upstream master

fetch:
	git -C dmd fetch --all
	git -C dlang.org fetch --all
	git -C druntime fetch --all
	git -C phobos fetch --all

ddmd: ddmd32 ddmd64

ddmd64: phobos64
	$(MAKE) -C dmd/src -f posix.mak ddmd MODEL=64

ddmd32: phobos32
	$(MAKE) -C dmd/src -f posix.mak ddmd MODEL=32

clean:
	$(MAKE) -C druntime -f posix.mak clean
	$(MAKE) -C phobos -f posix.mak clean
	$(MAKE) -C dmd/src -f posix.mak clean

dmd:
	$(MAKE) -C dmd/src -f posix.mak

druntime: druntime32 druntime64

druntime32: dmd
	$(MAKE) -C druntime -f posix.mak DMD=../dmd/src/dmd MODEL=32

druntime64: dmd
	$(MAKE) -C druntime -f posix.mak DMD=../dmd/src/dmd MODEL=64

phobos:	phobos32 phobos64

phobos32: druntime32
	$(MAKE) -C phobos -f posix.mak DMD=../dmd/src/dmd MODEL=32 BUILD=debug
	$(MAKE) -C phobos -f posix.mak DMD=../dmd/src/dmd MODEL=32

phobos64: druntime64
	$(MAKE) -C phobos -f posix.mak DMD=../dmd/src/dmd MODEL=64 BUILD=debug
	$(MAKE) -C phobos -f posix.mak DMD=../dmd/src/dmd MODEL=64

test: phobos
	$(MAKE) -C druntime -f posix.mak unittest
	$(MAKE) -C phobos -f posix.mak unittest
	$(MAKE) -C dmd/test

