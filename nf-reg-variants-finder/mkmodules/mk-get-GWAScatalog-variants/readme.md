# mk-get-GWAScatalog-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants with an association study reported in GWAS Catalog.

1. This module filters variants that match with annotations in "gwascatalog" field.

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
chr21	5216481	rs1265942733	T	A	.	PASS	AC=72;AF_mx=0.481;AN=150;DP=1398;nhomalt_mx=0;ANN=A|intergenic_variant|MODIFIER|||||||||||||||rs1265942733||||SNV|||||||||||||||||chr21:g.5216481T>A||||||||||||||||||||||||||||8.338|0.617038||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
chr21	5219334	rs1438890044	AT	A	.	PASS	AC=59;AF_mx=0.396;AN=150;DP=2302;nhomalt_mx=0;ANN=-|intergenic_variant|MODIFIER|||||||||||||||rs1438890044||||deletion|||||||||||||||||chr21:g.5219335del||||||||||||||||||||||||||||3.288|0.152540||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
```


### Output:

A `VCF` file by each input with the filtered variants reported in GWAS Catalog.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	13425916	rs466850	G	C	.	PASS	AC=86;AF_mx=0.571;AN=152;DP=1474;nhomalt_mx=29;ANN=C|intron_variant&non_coding_transcript_variant|MODIFIER|ANKRD30BP1|ENSG00000175302|Transcript|ENST00000451052.1|unprocessed_pseudogene||4/17|ENST00000451052.1:n.204+230C>G|||||||rs466850||-1||SNV|HGNC|HGNC:19722|YES||||||||||||||chr21:g.13425916G>C|0.2750|0.0651|0.4841|0.3452|0.3459|0.2648||||||||||||0.4841|AMR|||1||||||1.441|-0.036760||rs466850|7830|31324|0.249968|641245|37|104|0.355769|7|7868|31416|0.250446|1179|740|8704|0.0850184|26|733|2132|0.343809|120|387|848|0.456368|85|544|1550|0.350968|90|1165|2940|8578|0.342737|499|1151|4566|0.252081|163|4861|15380|0.31606|789|850|3468|0.245098|103|123|290|0.424138|20|325|1084|0.299815|52|amr|387|848|0.456368|85|31.31|rs466850|Lower_body_strength|822_European_ancestry_individuals|NA|rs466850-C|3e-06|GCST004493||||||||||||
chr21	13901423	rs56254584	C	G	.	PASS	AC=13;AF_mx=0.09;AN=152;DP=1540;nhomalt_mx=1;ANN=G|downstream_gene_variant|MODIFIER|SNX18P13|ENSG00000230965|Transcript|ENST00000412442.1|processed_pseudogene||||||||||rs56254584|4537|-1||SNV|HGNC|HGNC:39621|YES||||||||||||||chr21:g.13901423C>G|0.3179|0.1649|0.2723|0.369|0.3767|0.4438||||||||||||0.4438|SAS|||1||||||0.816|-0.134607||rs56254584|10097|31124|0.324412|590589|40|104|0.384615|9|10196|31416|0.324548|1745|1837|8608|0.213406|203|811|2122|0.382187|162|204|846|0.241135|25|544|1536|0.354167|95|1714|3208|8524|0.376349|590|1624|4546|0.357237|291|5683|15296|0.371535|1052|1347|3470|0.388184|249|98|288|0.340278|18|384|1080|0.355556|72|nfe|5683|15296|0.371535|1052|27.41|rs56254584|Interleukin-2_levels|475_Finnish_ancestry_individuals|NA|rs56254584-G|5e-06|GCST004455||||||||||||

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

## mk-get-GWAScatalog-variants directory structure

````
mk-get-GWAScatalog-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.