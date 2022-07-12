# mk-get-GeneHancer-variants
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Separate variants with a GeneHancer ID.

1. This module filters variants that match with annotations in "GeneHancer type and genes" field.

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

A `VCF` file by each input with the filtered variants with a GeneHancer ID.

```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	13979932	rs56270809	A	C	.	PASS	AC=52;AF_mx=0.346;AN=152;DP=1497;nhomalt_mx=9;ANN=C|non_coding_transcript_exon_variant|MODIFIER|ANKRD20A11P|ENSG00000215559|Transcript|ENST00000344693.5|processed_transcript|1/6||ENST00000344693.5:n.506T>G||506/1088|||||rs56270809||-1||SNV|HGNC|HGNC:42024|YES|1|||||||||||||chr21:g.13979932A>C|0.2216|0.1339|0.353|0.1042|0.2455|0.3436||||||||||||0.353|AMR||||19325872&19958531|||||6.837|0.446882|GH21J013979_Promoter/Enhancer_ANKRD20A11P|rs56270809|6905|31170|0.221527|617340|30|106|0.283019|7|6978|31416|0.222116|865|1413|8650|0.163353|129|576|2126|0.270931|87|292|846|0.345154|43|121|1548|0.0781654|5|849|2353|8550|0.275205|336|1028|4520|0.227434|111|3987|15302|0.260554|541|738|3460|0.213295|77|97|290|0.334483|16|257|1074|0.239292|38|amr|292|846|0.345154|43|29.33|||||||||||||||||||
chr21	13979992	rs2297245	C	G	.	PASS	AC=21;AF_mx=0.135;AN=152;DP=710;nhomalt_mx=1;ANN=G|non_coding_transcript_exon_variant|MODIFIER|ANKRD20A11P|ENSG00000215559|Transcript|ENST00000344693.5|processed_transcript|1/6||ENST00000344693.5:n.446G>C||446/1088|||||rs2297245||-1||SNV|HGNC|HGNC:42024|YES|1|||||||||||||chr21:g.13979992C>G|0.0148|0|0.0663|0.0278|0|0||||||||||||0.0663|AMR|||||||||6.277|0.389974|GH21J013979_Promoter/Enhancer_ANKRD20A11P|rs2297245|137|31308|0.00437588|601203|0|106|0|0|139|31416|0.0044245|3|8|8666|0.000923148|0|1|2134|0.000468604|0|59|844|0.0699052|1|61|1556|0.0392031|2|3|1|8586|0.000116469|0|0|4574|0|0|2|15400|0.00012987|0|0|3472|0|0|0|288|0|0|7|1082|0.0064695|0|amr|59|844|0.0699052|1|27.14|||||||||||||||||||
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

## mk-get-GeneHancer-variants directory structure

````
mk-get-GeneHancer-variants /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
