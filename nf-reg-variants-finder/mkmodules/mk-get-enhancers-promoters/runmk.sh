#!/bin/bash

find -L . \
  -type f \
  -name "*.GeneHancer.*" \
  ! -name "*.enhancers.tsv" \
| sed "s#.tsv.gz#.enhancers.tsv#" \
| xargs mk
