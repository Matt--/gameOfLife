#include <stdio.h>
#include <errno.h>
#include <string.h>

extern int errno ;

int main ()
{
	char arr[10] = "hello";;
	arr[2] = 'k';   


	printf("Array is : %c\n", arr[2]);


   return 0;
}
