#include "stdio.h"
#include "malloc.h"
#include "fcntl.h"
#include "string.h"

int main() {
	int *ptr = (int *)malloc(20);
	*ptr = 20;
	int c = *ptr;

	int d = strlen("test");	
}