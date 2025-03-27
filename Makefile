
.DELETE_ON_ERROR:

ALL_ARTIFACTS := bin/dvd
all: $(ALL_ARTIFACTS)



bin/dvd: src/dvd.c
	gcc -O2 $< -o $@


.PHONY: install
install:
	@ mkdir -p build
	@ mkdir -p bin
# npm ci
# the install procedure

.PHONY: clean
clean:
	- @rm -f $(ALL_ARTIFACTS)
