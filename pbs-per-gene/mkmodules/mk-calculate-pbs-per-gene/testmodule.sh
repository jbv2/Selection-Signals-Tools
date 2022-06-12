#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export REF_GENE="real-data/reference/genehancer_export.tsv"
export POP_2="mxb_chb"
export POP_1="mxb_ibs"
export POP_3="chb_ibs"
###

echo "[>..] test running this module with data in real-data/data"
## Remove old test results, if any; then create real-data/reults dir
##mkdir -p real-data/results
echo "[>>.] results will be created in real-data/results"
## Execute runmk.sh, it will find the basic example in real-data/data
## Move results from test/data to test/results
## results files are *.tsv
bash runmk.sh \
&& mv real-data/data/*.tsv real-data/results/mxb_chb_ibs_derived.tsv \
&& echo "[>>>] Module Test Successful"
