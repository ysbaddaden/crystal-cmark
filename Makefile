.PHONY: docs clean test

all: ext/libcmark.a src/lib_cmark.cr

ext/libcmark.a:
	cd ext && make

src/lib_cmark.cr: src/lib_cmark.cr.in ext/*.h
	crystal ./lib/crystal_lib/src/main.cr -- src/lib_cmark.cr.in > src/lib_cmark.cr
	sed -i 's/.\/..\/ext/#{__DIR__}\/..\/ext/' src/lib_cmark.cr

docs:
	crystal docs src/common_mark.cr

clean:
	cd ext && make clean

test:
	crystal test/*_test.cr
