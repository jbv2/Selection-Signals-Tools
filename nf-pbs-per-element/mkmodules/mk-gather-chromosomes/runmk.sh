#!/bin/bash

find -L . \
  -type f \
  -name "*.weighted" \
 | sed "s#.[0-9].*#.wfst#" \
 | sort -u \
 | xargs mk
