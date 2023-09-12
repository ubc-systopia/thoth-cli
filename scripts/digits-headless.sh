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
wget https://scikit-learn.org/stable/_downloads/eb87d6211b2c0a7c2dc460a9e28b1f6a/plot_digits_classification.ipynb 
thoth --end-session "download-notebook" ""

# run the tutorial
thoth --start-session "run-notebook" "run irises tutorial workbook"
jupyter nbconvert --execute --to notebook --inplace plot_digits_classification.ipynb
thoth --end-session "run-notebook" ""


# clean-up (remove the repo, remove all files we made, move the provenance to another file maybe
# TODO
