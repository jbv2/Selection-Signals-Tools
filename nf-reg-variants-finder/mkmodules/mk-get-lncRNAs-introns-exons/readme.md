# mk-get-lncRNAs-introns-exons
**Author(s):** Judith Ballesteros-Villascán (judith.vballesteros@gmail.com)  
**Date:** July-2022 

---

## Module description:
Get introns and exons from lncRNAs.

1. This module get introns and exons from lncRNAs with variants.

2. This module get the number and type of intron of exon of the variant.

*Outputs will be compressed.

## Module Dependencies:
get_exons.R: Uses valr to know the exons and introns from lncRNAs.
extract_columns.R: Keep just necessary columns. 
cleaner.R: Order columns.

Please, install the following libraries:
library("valr")
library("dplyr")

### Input(s):

A `.tsv.gz` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	AC	AN	AF	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	SOURCE	GENE_PHENO	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	CHECK_REF	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	TRANSCRIPTION_FACTORS	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	GWAVA	ihs	xp_ehh	pbs_per_snp	pbs_per_gene_ensembl	pbs_per_gene_fantom	pbs_per_gene_genehancer	Type_GeneHancer_Genes	FANTOM-CAT_lncRNAID	lncRNA_promoter	gnomADg	gnomADg_AF_afr	gnomADg_AF_amr	gnomADg_AF_asj	gnomADg_AF_eas	gnomADg_AF_fin	gnomADg_AF_nfe	gnomADg_AF_oth	gwascatalog	gwascatalog_GWAScat_DISEASE_orTRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons
chr21	15755182	rs34742635	G	A	272	2366	0.151503	A	intron_variant	MODIFIER	HSPA13	ENSG00000155304	Transcript	ENST00000285667.3	protein_coding	.	1/4	ENST00000285667.3:c.25+234N>T	.	.	.	.	.	.	rs34742635	.	-1	.	SNV	HGNC	11375	YES	Ensembl	.	.	chr21:g.15755182N>A	0.1508	0.0545	0.2061	0.0784	0.2714	0.1922	0.2714	EUR	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	CATG00000055540.1&ENCT00000269855.1	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```

### Output(s):

A `.introns_exons.tsv` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	lncID	lnc_coordinates	exon_intron_coordinates	exon_intron_type	number_exon_intron	TRANSCRIPTION_FACTORS	SYMBOL	Gene	BIOTYPE	Existing_variation	DISTANCE	STRAND	FLAGS	CANONICAL	AC_MXB	AN_MXB	AF_MXB	AF.1	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	gnomADg_AF_afr	gnomADg_AF_amr	gnomADg_AF_asj	gnomADg_AF_eas	gnomADg_AF_fin	gnomADg_AF_nfe	gnomADg_AF_oth	ihs	xp_ehh	pbs_per_snp	pbs_per_gene_ensembl	pbs_per_gene_fantom	pbs_per_gene_genehancer	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	GWAVA	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons	lncRNA_promoter	Type_GeneHancer_Genes	gwascatalog_GWAScat_DISEASE_orTRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ
chr21	43942548	rs114738896	C	T	CATG00000056943.1|MICT00000226929.1	chr21_43938533_43954762	chr21_43938533_43946417	exon	3	.	SLC37A1	ENSG00000160190	protein_coding	rs114738896	.	1	.	YES	3	2366	0.00626909	0.0463	0.1679	0.0144	0	0	0	0.1679	AFR	.	.	.	.	.	.	.	.	.	.	.	CATG00000056943.1_0.646448771715417_16229_16	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```

## Module parameters:
FANTOM_REFERENCE="test/reference/FANTOM_CAT.lv4.only_lncRNA_samplechr22.bed.gz"

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-lncRNAs-introns-exons directory structure

````
mk-get-lncRNAs-introns-exons /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Riemondy KA, Sheridan RM, Gillen A, Yu Y, Bennett CG, Hesselberth JR (2017).
  “valr: Reproducible Genome Interval Arithmetic in R.” _F1000Research_.
  doi:10.12688/f1000research.11997.1
  <https://doi.org/10.12688/f1000research.11997.1>.
* Wickham H, François R, Henry L, Müller K (2022). _dplyr: A Grammar of Data
  Manipulation_. R package version 1.0.9,
  <https://CRAN.R-project.org/package=dplyr>.