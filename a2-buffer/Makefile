#
# File          : Makefile
# Description   : Build file for CIS 533 assignment 2, buffer overflow
#                 Get attack to launch shell from victim


# Environment Setup
CC=gcc 
CFLAGS=-g -Wall -m32
STACK_FLAGS=-m32 -ffreestanding -fno-common -fno-stack-protector

#
# Setup builds

TARGETS=cis533-attack cis533-victim

attack : cis533-attack.c
	${CC} ${CFLAGS} -o $@ cis533-attack.c

victim : cis533-victim.c
	${CC} ${STACK_FLAGS} -o $@ cis533-victim.c

victim.s : cis533-victim.c
	${CC} ${STACK_FLAGS} -S cis533-victim.c

victim-label : cis533-victim.s
	${CC} ${STACK_FLAGS} -o $@ cis533-victim.s

clean:
	rm -f *.o *.s *~ $(TARGETS) 
	touch cis533-attack.c cis533-victim.c

BASENAME=a2-buffer
tar: 
	tar cvfz $(BASENAME).tgz -C ..\
	    $(BASENAME)/Makefile \
        $(BASENAME)/cis533-victim.c \
	    $(BASENAME)/cis533-attack.c \
        $(BASENAME)/cis533-victim.s \
        $(BASENAME)/attack \
        $(BASENAME)/victim \
        $(BASENAME)/victim-label \
        $(BASENAME)/pletcher-log
