# mk-run-vep
**Author(s):** Judith Ballesteros-Villascán (judith.vballesteros@gmail.com)  
**Date:** June 2021

Based on VEP-extended: https://github.com/Iaguilaror/nf-VEPextended
---

## Module description:
Annotate variants with Variant Effector Predictor tool (VEP).
For more information about, see [VEP](https://www.ensembl.org/info/docs/tools/vep/index.html)

---

## Module Dependencies:
* ensembl-vep 104 >
[Download and compile vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html)

---

### Input:

A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. Changes will be done in ID column.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
##INFO=<ID=AF_mx,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed">
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   30000353        rs5763691       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
chr22   30000507        rs117064489     A       G       .       PASS    AC=1;AF_mx=0.006494;AN=150;DP=572;nhomalt_mx=0
...
```

---

### Output:

`VCF` files with only variants of each chromosome of the input.

Example line(s):  

```
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22	35777618	rs2071748	G	A	.	.	PR;NS=6006;AN=12012;AF=0.187979;MAF=0.187979;AC=2258;AC_Het=1796;AC_Hom=462;AC_Hemi=0;HWE=0.117718;ExcHet=0.948145;ANN=A|intron_variant|MODIFIER|HMOX1|ENSG00000100292|Transcript|ENST00000216117.8|protein_coding||1/4|ENST00000216117.8:c.23+429G>A|||||||rs2071748||1||SNV|HGNC|5013|YES|Ensembl|1||chr22:g.35777618G>A|0.4906|0.6407|0.2911|0.4891|0.3817|0.5429|0.6407|AFR|||1|||||||||||1.07283|0.182115|Promoter/Enhancer%3Bgenehancer_id=GH22J035376%3Bconnected_gene=HMOX1%3Bscore=264.64%3Bconnected_gene=NONHSAG033802.2%3Bscore=250.67%3Bconnected_gene=HMGXB4%3Bscore=32.45%3Bconnected_gene=MCM5%3Bscore=23.26%3Bconnected_gene=TOM1%3Bscore=13.67%3Bconnected_gene=APOL6%3Bscore=7.04%3Bconnected_gene=ENSG00000282041%3Bscore=0.67%3Bconnected_gene=AB905429%3Bscore=0.67||||||||||rs2071748||HMOX1|HMOX1|3e-06|5.52287874528034|0.05|815_Hispanic_children_from_263_families|23251661||||||||||||0.074934|2.27042|0.9993611|-3.42499995231628|0
...
```

**Note(s):**
Please observe that the flags were annotated in new columns.

---

## Temporary files:
NONE

---


## Module parameters:
Path to the directory where VEP cache resides. Adjustable to each home.
```
VEP_CACHE="/home/judith/.vep/cache"
```
Version of human genome.
```
VEP_GENOME_VERSION="GRCh37"
```
Path to file of CADD SNV reference.
```
CADD="test/reference/samplechr22_CADD.tsv.gz"
```

Path to Genome Reference. This should point to VEP toplevel fasta
```
GENOME_REFERENCE="test/reference/chr22.fa.gz"
```
Path to gnomAD reference file.
```
GNOMAD_REFERENCE="test/reference/samplechr22_gnomAD.vcf.gz"
```
Path to GeneHancer reference file.
```
GENEHANCER_REFERENCE="test/reference/geneHancer_GRCh37_samplechr22.bed.gz"
```
Path to FANTOM-CAT reference file.
```
FANTOM_REFERENCE="test/reference/FANTOM_CAT.lv4.only_lncRNA_samplechr22.bed.gz"
```
Path to GWAS Catalog reference file.
```
GWASCATALOG_REFERENCE="test/reference/gwasc_samplechr22.vcf.gz"
```
Path to GWAS bolt reference file.
```
GWASMXB_BOLT_REFERENCE="test/reference/gwas_mxb_bolt_samplechr22.vcf.gz"
```
Path to GWAS saige reference file.
```
GWASMXB_SAIGE_REFERENCE="test/reference/gwas_mxb_saige_samplechr22.vcf.gz"
```
Path to iHs values file.
```
IHS_VALUE="test/reference/allMXB_ihs_chr22.bed.gz"
```
Path to iHH12 values file.
```
IHH12_VALUE="test/reference/allMXB_ihh12_chr22.bed.gz"
```
Path to LINSIGHT scores file.
```
LINSIGHT_SCORE="test/reference/samplechr22_linsight.bed.gz"
```
Path to GWAVA scores file.
```
GWAVA="test/reference/samplechr22_GWAVA.bed.gz"
```
Path tojarvis scores file.
```
JARVIS_SCORE="test/reference/samplechr22_jarvis.bed.gz"
```
Path to gwRVISscores file.
```
gwRVIS_SCORE="test/reference/samplechr22_gwRVIS.bed.gz"
```
Path to FATHMM-MKL scores file.
```
FATHMM-MKL="test/reference/fathmm_mkl_samplechr22.tab.gz"
```
Path to phastCons conservation scores file.
```
PHASTCONS="test/reference/hg19.100way.samplechr22.phatsCons100way.bw"
```
Path to phyloP conservation scores file.
```
PHYLOP="test/reference/hg19.100way.samplechr22.phyloP100way.bw"
```
Path to synonyms file.
```
SYNONYMS="test/reference/chr_synonyms.txt"
```
Variable of VEP VCF INFO field.
```
VCF_INFO_FIELD="ANN"
```
Variable of VEP species.
```
SPECIES="homo_sapiens"
```
Variable of VEP buffer size.
```
BUFFER_SIZE="10000"
```
Variable of VEP forks.
```
FORK_VEP="2"
```

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-run-vep directory structure

````
mk-run-vep/					      ## Module main directory
├── mkfile								## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
|   ├── reference							## Test reference directory.
└── testmodule.sh							## Script to test module functunality using test data
````
---

## References
* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J., & Kircher, M. (2018). CADD: predicting the deleteriousness of variants throughout the human genome. Nucleic acids research, 47(D1), D886-D894.
