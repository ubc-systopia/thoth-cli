#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netinet/in.h>
#include <netdb.h>
#include <syslog.h>

#include "command.h"

#define CLI_PORT 5001
#define HOSTNAME_MAX 64

#define MATCH_ARGS(str1, str2) if (strcmp(str1, str2) == 0)
#define CHECK_ATTR(argc, min) if (argc < min) { exit(-1); }

int write_to_server(struct op_msg msg)
{
	int sockfd;
	struct sockaddr_in server_addr;
	char hostname[HOSTNAME_MAX];

	gethostname(hostname, HOSTNAME_MAX);
	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0) {
		perror("error opening socket");
		return -1;
	}

	bzero((char *) &server_addr, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	struct hostent *hptr = gethostbyname(hostname);

	if (hptr == NULL) {
		perror("hostname error");
		return -1;
	}

	bcopy((char *)hptr->h_addr, (char *)&server_addr.sin_addr.s_addr, hptr->h_length);
	server_addr.sin_port = htons(CLI_PORT);

	syslog(LOG_INFO, "thoth-cli: connecting to host: %s, port: %d\r\n", hostname, server_addr.sin_port);

	if (connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0)
		perror("error connecting to server");

	write(sockfd, &msg, sizeof(msg));
	syslog(LOG_INFO, "thoth-cli: writing message to socket: %s\r\n", msg.arg[0]);

	struct err_msg response;
	int n = read(sockfd, &response, sizeof(response));

	if (n < 0)
		perror("error: no response from server");

	// print server response
	printf("%s\r\n", response.msg);

	close(sockfd);
	return 0;
}

int add_dir(char *arg)
{
	// format and write to server
	struct op_msg msg = {
		.op = ADD_DIR,
	};

	snprintf(msg.arg[0], ARG_LEN, "%s", arg);
	write_to_server(msg);
	return 0;
}

int remove_dir(char *arg)
{
	// format and write to server
	struct op_msg msg = {
		.op = RM_DIR,
	};

	snprintf(msg.arg[0], ARG_LEN, "%s", arg);
	write_to_server(msg);
	return 0;
}

int main(int argc, char *argv[])
{
	CHECK_ATTR(argc, 2);

	MATCH_ARGS(argv[1], ARG_TRACK_DIR) {
		CHECK_ATTR(argc, 3);
		add_dir(argv[2]);
		return 0;
	}

	MATCH_ARGS(argv[1], ARG_REMOVE_DIR) {
		CHECK_ATTR(argc, 3);
		remove_dir(argv[2]);
		return 0;
	}

	printf("Command not found!\r\n");

	return 0;
}