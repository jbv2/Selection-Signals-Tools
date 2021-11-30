#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export REF_GENE="real-data/reference/mart_export_hg19.txt"
export POP_1="mx_chb"
export POP_2="mx_ibs"
export POP_3="ibs_chb"
###

echo "[>..] test running this module with data in real-data/data"
## Remove old test results, if any; then create real-data/reults dir
rm -rf real-data/results
mkdir -p real-data/results
echo "[>>.] results will be created in real-data/results"
## Execute runmk.sh, it will find the basic example in real-data/data
## Move results from test/data to test/results
## results files are *.tsv
bash runmk.sh \
&& mv real-data/data/*.tsv real-data/results \
&& echo "[>>>] Module Test Successful"
