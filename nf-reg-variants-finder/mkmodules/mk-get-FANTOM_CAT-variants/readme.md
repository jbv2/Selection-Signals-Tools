# mk-get-FANTOM_CAT-variants
**Author(s):** Judith Ballesteros-Villascán(judith.vballesteros@gmail.com)
**Date:** June 2021

---

## Module description:
Separate variants with a FANTOM-CAT lncRNA ID.

1. This module filters variants that match with annotations in "FANTOM-CAT_lncRNAID" field.

*Outputs will be uncompressed.

## Module Dependencies:
filter_vep >
[Download and compile filter_vep](https://www.ensembl.org/info/docs/tools/vep/script/vep_filter.html)

### Input(s):

 Uncompressed `VCF` file(s) with extension `.vcf`, which mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22	17163164	rs5748499	G	T	.	.	PR;NS=5991;AN=11982;AF=0.0918878;MAF=0.0918878;AC=1101;AC_Het=977;AC_Hom=124;AC_Hemi=0;HWE=0.0878632;ExcHet=0.965229;ANN=T|intron_variant&non_coding_transcript_variant|MODIFIER|KB-7G2.8|ENSG00000273244|Transcript|ENST00000423580.2|processed_transcript||4/6||||||||||-1||SNV|Clone_based_vega_gene||YES|Ensembl||||||||||||||||||||||||||||0.374633|0.0385893||ENSG00000100181.17&HBMT00000936357.1&ENSG00000100181.17&ENST00000558085.2|||||||||||||||||||||||||||||L=0.043371|-0.0004942522||-1.10000002384186|0.00600000005215406
```


### Output:

A `VCF` file by each input with the filtered variants with a FANTOM CAT lncRNA ID.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22	17163164	rs5748499	G	T	.	.	PR;NS=5991;AN=11982;AF=0.0918878;MAF=0.0918878;AC=1101;AC_Het=977;AC_Hom=124;AC_Hemi=0;HWE=0.0878632;ExcHet=0.965229;ANN=T|intron_variant&non_coding_transcript_variant|MODIFIER|KB-7G2.8|ENSG00000273244|Transcript|ENST00000423580.2|processed_transcript||4/6||||||||||-1||SNV|Clone_based_vega_gene||YES|Ensembl||||||||||||||||||||||||||||0.374633|0.0385893||ENSG00000100181.17&HBMT00000936357.1&ENSG00000100181.17&ENST00000558085.2|||||||||||||||||||||||||||||L=0.043371|-0.0004942522||-1.10000002384186|0.00600000005215406|
```

**Note(s):**
* Ouput and input will have the same structure, the only change to files is that the variants will be set according each filter.


## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-FANTOM_CAT-variants directory structure

````
mk-get-FANTOM_CAT-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
