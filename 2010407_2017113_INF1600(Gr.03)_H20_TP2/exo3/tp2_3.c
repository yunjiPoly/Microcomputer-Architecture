#include <stdio.h>
#include <stdlib.h>

/* Modifiez ces définitions à votre guise afin de tester toutes les
conditions; elles correspondent aux valeurs initiales de a, b, c, d et e : */
#define INIT_A	0
#define INIT_B	5000
#define INIT_C	3000
#define INIT_D	500
#define INIT_E	1000

int a, b, c, d, e;

extern void func_s(void);

static void func_c(void) {
	int i;
	for (i=0; i<=10; i++){
		a = b + c - d;
		if ((c+1000) > (e-500)) {
			e = e - 300;
			if (b > c) {
				c = c + 300;
			}
		} else {
			c = c - d;
			b = b - 300;
		}
	}
}

int main(void) {
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;

	printf("a = %d    b = %d    c = %d    d = %d    e = %d\n", a, b, c, d, e);
	printf("Le résultat devrait être le même les 3 fois :\n\n");
	func_c();
	printf("Version en langage C : %i\n", a);
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;
	func_s();
	printf("Version en assembleur a : %i\n", a);
	a = INIT_A;
	b = INIT_B;
	c = INIT_C;
	d = INIT_D;
	e = INIT_E;
	func_c();
	printf("Version en langage C : %i\n", a);

	return 0;
}
