# mk-get-fst-for-ingroup_outgroup-elements
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** June 2022

---

## Module description:
Calculate weighted Fst from an interval of the length of an element (gene, enhancer, promoter) between a pair of populations.

The base of this module can use any pair of populations, just named for automatisation.

## Module Dependencies:
VCFtools (0.1.16) > [Download and compile vcftools](https://vcftools.github.io/examples.html)

### Input(s):

* A VCF file with a .vcf extension. A VCF file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eight mandatory columns CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO.

For more information about the VCF format, please go to the following link: Variant Call Format.

Example line(s):
```
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3
chr1	778597	rs74512038	C	T	6290.29	PASS	BaseQRankSum=-1.05;ClippingRankSum=0;ExcessHet=2.3451;FS=10.853;InbreedingCoeff=0.0097;MQ=69.78;MQRankSum=0;POSITIVE_TRAIN_SITE;QD=15.12;ReadPosRankSum=-0.678;SOR=0.306;VQSLOD=9.88;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=713977;GRCH37_REF=C;GRCH37_38_REF_STRING_MATCH;DP=18077;AF=0.0825688;MLEAC=17;MLEAF=0.109;EAS_AF=0.2083;AMR_AF=0.0648;AFR_AF=0.0098;EUR_AF=0.003;SAS_AF=0.0297;AN=160;AC=17	GT:AD:DP:GQ:PL	0/0:32,0:32:90:0,90,1350	0/0:36,0:36:99:0,99,1406	0/0:17,0:17:51:0,51,534
chr1	779047	rs12028261	G	A	61525.2	PASS	BaseQRankSum=0.697;ClippingRankSum=0;ExcessHet=0.7322;FS=0;InbreedingCoeff=0.1074;MQ=66.21;MQRankSum=-0.174;POSITIVE_TRAIN_SITE;QD=30.78;ReadPosRankSum=0.23;SOR=0.686;VQSLOD=4.48;culprit=MQRankSum;NS=2504;AA=.|||;VT=SNP;GRCH37_POS=714427;GRCH37_REF=G;GRCH37_38_REF_STRING_MATCH;DP=15427;AF=0.795872;MLEAC=139;MLEAF=0.891;EAS_AF=0.7917;AMR_AF=0.8718;AFR_AF=0.4546;EUR_AF=0.9493;SAS_AF=0.9315;AN=160;AC=142	GT:AD:DP:GQ:PGT:PID:PL	1/1:0,17:17:51:.:.:580,51,0	1/1:0,27:27:81:.:.:923,81,0	1/1:0,17:17:51:.:.:601,51,0
```

* A bed like input with the coordinates of the element to calculate Fst.

The file must have columns: Chromosome, start end, and name elements.

Example line(s):
```
21      16236888        16248352        CATG00000055555.1
21      16437368        16440572        AF127577.12
21      30671217        30734078        BACH1-IT1
22      27610621        27620640        RP5-1172A22.1
22      30993828        31002674        RP1-56J10.8
22      41055598        41080925        CATG00000058689.1
22      41807132        41809946        CATG00000058714.1
```

* Files with samples name per population. One sample per line.
Example line(s):
```
Sample1
Sample2
Sample3
```


### Outputs:

* A `*.weighted` file separated by TABs.
Columns are: chromosome, start, end, element name, SNPs number and weighted Fst.
```
21      16236888        16248352        CATG00000055555.1       7       0.3587
21      16437368        16440572        AF127577.12     8       0.1119
21      30671217        30734078        BACH1-IT1       15      0.1771
```

* `*.log` files that contain the standard output.

* `*.weir.fst` files that have Fst per SNP in the given interval.

## Module parameters:
REF_GENE="test/reference/fantom_test.bed"
POP_INGROUP="test/reference/chb.pop"
POP_OUTGROUP="test/reference/ibs.pop"
POP_2="chb"
POP_3="ibs"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-fst-for-ingroup_outgroup-elements

````
mk-get-fst-for-ingroup_outgroup-elements  ## Module main directory
├── mkfile  ## File in mk format, specifying the rules for building every result
├── readme.md ## This document. General workflow description.
├── runmk.sh  ## Script to print every file required by this module
├── test  ## Test directory
└── testmodule.sh ## Script to test module functunality using test data

````
## References
* The Variant Call Format and VCFtools, Petr Danecek, Adam Auton, Goncalo Abecasis, Cornelis A. Albers, Eric Banks, Mark A. DePristo, Robert Handsaker, Gerton Lunter, Gabor Marth, Stephen T. Sherry, Gilean McVean, Richard Durbin and 1000 Genomes Project Analysis Group, Bioinformatics, 2011