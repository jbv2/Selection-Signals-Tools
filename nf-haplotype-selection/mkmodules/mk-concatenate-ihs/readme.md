# mk-concatenate-ihs
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Concatenate iHS chromosome results and get significant values (p < 0.01).

## Module Dependencies:
* get_significant.R: Is a tools that gets significant iHS results from rehh.

    * library("dplyr")

### Input(s):

* A `.tsv` file with iHS results.
Example line(s):
```
CHR     POSITION        IHS   LOGPVALUE       P       SNP
21      15372509        0.426589572749077       0.174133777524797       0.66967829386848        rs1297083
21      15389721        1.18810484525533        0.629316509295663       0.234792105675127       rs2822368
21      15395065        1.09073517455622        0.560052735544199       0.275389428294492       rs28660336
```

* A `.outliers.tsv` file with the outliers per chromosome.
```
CHR     START   END     N_MRK   MEAN_MRK        MAX_MRK N_EXTR_MRK      PERC_EXTR_MRK   MEAN_EXTR_MRK
21      15200000        16400000        327     0.411254074814345       3.58598049880508        2       0.61    3.39871554251692
21      17100000        1.9e+07 413     0.440766827496504       3.51589002207843        3       0.73    3.37170032051318
```

### Outputs:

* A `.csv` file with iHS results with all chromosomes.
Example line(s):
```
CHR     POSITION        IHS   LOGPVALUE       P       SNP
21      15372509        0.426589572749077       0.174133777524797       0.66967829386848        rs1297083
22      15389721        1.18810484525533        0.629316509295663       0.234792105675127       rs2822368
```

* A `.outliers.csv` file with the outliers with all chromosomes.

* A `*top1.bed` file with iHS values according threshold. Columns are chromosome, start, end, iHS.

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-concatenate-ihs directory structure

````
mk-concatenate-ihs  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data

````
## References
* Wickham H, François R, Henry L, Müller K (2022). _dplyr: A
  Grammar of Data Manipulation_. R package version 1.0.9,
  <https://CRAN.R-project.org/package=dplyr>.
