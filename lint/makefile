RUNTEST=python -m unittest -v -b
ALLMODULES=$(patsubst %.py, %, $(wilcard test_*.py))

all:
	${RUNTEST} ${ALLMODULES}

% : test_%.py
	${RUNTEST} test_$@
