TESTS=$(shell find . -name "*.bats")
BATS=bats --tap

all: $(TESTS)
	$(BATS) $(TESTS)
