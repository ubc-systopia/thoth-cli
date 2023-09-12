#!/bin/bash
# SPDX-License-Identifier: MIT
# 
# Author: Nichole Boufford <nichole.boufford@oracle.com>
# 
# Copyright (c) 2023, Oracle and/or its affiliates.
# 
# Licensed under the MIT License, see LICENSE file for details.

# Look at Tribuo tutorial for required installations prior to running this script

workingdir="/local/thoth-tests"

# setup (create workspace repo, ask thoth to track it)
if [ ! -d $workingdir/test ]; then
	mkdir -p $workingdir/test;
fi;

thoth --track-dir $workingdir/test

cd $workingdir/test

# start by cloning and checking out the git repo
thoth --start-session "clone-repo" "clone the tutorial repo"
git clone https://github.com/oracle/tribuo.git
thoth --end-session "clone-repo" "finished cloning repo"

cd tribuo
thoth --start-session "checkout-tag" "checkout branch and release tag"
git checkout tags/v4.3.0 -b v4.3.X-release-branch
thoth --end-session "checkout-tag" ""

# build the tribuo jars
thoth --start-session "download-jars" "download necessary jar files"
mvn clean package
thoth --end-session "download-jars" "download necessary jar files"

# copy jars to tutorial
thoth --start-session "copy-jars" "copy jar files to tutorial"
cp Classification/Experiments/target/tribuo-classification-experiments-4.3.0-jar-with-dependencies.jar tutorials
cp Json/target/tribuo-json-4.3.0-jar-with-dependencies.jar tutorials
thoth --end-session "copy-jars" ""

# move to tutorial directory
cd tutorials

# download the dataset
thoth --start-session "download-dataset" "download irises dataset"
wget https://archive.ics.uci.edu/ml/machine-learning-databases/iris/bezdekIris.data
thoth --end-session "download-dataset" ""

# run the tutorial
# run a notebook server and access the server through forwarded port
# user will have to open the notebook in a browser and run through the tutorial
thoth --start-session "run-notebook" "run irises tutorial workbook"
jupyter notebook --port 9999
thoth --end-session "run-notebook" ""


# clean-up (remove the repo, remove all files we made, move the provenance to another file maybe
