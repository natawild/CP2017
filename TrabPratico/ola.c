#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[]){
	char frase[1000]="say ";
	int i;
	if(argc>=2){
		for(i=1;i<argc;i++){
			strcat(frase,argv[i]);
			strcat(frase," ");
		}
		while(1){
			system(frase);
		}
	}
}