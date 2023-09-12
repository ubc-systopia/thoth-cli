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

thoth --track-dir $workingdir/test

cd $workingdir/test

# download the dataset
thoth --start-session "download-notebook" "download digit classification notebook"
wget https://pytorch.org/tutorials/_downloads/91d72708edab956d7293bb263e2ab53f/optimization_tutorial.ipynb 
thoth --end-session "download-notebook" ""

# run the tutorial
thoth --start-session "run-notebook" "run irises tutorial workbook"
jupyter nbconvert --execute --to notebook --inplace optimization_tutorial.ipynb
thoth --end-session "run-notebook" ""


# clean-up (remove the repo, remove all files we made, move the provenance to another file maybe
# TODO
