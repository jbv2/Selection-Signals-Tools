#!/usr/bin/env bash

# find all the *.log* files in this directory
# change name of the finded files
# ask a .csv output

find -L . \
  -type f \
  -name "*.csv" \
    -exec dirname {} \; \
  | sort -u \
  | sed "s#\$#/pbs_results.tsv#" \
  | xargs mk
