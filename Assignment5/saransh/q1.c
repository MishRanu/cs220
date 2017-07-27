#include <stdio.h>
#include <stdlib.h>

int main()
{
	int n, i;				// Size of the array
	scanf("%d", &n);

	int *a;					// Label for the array
	a = (int *) malloc(n*sizeof(int));	// Allocating memory for the array

	for (i = 0; i < n; i++)			// Taking array as input
		scanf("%d", &a[i]);
	
	printf("%d\n", find_max(n, a));
	return 0;
}
