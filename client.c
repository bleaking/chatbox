#include<stdlib.h>
#include<stdio.h>
#include<sys/socket.h>
#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>

int main(int argc,char* argv[]){

	system("clear");
	int sock=0;
	struct sockaddr_in serv_addr;
	char buffer[1024]={0};
	int opt=0;
	char login[2][24]={0};

	sock=socket(AF_INET,SOCK_STREAM,0);

	serv_addr.sin_family=AF_INET;
	serv_addr.sin_port=htons(8080);
	inet_pton(AF_INET,"127.0.0.1",&serv_addr.sin_addr);

	connect(sock,((struct sockaddr*)&serv_addr),sizeof(serv_addr));

	printf("1.login\n2.signup\n3.exit\n");
	opt=(int)fgetc(stdin);

	switch(opt){
		case (1):
			printf("Username: \n");
			fgets(login[0],24,stdin);
			printf("Password: \n");
			fgets(login[1],24,stdin);
			break;
		case (2):
			printf("!!! Sign Up !!!");
			printf("Username: \n");
			fgets(login[0],24,stdin);
			printf("password: \n");
			fgets(login[1],24,stdin);
			break;
		case (3):
			exit(0);
		default:
			printf("Wrong Option\n");
			break;
	}

	while(1){
		fgets(buffer,sizeof(buffer),stdin);
		send(sock,buffer,strlen(buffer),0);
	}

	close(sock);
	return 0;
}

