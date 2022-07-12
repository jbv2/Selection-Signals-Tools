#!/bin/bash

## This small script runs a module test with the sample data

## Export variables
export FANTOM_REFERENCE="test/reference/FANTOM_CAT.lv4.only_lncRNA_samplechr22.bed.gz"

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data ; -a arg forces target creation even if results are up to date
## Move results from . to test/results
./runmk.sh \
&& mv test/data/*.introns_exons.tsv test/data/*.summary.tsv test/data/*lncRNA.tsv test/results \
&& echo "[>>>] Module Test Successful"
