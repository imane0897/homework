#include <stdlib.h>
#include <stdio.h>

float points[4][4][3] = {
   { {-1.5, -1.5, 4.0},
     {-0.5, -1.5, 2.0},
     {0.5, -1.5, -1.0},
     {1.5, -1.5, 2.0}},
   { {-1.5, -0.5, 1.0},
     {-0.5, -0.5, 3.0},
     {0.5, -0.5, 0.0},
     {1.5, -0.5, -1.0}},
   { {-1.5, 0.5, 4.0},
     {-0.5, 0.5, 0.0},
     {0.5, 0.5, 3.0},
     {1.5, 0.5, 4.0}},
   { {-1.5, 1.5, -2.0},
     {-0.5, 1.5, -2.0},
     {0.5, 1.5, 0.0},
     {1.5, 1.5, -1.0}}
};

int main()
{
	int i;
	for(i = 0; i < 3; i++)
		printf("%f\n", points[0][0][i]);
	return 0;
}