#!/usr/bin/env bash

## find every vcf.gz file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.tsv" \
| sed "s#.tsv#.png#" \
| xargs mk
