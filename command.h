#ifndef __COMMAND_H
#define __COMMAND_H

#define NUM_ARGS 5
#define ARG_LEN 50
#define MSG_LEN 150

#define ARG_TRACK_DIR     "--track-dir"
#define ARG_REMOVE_DIR    "--remove-dir"

enum cli_op {
	ADD_DIR = 0,
	RM_DIR  = 1,
};

enum cli_err {
	ERR_OK = 0,
};

struct op_msg {
	enum cli_op op;
	char arg[NUM_ARGS][ARG_LEN];
};

struct err_msg {
	enum cli_err err;
	char msg[MSG_LEN];
};

#endif