#include <stdio.h>
#define LOCK_ADDRESS 0x6400000 /*endereço 104857600*/

volatile int *lock=(int *) LOCK_ADDRESS;

void AcquireLock(){
	while (*lock);
}

void ReleaseLock(){
	*lock = 0;
}
main(){	
	printf("Hello world\n");
	printf("Imprimindo valor inicial do lock\n");
	printf("Valor:%d\n",*lock);
	printf("Mudando valor do lock para 1\n");
	*lock = 1;
	printf("Imprimindo valor do lock\n");
	printf("Valor:%d\n",*lock);
	printf("Mudando valor do lock para 2\n");
	*lock = 2;
	printf("Imprimindo valor inicial do lock\n");
	printf("Valor:%d\n",*lock);
	printf("Imprimindo valor inicial do lock\n");
	printf("Valor:%d\n",*lock);
	
	return 0;
}

