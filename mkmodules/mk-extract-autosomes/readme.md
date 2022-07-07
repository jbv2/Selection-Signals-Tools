# mk-extract-autosomes
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Split autosomes from a single VCF into separate files, filtering by keeping just SNPs, by min_af and missing genotypes.

## Module Dependencies:
bcftools 1.11 > [Download and compile bcftools](https://samtools.github.io/bcftools/howtos/install.html)

### Input(s):

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

VCF must be phased.

Also, it requires the index file with extension `.tbi`

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)

Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3
21      9411773 rs867796868     C       T       .       PASS    AC=0;AN=182     GT      0|0     0|0     0|0     0|0
21      10979896        rs117219976     A       G       .       PASS    AC=1;AN=182     GT      0|1     0|0     0|0
22      17176028        rs2845365       T       G       .       PASS    AC=58;AN=182    GT      1|0     0|0     0|1 
```

### Outputs:

* 22 `_chrom*.vcf.gz` files.

## Module parameters:
MIN_AF="0" # Min allele frequency
GENO="0.001" #Min Fraction of missing genotypes
MIN_ALLELES="0" #To keep SNPs
MAX_ALLELES="100" #To keep SNPs

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-extract-autosomes directory structure

````
mk-extract-autosomes  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data

````
## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
