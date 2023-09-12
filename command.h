/**********************************************************************************************************
 *
 * MIT License
 * 
 * Copyright (c) 2023 Systopia Lab, Computer Science, University of British Columbia
 * Copyright (c) 2023, Oracle and/or its affiliates.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 ***********************************************************************************************************/

#ifndef __COMMAND_H
#define __COMMAND_H

#define NUM_ARGS 5
#define ARG_LEN 256
#define MSG_LEN 150

#define ARG_TRACK_DIR      "--track-dir"
#define ARG_REMOVE_DIR     "--remove-dir"
#define ARG_LOG_OUTPUT	   "--output"
#define ARG_SESSION_START  "--start-session"
#define ARG_SESSION_END	   "--end-session"

enum cli_op {
	ADD_DIR = 0,
	RM_DIR  = 1,
	SESSION_START = 2,
	SESSION_END = 3
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
