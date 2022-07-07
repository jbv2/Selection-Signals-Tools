#!/bin/bash

find -L . \
  -type f \
  -name "*_chrom*.vcf.gz" \
  | sed "s#.vcf.gz#.ihs.tsv#" \
  | xargs mk
