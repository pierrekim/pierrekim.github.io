#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int    argc,
         char   **argv,
         char   **envp)
{ 
  unsigned int  i0, i1;
  int           i2;

  /* the seed is the current time of the router, which uses NTP... */
  srand(time(0));

  i0 = rand() % 10000000;
  if (i0 <= 999999)
    i0 += 1000000;
  i1 = 10 * i0;
  i2 = (10 - (i1 / 10000 % 10 + i1 / 1000000 % 10 + i1 / 100 % 10 + 3 *
       (i1 / 100000 % 10 + 10 * i0 / 10000000 % 10 + i1 / 1000 % 10 + i1 / 10 % 10))
        % 10) % 10 + 10 * i0;

  printf("%d\n", i2 );

  return (0);
}
