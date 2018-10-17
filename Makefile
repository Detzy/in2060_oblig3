# Compiler to utilize
CC=gcc
# Flags to pass to the compiler
FLAGS=-o1 -g -std=gnu11
# Libraries to link against
LINK=-lpthread -fopenmp -lfftw3 -lm

# Phony targets that Make should ignore
.PHONY: clean all run

# First target builds everything
all: test bench

# Build only the custom FFT code
fft.o: fft.h fft.c
	$(CC) $(FLAGS) $(LINK) -o fft.o -c fft.c

# Build test code for verifying that the output is correct
test: fft.o test.c
	$(CC) $(FLAGS) $(LINK) -o test test.c fft.o

# Build benchmark code to time FFT implementation
bench: fft.o bench.c
	$(CC) $(FLAGS) $(LINK) -o bench bench.c fft.o

# Helper function to test and benchmark
run: test bench
	bash run.sh

# Clean up if needed
clean:
	rm -f test bench fft.o
