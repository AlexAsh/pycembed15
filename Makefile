CFLAGS+=-I/usr/include/python2.7 -g -O0 -Wall
LDLIBS+=-lpython2.7

GENERATED=str *.so woex woexp.c pyftw.c

all:	str list repeat.so woex woexp.so pyftw.so

%.c:	%.pyx 
	cython $< -o $@

%.so: %.c
	$(CC) $< $(CFLAGS) -o $@ -shared -fPIC $(LDFLAGS) $(LDLIBS)

clean:
	rm -f $(GENERATED) *.o

demo:	all
	./str qwert 1 3 4
	./list qwe rty uio asd fgh 1 4 4
	python testrepeat.py
	./woex
	python testwoexp.py
	python testftw.py

test:	all
	valgrind ./str qwert 1 3 4
	valgrind ./list qwe rty uio asd fgh 1 4 4
	valgrind python testrepeat.py
	python -c 'import repeat; print dir(repeat); help(repeat)' | cat
	valgrind python testwoexp.py
	python -c 'import woexp; print dir(woexp); help(woexp)' | cat
	valgrind python testftw.py
	python -c 'import pyftw; print dir(pyftw); help(pyftw)' | cat
