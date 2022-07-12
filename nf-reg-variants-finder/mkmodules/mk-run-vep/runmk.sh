#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.untangled_multiallelics.vcf" \
| sed 's#.untangled_multiallelics.vcf#.vep.vcf#' \
| xargs mk
