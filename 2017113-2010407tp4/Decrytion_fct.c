
#include <stdio.h>

unsigned int change_endianness(unsigned int x)
{
	unsigned int y;

	/*
	 * Remplacez le code suivant par de l'assembleur en ligne
	 * en utilisant le moins d'instructions possible
	 */
/*
	y = ( x & 0xff000000 ) >> 24 | (x & 0x00ff0000) >> 8 |
        ( x & 0x0000ff00 ) <<  8 | (x & 0x000000ff) << 24;
*/
	
    
	asm volatile (
		// instructions...
        "movl %1, %%ebx\n\t" //on met la valeur en parametre dans ebx
        "bswap %%ebx\n\t"   //on fait un swap qui revient a inverse lordre des bits
        "movl %%ebx, %0\n\t"//on met la valeur inverse dans la variable de sortie y
		: "=r" (y)// sorties (s'il y a lieu)
		: "g" (x)// entrées
		: "%ebx" // registres modifiés (s'il y a lieu)
	);
    
    
	return y;
}

int main()
{
	unsigned int data = 0xff1122ee;

	printf("Donnée en little-endian: %08x\n"
	       "Donnée en big-endian   : %08x\n"
	       "Donnée en little-endian: %08x\n",
	       data,
	       change_endianness(data),
           change_endianness(change_endianness(data))
           );

	return 0;
}
