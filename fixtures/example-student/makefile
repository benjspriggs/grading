valgrind: compile
	valgrind ./a.out --error-exitcode=1

debug: compile
	gdb a.out

compile:
	g++ *.cpp

.PHONY: all
