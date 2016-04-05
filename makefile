compile:
	@g++ *.cpp -g -Wall -o a.out

debug: compile
	@gdb a.out

.PHONY: all
