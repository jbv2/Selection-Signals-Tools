# mk-run-ihs
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Takes a phased VCF and uses rehh 3.2.2 to calculate iHS.

## Module Dependencies:

* mxb_selection_ihs.R: Is a tool that computes iHS using rehh. 
  * library(rehh) # 3.2.2
  * library("vcfR") ## For reading VCFs
  * library("R.utils") ## For reading compressed VCFs
  * library("dplyr")

### Input(s):

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`.

VCF must be phased and with ancestral allele annotated.

Also, it requires the index file with extension `.tbi`

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)

Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3
21      9511576 rs866642407     A       C       .       PASS    AA=A;AC=8;AN=2196;F_MISSING=0;AF=0.00364299     GT      0|0     0|0     0|0
21      14771793        rs77585460      A       C       .       PASS    AA=A;AC=8;AN=2196;F_MISSING=0;AF=0.00364299     GT      0|0     0|0     1|0
```

### Outputs:

* A `.tsv` file with XP-EHH results. 
Example line(s):
```
CHR     POSITION        IHS     LOGPVALUE       P       SNP
21      15372509        0.490390355126174       0.204914460023903       0.623857700312383       rs1297083
21      15389721        0.0411165089180707      0.0144823590116899      0.967203013519261       rs2822368
21      15395065        0.0396859822194928      0.0139705684162015      0.968343477441603       rs28660336
```

* A `.outliers.tsv` file with the outliers per chromosome.
```
CHR     START   END     N_MRK   MEAN_MRK        MAX_MRK N_EXTR_MRK      PERC_EXTR_MRK   MEAN_EXTR_MRK
21      15200000        16400000        327     0.411254074814345       3.58598049880508        2       0.61    3.39871554251692
21      17100000        1.9e+07 413     0.440766827496504       3.51589002207843        3       0.73    3.37170032051318
```

## Module parameters:
THREADS=2

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-run-ihs directory structure

````
mk-run-ihs  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data

````
## References
* Gautier M, Klassmann A, Vitalis R (2017). “rehh 2.0: a reimplementation of the R package rehh to detect positive selection from haplotype structure.” Molecular Ecology Resources, 17(1), 78-90. doi: 10.1111/1755-0998.12634.
* Knaus BJ, Grünwald NJ (2017). “VCFR: a package to manipulate
  and visualize variant call format data in R.” _Molecular
  Ecology Resources_, *17*(1), 44-53. ISSN 757,
  <http://dx.doi.org/10.1111/1755-0998.12549>.
* Bengtsson H (2022). _R.utils: Various Programming Utilities_.
  R package version 2.12.0,
  <https://CRAN.R-project.org/package=R.utils>.
* Wickham H, François R, Henry L, Müller K (2022). _dplyr: A
  Grammar of Data Manipulation_. R package version 1.0.9,
  <https://CRAN.R-project.org/package=dplyr>.
