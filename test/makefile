CC  := gcc
CXX := g++

SRCS=$(shell ls *.c)
OBJS=$(subst .c,.o, $(SRCS))

TARGET=hello

#-------------------------------------------------------
.PHONY: all clean rebuild

all: $(TARGET)

./%.o: ./%.c
	$(CC) -o $@ -c $<

clean:
	rm -f $(OBJS) $(TARGET)

rebuild:
	make clean
	make all $(TARGET)