warnflags := -Wall -W -Wfloat-equal -Wendif-labels -Wshadow \
         -Wpointer-arith -Wcast-align -Wstrict-prototypes \
         -Wredundant-decls
CPPFLAGS := -Iinclude -I.
optflags := -O3 -pipe -ffast-math -fomit-frame-pointer
LDLIBS := -lgmp -lm -lpbc
CFLAGS := $(optflags) $(warnflags)

target:
	gcc -o foo foo.c -I/usr/local/include/pbc $(CFLAGS) $(LDLIBS)

clean:
	rm foo
