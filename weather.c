#include <stdio.h>

/*
	weather.c - program demonstrating file i/o and loops and if statements
		1. prompt the user to enter the threshold temp for cold weather and hot weather
		2. scan in the temps.txt file and display the qualitative (hot, mild, cold) for each temp in the file
*/

int main() {
	FILE *fp;
    int num;
	fp = fopen("nums.txt", "r");
	while (fscanf(fp, "%d", &num)==1) {
		printf("%d\n", num);
	}
	fclose(fp);
	return 0;
}
