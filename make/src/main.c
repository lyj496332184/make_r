#include <stdio.h>
#include "sw.h"
#include "sw1.h"
#include "common.h"

int main()
{
	int a = 10;
	int b = 11;
	int ret = 0;

	comm();

	ret = add(a, b);	
	printf("add:%d\n", ret);

	ret = dec(a, b);
	printf("del:%d\n", ret);

	return 0;
}

