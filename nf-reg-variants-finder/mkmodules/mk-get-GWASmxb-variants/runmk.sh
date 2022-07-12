#!/bin/bash

find -L . \
  -type f \
  -name "*.vcf" \
  ! -name "*.GWASmxb*.vcf" \
| sed "s#.vcf#.GWASmxb.vcf#" \
| xargs mk
