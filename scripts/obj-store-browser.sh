#!/bin/bash
# SPDX-License-Identifier: MIT
# 
# Author: Nichole Boufford <nichole.boufford@oracle.com>
# 
# Copyright (c) 2023, Oracle and/or its affiliates.
# 
# Licensed under the MIT License, see LICENSE file for details.

workingdir="/local/thoth-tests"

# setup (create workspace repo, ask thoth to track it)
if [ ! -d $workingdir/test ]; then
	mkdir -p $workingdir/test;
fi;

# copy notebook to tracking dir
cp $workingdir/workspace/thoth-cli/notebooks/object-storage-test.ipynb $workingdir/test

thoth --track-dir $workingdir/test

cd $workingdir/test

# run the notebook
thoth --start-session "run-notebook" "run object storage test notebook"
jupyter notebook --port 9999
thoth --end-session "run-notebook" ""


# clean-up (remove the repo, remove all files we made, move the provenance to another file maybe
# TODO
