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