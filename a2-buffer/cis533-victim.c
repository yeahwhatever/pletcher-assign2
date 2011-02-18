/**
 * CIS 533: Victim code
 * This is what you're going to victimize to show you can do cool
 * and bad things with buffer overflows (the fun of strcpy)
 *
 * Kevin Butler - all kudos to Trent Jaeger
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int main(int, char **); 
extern int shell(int, char**);
extern int victim(int, char**, char *, unsigned int, unsigned int);


int victim(int ct, char **inputs, char *p, unsigned int i, unsigned int j) 
{
  char buf[12];
  int tmp;

  for (i=0; i<12; i++) buf[i] = 0;
  p = buf;
  tmp = ct;

  /* print stats to help you determine how to overflow buffer */
  printf("&main = %p\n", (void *) &main);
  printf("&shell = %p\n", (void *) &shell);
  printf("&inputs[0] = %p\n", (void *) inputs);
  printf("&buf[0] = %p\n", (void *) buf);

  printf("BEFORE picture of stack\n");
  for ( i=((unsigned int) buf-8); i<((unsigned int) ((char *)&ct)+8); i++ ) 
    printf("%p: 0x%x\n", (void *)i, *(unsigned char *) i);  

  /* run overflow */
  for ( i=1; i<tmp; i++ ){
    printf("i = %d; tmp= %d; ct = %d; &tmp = %p\n", i, tmp, ct, (void *)&tmp);
    strcpy(p, inputs[i]);

    /* print stack after the fact */
    printf("AFTER iteration %d\n", i);
    for ( j=((unsigned) buf-8); j<((unsigned) ((char *)&ct)+8); j++ ) 
      printf("%p: 0x%x\n", (void *)j, *(unsigned char *) j);  

    p += strlen(inputs[i]);
    if ( i+1 != tmp )
      *p++ = ' ';
  }
  printf("buf = %s\n", buf);
  printf("victim: %p\n", (void *)&victim);

  return 0;
}


int shell(int i, char **inputs)
{
  printf("In shell\n");
  printf("i = %d; inputs = %p\n", i, (void *)inputs);

  /* should never run the shell normally */
  if (!i) {
    printf("Inside here\n");
    system("/bin/sh");
  }
  printf("After cond\n");
  
  return 0;
}


int main(int argc, char **argv)
{
  char *ptr;

  shell(argc, argv);  
  victim(argc, argv, ptr, 0, 0);

  exit(0);
}
