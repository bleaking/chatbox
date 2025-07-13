#include<stdlib.h>
#include<unistd.h>
#include<stdio.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<string.h>
#include<sys/wait.h>
#include<pthread.h>
#include<string.h>

void landing();
void Authorize();

int server_fd;
struct sockaddr_in address;
int addrlen=sizeof(address);
//char buff[1024]={0};

int main(int argc,char* argv[]){
	//static int server_fd;
	//static struct sockaddr_in address;
	char buff[1024]={0};
	int opt=1;
	int pid;
	//static int addrlen=sizeof(address);
	pthread_t thread[5];

	server_fd=socket(AF_INET,SOCK_STREAM, 0);

	address.sin_family=AF_INET;
	address.sin_addr.s_addr=INADDR_ANY;
	address.sin_port=htons(8080);
	bind(server_fd,(struct sockaddr*)&address,sizeof(address));

	int i=0;
	while(i<5){
		if(pthread_create(&thread[1],NULL,(void *)landing,NULL)<0)	printf("thread was unable to create");
		i++;
	}
	i=0;
	while(i<5){
		pthread_join(thread[i],NULL);
		i++;
	}
	return 0;
}

void landing(){
	int new_socket;
	listen(server_fd,3);
	char buff[1024]={0};

	new_socket=accept(server_fd,(struct sockaddr*)&address,(socklen_t*)&addrlen);

	//Authorize();

	int i=0;
	while(1){
		if(read(new_socket,buff,1024)==-1) break;
		printf("%d~",new_socket);
		fputs(buff,stdout);
		while(i<1024){
			buff[i]='\0';
			i++;
		}
		i=0;
	}
	close(new_socket);
}

void Authorize(int n_socket){
	FILE* fd=fopen("users.txt","a+");
	char arr[10]={0};
	if(fd==NULL){
		printf("fopen error\n");
		return;
	}
	if(read(n_socket,arr,10)==0){
		printf("read error\n");
		return;
	}
	switch (arr[strlen(arr)-2]){
	case '1':
		login();
		break;
	case '2':
		signup();
		break;
	default:
		printf("wrong option\n");
		break;
	}
}