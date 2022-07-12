# mk-vcf2tsv
**Author(s):** Israel Aguilar-Ordoñez (iaguilaror@gmail.com)  
**Date:** July-2019  

---

## Module description:
Convert vcf files to tsv format.

1. This module search ANN header and separates it by tabs.

2. This module separate columns by tabs.

3. This module add a "." to blanck spaces.

*Outputs will be compressed.

## Module Dependencies:
bcftools 1.9-220-gc65ba41 >
[Download and compile bcftools](https://samtools.github.io/bcftools/)

### Input(s):

 Uncompressed `VCF` file(s) with extension `.vcf`, which mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`.

For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)


Example line(s):
```
##fileformat=VCFv4.2
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr21	33241945	rs2229207	T	C	.	PASS	AC=27;AF_mx=0.179;AN=152;DP=2003;nhomalt_mx=2;ANN=C|missense_variant|MODERATE|IFNAR2|ENSG00000159110|Transcript|ENST00000342136.8|protein_coding|2/9||ENST00000342136.8:c.23T>C|ENSP00000343957.4:p.Phe8Ser|349/2899|23/1548|8/515|F/S|tTc/tCc|rs2229207&CM066573||1||SNV|HGNC|HGNC:5433|YES|1|P4|CCDS13621.1|ENSP00000343957|P48551||UPI000012D69B||1|tolerated|benign|hmmpanther:PTHR20859&hmmpanther:PTHR20859:SF53&Transmembrane_helices:TMhelix||chr21:g.33241945T>C|0.1186|0.0809|0.147|0.1706|0.0736|0.1421|0.07558|0.07791|0.1033|0.07742|0.154|0.07741|0.1757|0.08546|0.08082|0.09088|0.1247|0.1757|gnomAD_EAS|risk_factor||1&1|16757563&19434718&23009887&28497593&18588853&27186094|||||2.171|0.043682||rs2229207|3026|31374|0.0964493|657463|14|106|0.132075|0|3039|31416|0.0967341|168|736|8706|0.0845394|27|198|2136|0.0926966|10|122|848|0.143868|13|317|1552|0.204253|29|164|637|8592|0.0741387|31|607|4584|0.132417|35|1456|15418|0.0944351|76|277|3474|0.0797352|12|23|290|0.0793103|1|95|1086|0.087477|6|eas|317|1552|0.204253|29|32.63||||||||chr21:33241945-33241945|_susceptibility_to|risk_factor|OMIM:610424||||||||
```


### Output(s):

A `.tsv.gz` file with columns of the VEP annotations, by each vcf converted.

```
CHROM	POS	ID	REF	ALT	AC	AN	DP	AF_mx	nhomalt_mx	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	TSL	APPRIS	CCDS	ENSP	SWISSPROT	TREMBL	UNIPARC	SOURCE	GENE_PHENO	SIFT	PolyPhen	DOMAINS	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	AA_AF	EA_AF	gnomAD_AF	gnomAD_AFR_AF	gnomAD_AMR_AF	gnomAD_ASJ_AF	gnomAD_EAS_AF	gnomAD_FIN_AF	gnomAD_NFE_AF	gnomAD_OTH_AF	gnomAD_SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	PUBMED	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	CADD_PHRED	CADD_RAW	GeneHancer_type_and_Genes	gnomADg	gnomADg_AC	gnomADg_AN	gnomADg_AF	gnomADg_DP	gnomADg_AC_nfe_seu	gnomADg_AN_nfe_seu	gnomADg_AF_nfe_seu	gnomADg_nhomalt_nfe_seu	gnomADg_AC_raw	gnomADg_AN_raw	gnomADg_AF_raw	gnomADg_nhomalt_raw	gnomADg_AC_afr	gnomADg_AN_afr	gnomADg_AF_afr	gnomADg_nhomalt_afr	gnomADg_AC_nfe_onf	gnomADg_AN_nfe_onf	gnomADg_AF_nfe_onf	gnomADg_nhomalt_nfe_onf	gnomADg_AC_amr	gnomADg_AN_amr	gnomADg_AF_amr	gnomADg_nhomalt_amr	gnomADg_AC_eas	gnomADg_AN_eas	gnomADg_AF_eas	gnomADg_nhomalt_eas	gnomADg_nhomalt	gnomADg_AC_nfe_nwe	gnomADg_AN_nfe_nwe	gnomADg_AF_nfe_nwe	gnomADg_nhomalt_nfe_nwe	gnomADg_AC_nfe_est	gnomADg_AN_nfe_est	gnomADg_AF_nfe_est	gnomADg_nhomalt_nfe_est	gnomADg_AC_nfe	gnomADg_AN_nfe	gnomADg_AF_nfe	gnomADg_nhomalt_nfe	gnomADg_AC_fin	gnomADg_AN_fin	gnomADg_AF_fin	gnomADg_nhomalt_fin	gnomADg_AC_asj	gnomADg_AN_asj	gnomADg_AF_asj	gnomADg_nhomalt_asj	gnomADg_AC_oth	gnomADg_AN_oth	gnomADg_AF_oth	gnomADg_nhomalt_oth	gnomADg_popmax	gnomADg_AC_popmax	gnomADg_AN_popmax	gnomADg_AF_popmax	gnomADg_nhomalt_popmax	gnomADg_cov	gwascatalog	gwascatalog_GWAScat_DISEASE_or_TRAIT	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_REPLICATION_SAMPLE_SIZE	gwascatalog_GWAScat_STRONGEST_SNP_and_RISK_ALLELE	gwascatalog_GWAScat_PVALUE	gwascatalog_GWAScat_STUDY_ACCESSION	clinvar	clinvar_CLNDN	clinvar_CLNSIG	clinvar_CLNDISDB	miRBase	pharmgkb_drug	pharmgkb_drug_PGKB_Annotation_ID	pharmgkb_drug_PGKB_Gene	pharmgkb_drug_PGKB_Chemical	pharmgkb_drug_PGKB_PMID	pharmgkb_drug_PGKB_Phenotype_Category	pharmgkb_drug_PGKB_Sentence
chr21	33241945	rs2229207	T	C	27	152	2003	0.179	2	C	missense_variant	MODERATE	IFNAR2	ENSG00000159110	Transcript	ENST00000342136.8	protein_coding	2/9	.	ENST00000342136.8:c.23T>C	ENSP00000343957.4:p.Phe8Ser	349/2899	23/1548	8/515	F/S	tTc/tCc	rs2229207&CM066573	.	1	.	SNV	HGNC	HGNC:5433	YES	1	P4	CCDS13621.1	ENSP00000343957	P48551	.	UPI000012D69B	.	1	tolerated	benign	hmmpanther:PTHR20859&hmmpanther:PTHR20859:SF53&Transmembrane_helices:TMhelix	.	chr21:g.33241945T>C	0.1186	0.0809	0.147	0.1706	0.0736	0.1421	0.07558	0.07791	0.1033	0.07742	0.154	0.07741	0.1757	0.08546	0.08082	0.09088	0.1247	0.1757	gnomAD_EAS	risk_factor	.	1&1	16757563&19434718&23009887&28497593&18588853&27186094	.	.	.	.	2.171	0.043682	.	rs2229207	3026	31374	0.0964493	657463	14	106	0.132075	0	3039	31416	0.0967341	168	736	8706	0.0845394	27	198	2136	0.0926966	10	122	848	0.143868	13	317	1552	0.204253	29	164	637	8592	0.0741387	31	607	4584	0.132417	35	1456	15418	0.0944351	76	277	3474	0.0797352	12	23	290	0.0793103	1	95	1086	0.087477	6	eas	317	1552	0.204253	29	32.63	.	.	.	.	.	.	.	chr21:33241945-33241945	_susceptibility_to	risk_factor	OMIM:610424	.	.	.	.	.	.	.	.
```

## Module parameters:
NONE

## Testing the module:

1. Test this module locally by running,
```
bash testmodule.sh
```

2. `[>>>] Module Test Successful` should be printed in the console...

## mk-vcf2tsv directory structure

````
mk-vcf2tsv /				    ## Module main directory
├── mkfile						   		## File in mk format, specifying the rules for building every result requested by runmk.sh
├── readme.md							## This document. General workflow description.
├── runmk.sh								## Script to print every file required by this module
├── test									## Test directory
│   ├── data								## Test data directory. Contains input files for testing.
└── testmodule.sh							## Script to test module functunality using test data
````

## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.