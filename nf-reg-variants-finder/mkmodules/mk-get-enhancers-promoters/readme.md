# mk-get-enhancers-promoters
**Author(s):** Judith Ballesteros-Villascán (judith.vballesteros@gmail.com)  
**Date:** July-2022 

---

## Module description:
Separate variants from GeneHancer in enhancers and promoters. 

## Module Dependencies:
Separate_enhancers.R: Separates GeneHancer types, keep just necessary columns and order columns.

Please, install the following libraries:
library(tidyr)
library("dplyr")

### Input(s):

A `.tsv.gz` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	AC	AN	AF	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	SOURCE	GENE_PHENO	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	CHECK_REF	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	TRANSCRIPTION_FACTORS	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	GWAVA	ihs	xp_ehh	pbs_per_snp	pbs_per_gene_ensembl	pbs_per_gene_fantom	pbs_per_gene_genehancer	Type_GeneHancer_Genes	FANTOM-CAT_lncRNAID	lncRNA_promoter	gnomADg	gnomADg_AF_afr	gnomADg_AF_amr	gnomADg_AF_asj	gnomADg_AF_eas	gnomADg_AF_fin	gnomADg_AF_nfe	gnomADg_AF_oth	gwascatalog	gwascatalog_GWAScat_DISEASE_orTRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons
chr21	15755182	rs34742635	G	A	272	2366	0.151503	A	intron_variant	MODIFIER	HSPA13	ENSG00000155304	Transcript	ENST00000285667.3	protein_coding	.	1/4	ENST00000285667.3:c.25+234N>T	.	.	.	.	.	.	rs34742635	.	-1	.	SNV	HGNC	11375	YES	Ensembl	.	.	chr21:g.15755182N>A	0.1508	0.0545	0.2061	0.0784	0.2714	0.1922	0.2714	EUR	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	CATG00000055540.1&ENCT00000269855.1	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.	.
```

### Output(s):

A `*.enhancers.tsv` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	GeneHancer_ID	Type_Enhancer_Promoter	CHR_GH	START_GH	END_GH	LENGHT_GH	TRANSCRIPTION_FACTORS	SYMBOL	Gene	BIOTYPE	Existing_variation	DISTANCE	STRAND	FLAGS	CANONICAL	AC_MXB	AN_MXB	AF_MXB	AF.1	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	gnomADg_AF_afr	gnomADg_AF_amr	gnomADg_AF_asj	gnomADg_AF_eas	gnomADg_AF_fin	gnomADg_AF_nfe	gnomADg_AF_oth	ihs	xp_ehh	pbs_per_snp	pbs_per_gene_ensembl	pbs_per_gene_fantom	pbs_per_gene_genehancer	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	GWAVA	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons	FANTOM.CAT_lncRNAID	gwascatalog_GWAScat_DISEASE_orTRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	lncRNA_promoter	Gene1	Score1	Gene2	Score2	Gene3	Score3	Gene4	Score4	Gene5	Score5	Gene6	Score6	Gene7	Score7	Gene8	Score8	Gene9	Score9	Gene10	Score10	Gene11	Score11	Gene12	Score12	Gene13	Score13	Gene14	Score14	Gene15	Score15	Gene16	Score16	Gene17	Score17	Gene18	Score18	Gene19	Score19	Gene20	Score20	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ
chr22	35443419	rs5755544	G	A	GH22J035047	Enhancer	chr22	35443354	35443580	226	.	RP1-272J12.1	ENSG00000227895	antisense	rs5755544	.	-1	.	YES	801	2366	0.268124	0.1324	0.18	0.2118	0.1518	0.0616	0.0644	0.2118	AMR	.	.	.	.	.	.	.	.	.	.	.	.	.	1.871	-0.055808	0.01372	0.12176	0.37	0.069533	-0.1628783	0.3220119	-0.108999997377396	0.0020000000949949	ENSG00000233080.2&MICT00000232749.1	.	.	.	.	.	.	.	.	.	TOM1	8.68	HMOX1	5.95	ISX	0.37	lnc-ISX-5	0.37	piR-31199-211	0.37	LINC02885	0.32	HSALNG0135125-001	0.09	LINC01399	0.07	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	.	.	.	.	.	.	.	.	.	.	.
```

A `*.promoters.tsv` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	GeneHancer_ID	Type_Enhancer_Promoter	CHR_GH	START_GH	END_GH	LENGHT_GH	TRANSCRIPTION_FACTORS	SYMBOL	Gene	BIOTYPE	Existing_variation	DISTANCE	STRAND	FLAGS	CANONICAL	AC_MXB	AN_MXB	AF_MXB	AF.1	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	gnomADg_AF_afr	gnomADg_AF_amr	gnomADg_AF_asj	gnomADg_AF_eas	gnomADg_AF_fin	gnomADg_AF_nfe	gnomADg_AF_oth	ihs	xp_ehh	pbs_per_snp	pbs_per_gene_ensembl	pbs_per_gene_fantom	pbs_per_gene_genehancer	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	GWAVA	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons	FANTOM.CAT_lncRNAID	gwascatalog_GWAScat_DISEASE_orTRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	lncRNA_promoter	Gene1	Score1	Gene2	Score2	Gene3	Score3	Gene4	Score4	Gene5	Score5	Gene6	Score6	Gene7	Score7	Gene8	Score8	Gene9	Score9	Gene10	Score10	Gene11	Score11	Gene12	Score12	Gene13	Score13	Gene14	Score14	Gene15	Score15	Gene16	Score16	Gene17	Score17	Gene18	Score18	Gene19	Score19	Gene20	Score20	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ
chr22	35463184	rs199562176;rs199562176;22:35463184-CT	C	T	GH22J035064	Promoter	chr22	35460485	35465794	5309	.	ISX	ENSG00000175329	protein_coding	rs199562176&COSV100434160	.	1	.	YES	3	2366	0.000642983	0.0004	0.0008	0	0.001	0	0	0.001	EAS	.	.	.	.	.	.	.	.	.	.	.	.	.	22.8	2.620631	0.56448	0.96791	0.15	.	-0.002255374	0.9834013	2.8289999961853	0.999000012874603	ENSG00000233080.2&MICT00000232749.1	.	.	.	.	.	.	.	.	.	ISX	250.67	piR-38352-358	0.67	LINC02885	0.44	HSALNG0135125-001	0.10	HMGXB4	0.09	LINC01399	0.08	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	NA	.	.	.	.	.	.	.	.	.	.	.
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-get-enhancers-promoters

````
mk-get-enhancers-promoters /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Wickham H, François R, Henry L, Müller K (2022). _dplyr: A Grammar of Data
  Manipulation_. R package version 1.0.9,
  <https://CRAN.R-project.org/package=dplyr>.
* Wickham H, Girlich M (2022). _tidyr: Tidy Messy Data_. R package version
  1.2.0, <https://CRAN.R-project.org/package=tidyr>.