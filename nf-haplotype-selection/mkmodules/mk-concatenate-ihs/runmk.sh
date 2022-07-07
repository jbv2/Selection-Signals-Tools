#!/usr/bin/env bash

## find every tsv file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.ihs.tsv" \
    -exec dirname {} \; \
  | sort -u \
  | sed "s#\$#/ihs_results.csv#" \
  | xargs mk
