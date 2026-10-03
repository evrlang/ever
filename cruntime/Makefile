SCRIPT_VER = 0.0.1
CC = gcc
OS = Linux
build: cbased.c
	@echo "Ever runtime builder makefile, version $(SCRIPT_VER)"
	@echo "Building for $(OS)"
	$(CC) -shared -fPIC -o libcbased.so cbased.c
