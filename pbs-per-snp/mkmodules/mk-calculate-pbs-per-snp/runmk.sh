#!/usr/bin/env bash

# find all the *.log* files in this directory
# change name of the finded files
# ask a .csv output

find -L . \
  -type f \
  -name "*.fst" \
    -exec dirname {} \; \
  | sort -u \
  | sed "s#\$#/snp_pbs_results.tsv#" \
  | xargs mk
