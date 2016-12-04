VERSION ?= 0.24.1
CMARK = cmark-$(VERSION)
SOURCES = $(wildcard $(CMARK)/src/*.c) $(wildcard $(CMARK)/src/*.h)

all: libcmark.a

libcmark.a: cmark-$(VERSION) $(SOURCES)
	cd $(CMARK) && INSTALL_PREFIX=.. make
	cp $(CMARK)/src/*.h .
	cp $(CMARK)/build/src/*.h .
	cp $(CMARK)/build/src/*.a .

$(CMARK):
	curl -L https://github.com/jgm/cmark/archive/$(VERSION).tar.gz | tar zx

clean:
	rm -rf cmark-*

distclean: clean
	rm -rf *.a *.h
