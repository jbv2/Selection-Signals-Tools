#!/bin/bash

find -L . \
  -type f \
  -name "*.wfst" \
  -exec dirname {} \; \
| sort -u \
| sed "s#\$#.CHECKPOINT.tmp#" \
| xargs mk
