# mk-calculate-pbs-per-element
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Calculate PBS per element from weighted Fst values from three population pairs by using calculate_element_pbs.R. 

## Module Dependencies:
* calculate_element_pbs.R: Is a tool that uses weighted Fst tables results to implement and apply a PBS function.
    
    * dplyr 
    * tidyr 

### Input(s):

A single `*.fst` file per pair of populations with all chromosomes Fst results.
Columns are: chromosome, start, end, element name, SNPs number and weighted Fst.

```
20      16236888        16248352        CATG00000055555.1       7       0.3587
21      16437368        16440572        AF127577.12     8       0.1119
22      30671217        30734078        BACH1-IT1       15      0.1771
```

### Outputs:

PBS results file with `*.tsv` extension.
Columns are: Chromosome, Start, End, Element, SNP number and PBS.
Filename is `target_ingroup_outgroup_pbs.tsv`.

```
Chromosome      Start   End     Element         SNP number      PBS
21      16236888        16248352        CATG00000055555.1       7       0
21      16437368        16440572        AF127577.12     8       0.010039
21      30671217        30734078        BACH1-IT1       15      0.987942
22      27610621        27620640        RP5-1172A22.1   5       0.010817
22      30993828        31002674        RP1-56J10.8     3       2.098515
22      41055598        41080925        CATG00000058689.1       12      0.685469
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

## mk-calculate-pbs-per-element  directory structure

````
mk-calculate-pbs-per-element  ## Module main directory
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