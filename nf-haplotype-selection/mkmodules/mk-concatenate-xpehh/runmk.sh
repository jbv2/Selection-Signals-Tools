#!/usr/bin/env bash

## find every tsv file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.xpehh.tsv" \
    -exec dirname {} \; \
  | sort -u \
  | sed "s#\$#/xp_ehh_results.csv#" \
  | xargs mk
