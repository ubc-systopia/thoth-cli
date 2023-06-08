cli:
	clang -Wall thoth.c -o thoth.o -c
	clang -o thoth \
	thoth.c \
	-lpthread

uncrustify:
	uncrustify -c uncrustify.cfg --replace thoth.c
	uncrustify -c uncrustify.cfg --replace command.h

uncrustify_clean:
	rm *backup*~

all: cli uncrustify uncrustify_clean

install:
	sudo cp --force ./thoth /usr/bin/thoth

uninstall:
	sudo rm -f /usr/bin/thoth

rpm: all
	mkdir -p ~/rpmbuild/{RPMS,SRMS,BUILD,SOURCES,SPECS,tmp}
	rpmbuild -bb thoth-cli.spec
	mkdir -p output
	cp ~/rpmbuild/RPMS/x86_64/* ./output

deb:
	sudo alien output/thoth-cli-$(version)-1.x86_64.rpm
	cp *.deb ./output