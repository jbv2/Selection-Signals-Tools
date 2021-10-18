#!/usr/bin/env bash

## find every vcf.gz file
#find: -L option to include symlinks
find -L test/data \
  -type f \
  -name "*.vcf.gz" \
  ! -name "test_1000g*" \
  ! -name "*chrom*" \
| sed 's#.vcf.gz#.CHECKPOINT.tmp#' \
| xargs mk
