#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export REF_GENE="test/reference/test_fantom.tsv"
export POP_1="mx_chb"
export POP_2="mx_pel"
export POP_3="pel_chb"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.tsv
bash runmk.sh \
&& mv test/data/*.tsv test/results \
&& echo "[>>>] Module Test Successful"
