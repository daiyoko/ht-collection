#include <stdio.h>
int Add(int na, int nb, int * nsum)
{
	if(nsum == NULL)
	{
		return 1;
	}
	else
	{
		*nsum = na + nb;
		return 0;
	}
}