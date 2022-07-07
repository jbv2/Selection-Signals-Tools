#!/bin/bash

find -L . \
  -type f \
  -name "*results.csv" \
  | sed "s#.csv#.png#" \
  | xargs mk
