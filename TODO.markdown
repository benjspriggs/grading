# TODO.md
- [x] Figure out style/ code requirements for CS162 homework assignments
- [x] Figure out style/ code requirements for CS163 homework assignments
- [x] Figure out style/ code requirements for CS202 homework assignments

# CS162
## Code Requirements
- [x] Complete and compiles
- [x] Runs without run-time faults
- [ ] All functions are no larger than 30 lines of code (not including comments, blank lines, or variable declarations) (For later programs)

## Style requirements
- [ ] Add check for correct spelling and grammar
- [ ] Check for conventions being met for variables, constant, function names:
	- [ ] No capitalized or upper case variables
	- [ ] Single letter vairable names for loop control variables (May be difficult to implement?)
- [x] Use of gotos and global variables not allowed (GLOBAL CONSTANTS OKAY)
- [ ] No breaks within loops
- [ ] No returns from a function within a loop
- [ ] All variable definitions must be before the executable statements of main/ each function (clarify?)
- [ ] One statement per line
- [ ] Comments prior to the code where it appears
- [ ] Blank space required between words in a line
- [ ] Blank space after each comma, and after * / + - = << >>
- [ ] Indent each line of the program except for the curly braces that mark the beginning and end (TWO HARD SPACES MINIMUM, CONSISTENTLY)
- [ ] Blank lines required between sections of program
- [ ] Curly braces always appear on line after conditional in if, switch
- [ ] Switch statement lables appear on same line of first statement
- [ ] Header at top of EACH file explaining program use, with author name, date, class number, and program number
- [ ] Header at top of each function
- [ ] Comment after each varible declaration with usage
- [ ] No use of while(1)
- [ ] No use of standard string class (``"#include <string>``)

# CS163
## Code requirements
- [x] Complete and compiles
- [x] Runs without runtime faults
- [ ] No use of static arrays
- [x] Destructors deallocate all dynamic memory

## Style requirements
- [ ] Consistent use of blank spaces, use of comments
- [ ] Only prefix increment/ decrement usage, unless there is some reason to use postfix
- [ ] No passing class objects by value
- [ ] No returning class objects or structs
- [ ] Indent after each opening curly bracket
- [ ] Meets all of the CS162 requirements
- [ ] Every function must contain a return
- [ ] Parameterless functions must have void argument
- [ ] No including .c files
- [ ] Public, then protected or private sections for classes in that order (last two are interchangeable - clarify?)
- [ ] Classes meet class indentation requirements
- [ ] Destructors of classes that utilize dynamic memory must deallocate it
- [ ] Headers must outline INPUT and OUTPUT of each function where needed (ex. not needed on void functions, but functionality still needs to be outlined in comment)
- [ ] No use of exit, continue, break to alter loop control flow
- [ ] Minimum 3 lines separating each function

# CS202
## Code requirements
- [x] Complete and compiles
- [x] Runs without runtime faults
- [x] No use of static arrays
- [x] Destructors deallocate all dynamic memory

## Style requirements
- [ ] Consistent style of indentation
- [x] No global variables
- [ ] No use of exit, continue, break to alter control flow loops
- [x] No while(1) loops or while(true) loops
- [ ] No use of the std::string class (EXCEPT IN LATER ASSIGNMENTS)
- [ ] Each file has name of the file, student, class number in header at top of the file
- [ ] Comments use correct spelling and grammar
- [x] No gotos
- [ ] All variable declarations happen before main()
- [ ] Blank space after each function
- [ ] Space after , . < > << >> + * / -
- [ ] All lines between {} indented two or more spaces
- [ ] All switches use the default label
- [ ] IF and SWITCH statements are properly indented

- [ ] Actually make the count_globals function count globals
- [x] Figure out what's giving the "line 25, ./: Is a directory" issues in no-runtime-errors.sh
