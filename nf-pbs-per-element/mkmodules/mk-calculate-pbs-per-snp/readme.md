# mk-calculate-pbs-per-snp
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Calculate PBS per SNP from Fst values from three population pairs by using calculate_snp_pbs.R. 

## Module Dependencies:
* calculate_snp_pbs.R: Is a tool that uses Fst tables results to implement and apply a PBS function.
    
    * dplyr 
    * tidyr 

### Input(s):

* `*.fst` files per pair of populations per chromosome.
Columns are: CHROM	POS	WEIR_AND_COCKERHAM_FST.

```
CHROM   POS     WEIR_AND_COCKERHAM_FST
21      9865271 1
21      9890320 -nan
21      10970008        0.0403153
21      10979896        0.0576869
21      14561933        0.939762
21      14600884        1
21      14667454        0.076063
```

### Outputs:

PBS results file with `*.bed` extension.
Columns are: Chromosome, Start, End, and PBS.

Filename is `target_ingroup_outgroup_snp_pbs.bed`.

```
21      9890319         9890320         0
21      10970007        10970008        0
21      10979895        10979896        0.016122
21      14604376        14604377        0.004804
21      14617035        14617036        0
```
* A bed file with the top 1% of PBS values.

## Module parameters:
Names of populations.
POP_1="mxb"
POP_2="chb"
POP_3="ibs"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-calculate-pbs-per-snp  directory structure

````
mk-calculate-pbs-per-snp  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data
````

## References
*   R Core Team (2020). R: A language and environment
  for statistical computing. R Foundation for
  Statistical Computing, Vienna, Austria. URL
  https://www.R-project.org/.
* Wickham H, François R, Henry L, Müller K (2022). _dplyr: A Grammar of Data
  Manipulation_. R package version 1.0.9,
  <https://CRAN.R-project.org/package=dplyr>.
* Wickham H, Girlich M (2022). _tidyr: Tidy Messy Data_. R package version
  1.2.0, <https://CRAN.R-project.org/package=tidyr>.