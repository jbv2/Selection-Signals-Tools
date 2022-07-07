#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
# NONE
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create real-data/reults dir
mkdir -p test/results
echo "[>>.] results will be created in real-data/results"
## Execute runmk.sh, it will find the basic example in real-data/data
## Move results from test/data to test/results
## results files are *.png
bash runmk.sh \
&& mv test/data/*.png test/results/ \
&& echo "[>>>] Module Test Successful"
