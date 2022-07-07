# mk-gather-chromosomes 
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Gather Fst results per chromosome into a single Table per pair of populations. 

## Module Dependencies:
NONE

### Input(s):

* A `*.weighted` file separated by TABs.
Columns are: chromosome, start, end, element name, SNPs number and weighted Fst.
```
21      16236888        16248352        CATG00000055555.1       7       0.3587
21      16437368        16440572        AF127577.12     8       0.1119
21      30671217        30734078        BACH1-IT1       15      0.1771
```

### Outputs:

A single file per pair of populations with all chromosomes Fst results.
Columns are: chromosome, start, end, element name, SNPs number and weighted Fst.

```
20      16236888        16248352        CATG00000055555.1       7       0.3587
21      16437368        16440572        AF127577.12     8       0.1119
22      30671217        30734078        BACH1-IT1       15      0.1771
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-gather-chromosomes  directory structure

````
mk-gather-chromosomes  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data
````
