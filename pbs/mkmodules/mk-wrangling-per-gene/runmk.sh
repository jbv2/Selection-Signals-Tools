#!/usr/bin/env bash

# find all the *.log* files in this directory
# change name of the finded files
# ask a .csv output
filename=$(find -L . \
  -type f \
  -name "*.weir.fst" \
| sed -re 's#([a-z]|[a-z].[0-9])*weir.fst#csv#' \
| awk 'BEGIN{FS=OFS="."}{print $(NF-1),$NF}' \
| sort -u) #\
#| xargs mk

dirname=$(find -L . \
  -type f \
  -name "*.weir.fst" \
    -exec dirname {} \; \
  | sort -u) #\


for file in $filename; do
  mk $dirname/$file
done
