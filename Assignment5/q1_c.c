#include<stdio.h>
#include<stdlib.h>
int main(){
	int n;
	scanf("%d",&n);
	int *arr= (int*)malloc(sizeof(int)*n);
	int i;
	for(i=0;i<n;i++)
	{
		scanf("%d", &arr[i]);
	}
	
	printf("%d\n",findmax(n,arr));
	return 0;
}
