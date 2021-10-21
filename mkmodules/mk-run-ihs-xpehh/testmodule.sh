#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
export FIRST_POP="MXB"
export SECOND_POP="PEL"
export STEM_INGROUP="PEL.chr"
export END_FILE_INGROUP=".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.vcf
./runmk.sh \
&& mv test/data/*.tsv test/results \
&& echo "[>>>] Module Test Successful"
