#!/bin/bash

find -L . \
  -type f \
  -name "*.subsampled*.vcf" \
| sed "s#.subsampled.*.vep.vcf#.anno_vep.vcf#" \
| sort -u \
| sed "s#.vcf#.vcf#" \
| xargs mk
