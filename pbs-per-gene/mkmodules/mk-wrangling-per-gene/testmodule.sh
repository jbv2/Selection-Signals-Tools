#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
#NONE
###

echo "[>..] test running this module with data in real-data/data"
## Remove old test results, if any; then create real-data/reults dir
#rm -rf real-data/results
#mkdir -p real-data/results
echo "[>>.] results will be created in real-data/results"
## Execute runmk.sh, it will find the basic example in real-data/data
## Move results from test/data to test/results
## results files are *.csv
bash runmk.sh \
&& mv real-data/data/*.csv real-data/mxb_chb_ibs_derived \
&& echo "[>>>] Module Test Successful"
