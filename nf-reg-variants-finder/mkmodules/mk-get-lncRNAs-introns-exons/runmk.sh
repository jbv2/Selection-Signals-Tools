#!/bin/bash

find -L . \
  -type f \
  -name "*.fantomcat.*" \
  ! -name "*.introns_exons.tsv.gz" \
  ! -name "*GeneHancer*" \
| sed "s#.tsv.gz#.introns_exons.tsv#" \
| xargs mk
