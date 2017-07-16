#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUF_SIZE 255
int main() {
	int client_len;
	int client_sockfd;

	char buf_in[BUF_SIZE];
	char buf_get[BUF_SIZE];

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
	printf("%s", buf_get);
}