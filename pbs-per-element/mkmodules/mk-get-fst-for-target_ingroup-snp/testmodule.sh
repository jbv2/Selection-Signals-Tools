#!/usr/bin/env bash
## This small script runs a module test with the sample data

## environment variable setting
export POP_TARGET="test/reference/mxb.pop"
export POP_INGROUP="test/reference/chb.pop"
export POP_2="chb"
export POP_1="mxb"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.weighted
bash runmk.sh \
&& mv test/data/*.log test/data/*.fst test/results/ \
&& echo "[>>>] Module Test Successful"
