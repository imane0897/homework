#include<stdio.h>#include<stdlib.h>int cmp(const int *p1, const int *p2)   //�ȽϺ��� {       return *p2 - *p1;}int a[4500000];int main(){	int n,m,i,j,k;	int arr[3002];	while(scanf("%d%d",&n,&m)!=EOF)	{		for(i=0;i<n;i++)			scanf("%d",arr+i);					qsort(arr, n, sizeof(int), cmp);				k=0;		for(i=0;i<n-1;i++)		{			for(j=i+1;j<n;j++)			{			     a[k++]=arr[i]+arr[j];            }        }			     		qsort(a, k, sizeof(int), cmp);				printf("%d",a[0]);		for(i=1;i<m;i++)		  printf(" %d",a[i]);		printf("\n");	}	return 0;}