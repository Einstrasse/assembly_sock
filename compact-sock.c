#include <sys/socket.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>

#define BUF_SIZE 255

char buf_get[BUF_SIZE];
char reverse[BUF_SIZE];
int len;

void rev() {
	for (int i=0; i < len; i++) {
		reverse[i] = buf_get[len-1-i];
	}
	reverse[len] = '\0';
}
int main() {
	int client_len;
	int client_sockfd;

	char buf_in[BUF_SIZE];

	struct sockaddr_in clientaddr;

	client_sockfd = socket(AF_INET, SOCK_STREAM, 0);
	clientaddr.sin_family = AF_INET;
	clientaddr.sin_addr.s_addr = inet_addr("13.124.75.20");
	clientaddr.sin_port = htons(1337);

	client_len = sizeof(clientaddr);

	if (connect(client_sockfd, (struct sockaddr *)&clientaddr, client_len) < 0) {
		perror("Connect ereror: ");
		exit(0);
	}

	read(client_sockfd, buf_get, 255);
	for (int i=0; i < 255; i++) {
		if (buf_get[i] == 0xa) {
			buf_get[i] = '\0';
			len = i;
			break;
		}
		//printf("[%03d] %x : %c\n", i, buf_get[i], buf_get[i]);
	}
	printf("%s\n", buf_get);
	rev();
	printf("%s\n", reverse);
	reverse[len] = 0xa;
	//write(client_sockfd, reverse, 255);
	write(client_sockfd, reverse, len);
	read(client_sockfd, buf_get, 255);
	for (int i=0; i < 255; i++) {
		if (buf_get[i] == 0xa) {
			buf_get[i] = '\0';
			len = i;
			break;
		}
		//printf("[%03d] %x : %c\n", i, buf_get[i], buf_get[i]);
	}
	printf("%s\n", buf_get);
}