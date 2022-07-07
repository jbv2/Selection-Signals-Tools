#!/usr/bin/env bash

## find every .fst file
#find: -L option to include symlinks

find -L . \
  -type f \
  -name "*.fst" \
  -exec dirname {} \; \
| sort -u \
| sed "s#\$#.CHECKPOINT.tmp#" \
| xargs mk
