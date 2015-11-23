.PHONY: docs clean test

all: src/ext/libcmark.a src/lib_cmark.cr

src/ext/libcmark.a:
	cd src/ext && make

src/lib_cmark.cr: src/lib_cmark.cr.in
	crystal ./libs/crystal_lib/main.cr -- src/lib_cmark.cr.in > src/lib_cmark.cr
	sed -i 's/.\/ext/#{__DIR__}\/ext/' src/lib_cmark.cr

docs:
	crystal docs src/common_mark.cr

clean:
	cd src/ext && make clean

test:
	crystal test/*_test.cr
