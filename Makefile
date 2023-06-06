cli:
	clang -Wall thoth.c -o thoth.o -c
	clang -o thoth \
	thoth.c \
	-lpthread

install:
	sudo cp --force ./thoth /usr/bin/thoth