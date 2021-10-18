#!/bin/bash

find -L . \
  -type f \
  -name "*_chrom*.vcf.gz" \
  | sed "s#_chrom[0-9]*.vcf.gz#.ihs.tsv#" \
  | sort -u \
  | xargs mk
