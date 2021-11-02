#include <stdio.h>
#include <string.h>

/*
	weather.c - program demonstrating file i/o and loops and if statements
		1. prompt the user to enter the threshold temp for cold weather and hot weather
		2. scan in the temps.txt file and display the qualitative (hot, mild, cold) for each temp in the file
*/

int main() {
	FILE *fp;
  int temp;			// the current temperature we are analyzing
	int hightemp; // our threshold for what is considered "hot"
	int lowtemp;  // our threshold for what is considered "cold"
  char intensity[5];
	printf("What do you consider HOT? ");
	scanf("%d",&hightemp);
	printf("What do you consider COLD? ");
	scanf("%d",&lowtemp);
	fp = fopen("temps.txt", "r");
	while (fscanf(fp, "%d", &temp)==1) {
		if (temp > hightemp) {
			strcpy(intensity, "HOT");
		} else if (temp < lowtemp) {
			strcpy(intensity, "COLD");
		} else {
			strcpy(intensity, "MILD");
		}
		printf("%d %s\n", temp, intensity);
	}
	fclose(fp);
	return 0;
}
