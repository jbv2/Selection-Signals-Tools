nf-Reg-variants-finder
===
'nf-Reg-variants-finder' is a tool, implemented in Nextflow, that finds regulatory variants harbored in enhancers, promoters and long noncoding RNAs (lncRNAs), and annotates them using Variant Effect Predictor (VEP) with additional plugins and custom annotations for predicting functional or phenotypic variation.  

---

*Notes*

Some mkmodules were based or taken from [nf-Vep-Extended](https://github.com/Iaguilaror/nf-VEPextended) and [nf-vcf-cataloguer](https://github.com/Iaguilaror/nf-vcf-cataloguer) pipelines.

`summary.md` describes in brief the commands used for preparing inputs and references for this pipeline.

**TO DO**
(jballesteros)
Add mkodules for downstream analyses

### Features
  **-v 0.1.0**

* nf-Reg-variants supports vcf compressed files as input.
* Results include annotated compressed and indexed vcf files.
* Results include a general table description in TSV.
* Scalability and reproducibility via a Nextflow-based framework.
* nf-Reg-variants incorporates GeneHancer database to extend annotation and obtains variants annotation converted to TSV format.
* nf-Reg-variants incorporates FANTOM-CAT database to extend annotation and obtains variants annotation converted to TSV format.
* nf-Reg-variants incorporates gnomAD database to extend annotation and obtains variants annotation converted to TSV format.
* nf-Reg-variants incorporates GWAS Catalog database to extend annotation and obtains variants annotation converted to TSV format.
* nf-Reg-variants incorporates GWASmxb database to extend annotation and obtains variants annotation converted to TSV format.
* nf-Reg-variants incorporates multiple functional scores:
    * CADD
    * FATHMM-MKL
    * GWAVA
    * LINSIGHT
    * gwRVIS
    * JARVIS
* nf-Reg-variants incorporates multiple scores of conservation:
    * PHYLOP100
    * PHASTCONS
* nf-Reg-variants incorporates selection values from:
  * nf-haplotype-selection
  * nf-pbs-per-element
* Chromosome level paralelization.

---

## Requirements
#### Compatible OS*:
* [Ubuntu 20.04.2.0 LTS](https://releases.ubuntu.com/20.04/)

\* nf-Reg-variants may run in other UNIX based OS and versions, but testing is required.

#### Software:
| Requirement | Version  | Required Commands * |
|:---------:|:--------:|:-------------------:|
| [bcftools](https://samtools.github.io/bcftools/) | 1.13 | view, norm, concat, query |
| [bedtools](https://bedtools.readthedocs.io/en/latest/) | v2.27.1 | intersect |
| [htslib](http://www.htslib.org/download/) | 1.13 | tabix, bgzip |
| [ensembl-vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html) | 104 | vep** |
| [filter_vep](http://www.ensembl.org/info/docs/tools/vep/script/vep_download.html) | 104 | filter_vep |
| [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) | 20.10.0.5430 | nextflow |
| [Plan9 port](https://github.com/9fans/plan9port) | Latest (as of 31/03/2021 ) | mk \***|
| [R](https://www.r-project.org/) | 4.10.0 | \**** See R scripts |

\* These commands must be accessible from your `$PATH` (*i.e.* you should be able to invoke them from your command line).  

\** In order for VEP to be able to access bigWig format custom annotation files, the [Bio::DB::BigFile](https://m.ensembl.org/info/docs/tools/vep/script/vep_download.html#bigfile) perl module is required.

\*** Plan9 port builds many binaries, but you ONLY need the `mk` utility to be accessible from your command line.

---

### Installation
Download nf-Reg-variants from Github repository:  
```
git clone https://github.com/jbv2/mxb_selection_signals
```

---

#### Test
To test nf-Reg-variants's execution using test data, run:
```
./runtest.sh
```

Your console should print the Nextflow log for the run, once every process has been submitted, the following message will appear:
```
======
Reg variants finder: Basic pipeline TEST SUCCESSFUL
======
```

nf-Reg-variants results for test data should be in the following file:
```
test/results/RegVarFinder-results/gathered_results/
```

---

### Usage
To run nf-Reg-variants go to the pipeline directory and execute:
```
nextflow run find_reg_variants.nf --vcffile <path to input 1> [--output_dir path to results ] [-resume]
```

For information about options and parameters, run:
```
nextflow run find_reg_variants.nf --help
```

---

### Pipeline Inputs
* A compressed vcf file with extension '.vcf.gz', which must have a TABIX index with .tbi extension, located in the same directory as the vcf file.

**Note(s)**: INFO must cointain AC

Example line(s):
```
##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##contig=<ID=chr22,length=198295559>
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22   30000353        .       G       T       .       PASS    AC=107;AF_mx=0.708;AN=150;DP=883;nhomalt_mx=39
```

* `*.GeneHancers.bed.gz` and `GeneHancers.bed.gz.tbi` : contains every double elite relationship as regulator element - gene. This file was asked to Weizmann Institute of Science at Spring 2021.
* `*.FANTOM_CAT.bed.gz` and `FANTON_CAT.bed.gz.tbi` : contains only lncRNAs gotten by CAGE. Availables in: https://fantom.gsc.riken.jp/5/suppl/Hon_et_al_2016/data/assembly/lv4_stringent/
* `*_gnomAD.vcf.gz` contains variants from gnomAD v2.0.1, offered by VEP. Availables in: http://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/
* `*.GWASpop.vcf.gz` : contains every GWAS association from your own data.
* `*.GWAScatalog.vcf.gz` : contains every GWAS association for SNVs (no haplotypes) compiled by jballesteros from GWAScat database at Spring 2021. TSV available in: https://www.ebi.ac.uk/gwas/docs/file-downloads
* `*_SNVs.tsv.gz` and `*_SNVs.tsv.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from CADD. Availables in: https://cadd.gs.washington.edu/download
* `fathm-mkl.tab.gz` and `*fathm-mkl.tab.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from FATHMM-MKL. Availables in: https://github.com/HAShihab/fathmm-MKL
* `*.GWAVA.bed.gz` and `*.GWAVA.bed.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from GWAVA. Availables in: ftp://ftp.sanger.ac.uk/pub/resources/software/gwava/
* `*.LINSIGHT.bed.gz` and `*.LINSIGHT.bed.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from LINSIGHT. Availables in: http://compgen.cshl.edu/LINSIGHT/LINSIGHT.bw
* `*.gwRVIS.bed.gz` and `*.gwRVIS.bed.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from gwRVIS. Availables in: https://az.app.box.com/v/jarvis-gwrvis-scores/folder/122133161526?page=2
* `*.JARVIS.bed.gz` and `*.JARVIS.bed.gz.tbi` : Pre-scored files for SNVs compressed and indexed provided from JARVIS. Availables in: https://az.app.box.com/v/jarvis-gwrvis-scores/folder/122133161526?page=2
* `*.phastCons.bw` : Pre-scored files for SNVs. Availables in: http://hgdownload.soe.ucsc.edu/goldenPath/hg19/phastCons100way/hg19.100way.phastCons.bw
* `*.phyloP.bw` : Pre-scored files for SNVs. Availables in: http://hgdownload.soe.ucsc.edu/goldenPath/hg19/phyloP100way/hg19.100way.phyloP100way.bw
* `*ihs_top1.bed.gz` and `*ihs_top1.bed.gz.tbi` : Significant values of iHS from selection analyses.
* `*xp_ehh_top1.bed.gz` and `*xp_ehh_top1.bed.gz.tbi` : Significant values of XP-EHH from selection analyses.
* `*pbs_per_gene_ensembl_top1.bed.gz` and `*pbs_per_gene_ensembl_top1.bed.gz.tbi` : Top 1% values of PBS per coding gene from selection analyses.
* `*pbs_per_gene_fantom_top1.bed.gz` and `*pbs_per_gene_fantom_top1.bed.gz.tbi` : Top 1% values of PBS per lncRNA gene from selection analyses.
* `*pbs_per_gene_genehancer_top1.bed.gz` and `*pbs_per_gene_genehancer_top1.bed.gz.tbi` : Top 1% values of PBS per enhancer/promoter from selection analyses.
* `*pbs_per_snp.bed.gz` and `*pbs_per_snp.bed.gz.tbi` : PBS per SNP from selection analyses.
* `lncRNAs_promoters_*.bed.gz` and `lncRNAs_promoters_*.bed.gz.tbi` : contains  lncRNAs promoters from Fantom (2kbp upstream and downstream).
---

### Pipeline Results
* A compressed vcf file with `.anno_vep.vcf.gz` extension.  

Example line(s):
```
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
chr22	35777618	rs2071748	G	A	.	.	PR;NS=6006;AN=12012;AF=0.187979;MAF=0.187979;AC=2258;AC_Het=1796;AC_Hom=462;AC_Hemi=0;HWE=0.117718;ExcHet=0.948145;ANN=A|intron_variant|MODIFIER|HMOX1|ENSG00000100292|Transcript|ENST00000216117.8|protein_coding||1/4|ENST00000216117.8:c.23+429G>A|||||||rs2071748||1||SNV|HGNC|5013|YES|Ensembl|1||chr22:g.35777618G>A|0.4906|0.6407|0.2911|0.4891|0.3817|0.5429|0.6407|AFR|||1|||||||||||1.07283|0.182115|Promoter/Enhancer%3Bgenehancer_id=GH22J035376%3Bconnected_gene=HMOX1%3Bscore=264.64%3Bconnected_gene=NONHSAG033802.2%3Bscore=250.67%3Bconnected_gene=HMGXB4%3Bscore=32.45%3Bconnected_gene=MCM5%3Bscore=23.26%3Bconnected_gene=TOM1%3Bscore=13.67%3Bconnected_gene=APOL6%3Bscore=7.04%3Bconnected_gene=ENSG00000282041%3Bscore=0.67%3Bconnected_gene=AB905429%3Bscore=0.67||||||||||rs2071748||HMOX1|HMOX1|3e-06|5.52287874528034|0.05|815_Hispanic_children_from_263_families|23251661||||||||||||0.074934|2.27042|0.9993611|-3.42499995231628|0
```

* Compressed tsv files with `.*.tsv.gz` extension for:
  * lncRNAs
  * enhancers
  * promoters

Example line(s):
```
CHROM	POS	ID	REF	ALT	AC	AN	AF	Allele	Consequence	IMPACT	SYMBOL	Gene	Feature_type	Feature	BIOTYPE	EXON	INTRON	HGVSc	HGVSp	cDNA_position	CDS_position	Protein_position	Amino_acids	Codons	Existing_variation	DISTANCE	STRAND	FLAGS	VARIANT_CLASS	SYMBOL_SOURCE	HGNC_ID	CANONICAL	SOURCE	GENE_PHENO	HGVS_OFFSET	HGVSg	AF	AFR_AF	AMR_AF	EAS_AF	EUR_AF	SAS_AF	MAX_AF	MAX_AF_POPS	CLIN_SIG	SOMATIC	PHENO	CHECK_REF	MOTIF_NAME	MOTIF_POS	HIGH_INF_POS	MOTIF_SCORE_CHANGE	TRANSCRIPTION_FACTORS	CADD_PHRED	CADD_RAW	FATHMM_MKL_C	FATHMM_MKL_NC	ihs	ihh12	Type_GeneHancer_Genes	FANTOM-CAT_lncRNAID	gnomADg	gnomADg_AF_AFR	gnomADg_AF_AMR	gnomADg_AF_ASJ	gnomADg_AF_EAS	gnomADg_AF_FIN	gnomADg_AF_NFE	gnomADg_AF_OTH	gwascatalog	gwascatalog_GWAScat_DISEASE_or_TRAIT	gwascatalog_GWAScat_REPORTED_GENE	gwascatalog_GWAScat_MAPPED_GENE	gwascatalog_GWAScat_P_VALUE	gwascatalog_GWAScat_P_VALUE_MLOG	gwascatalog_GWAScat_OR_or_BETA	gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE	gwascatalog_GWAScat_PUBMEDID	gwasmxb_saige	gwasmxb_saige_GWASmxb_TRAIT	gwasmxb_saige_GWASmxb_P_VALUE	gwasmxb_saige_GWASmxb_BETA	gwasmxb_saige_GWASmxb_FREQ	gwasmxb_saige_GWASmxb_SAMPLE	gwasmxb_bolt	gwasmxb_bolt_GWASmxb_TRAIT	gwasmxb_bolt_GWASmxb_P_VALUE	gwasmxb_bolt_GWASmxb_BETA	gwasmxb_bolt_GWASmxb_FREQ	LINSIGHT_SCORE	gwRVIS_score	JARVIS_score	PhyloP100	PhastCons
chr22	35777618	rs2071748	G	A	2258	12012	0.187979	A	intron_variant	MODIFIER	HMOX1	ENSG00000100292	Transcript	ENST00000216117.8	protein_coding	.	1/4	ENST00000216117.8:c.23+429G>A	.	.	.	.	.	.	rs2071748	.	1	.	SNV	HGNC	5013	YES	Ensembl	1	.	chr22:g.35777618G>A	0.4906	0.6407	0.2911	0.4891	0.3817	0.5429	0.6407	AFR	.	.	1	.	.	.	.	.	.	.	.	.	.	1.07283	0.182115	Promoter/Enhancer%3Bgenehancer_id=GH22J035376%3Bconnected_gene=HMOX1%3Bscore=264.64%3Bconnected_gene=NONHSAG033802.2%3Bscore=250.67%3Bconnected_gene=HMGXB4%3Bscore=32.45%3Bconnected_gene=MCM5%3Bscore=23.26%3Bconnected_gene=TOM1%3Bscore=13.67%3Bconnected_gene=APOL6%3Bscore=7.04%3Bconnected_gene=ENSG00000282041%3Bscore=0.67%3Bconnected_gene=AB905429%3Bscore=0.67	.	.	.	.	.	.	.	.	.	rs2071748	.	HMOX1	HMOX1	3e-06	5.52287874528034	0.05	815_Hispanic_children_from_263_families	23251661	.	.	.	.	.	.	.	.	.	.	.	0.074934	2.27042	0.9993611	-3.42499995231628	0
```

#### Output format Descriptions:
Output annotation fields will be added in INFO column. For mor info about fields description, see: https://www.ensembl.org/info/docs/tools/vep/vep_formats.html#other_fields

Our pipeline additionaly include:

* CADD score: It integrates several annotations in a single value (C score) for each variant.
* FATHMM-MKL: It integrates ENCODE functional annotations with a measure based on nucleotide sequence conservation.
* GWAVA score: It integrates genomic annotations to prioritize variants in non-coding regions.
* LINSIGHT score: It predicts nucleotide sites that can cause deleterious fitness, so they are phenotypically important.
* gwRVIS score: Genome-Wide Residual Variation Intolerance Score
* JARVIS score: Junk” Annotation genome-wide Residual Variation Intolerance Score
* GeneHancer overlaps: For finding variants in enhancers and promoters.
* FANTOM-CAT (lncRNAs) overlaps: For finding variants in lncRNAs with accurate 5'.
* gnomAD data: is a resource developed by an international coalition of investigators, with the goal of aggregating and harmonizing both exome and genome sequencing data from a wide variety of large-scale sequencing projects, and making summary data available for the wider scientific community.
* GWAS Catalog associations: curated collection of all human genome-wide association studies.
* GWASmxb associations: MXB Biobank genome-wide association studies.
* phastCons score: Conservation score.
* phyloP score: Conservation score.
* iHS scores: Significant values only.
* XP-EHH scores: Significant values only.
* PBS per ensembl: Top 1% of PBS values per coding gene.
* PBS per fantom: Top 1% of PBS values per lncRNA gene.
* PBS per genehancer: Top 1% of PBS values per enhancer/promoter.
* PBS per SNP: PBS values.

---

### nf-Reg-variants directory structure
````
nf-Reg-variants						## Pipeline main directory.
├── nextflow.config				## Configuration file for this pipeline.
├── README.md					## This document. General workflow description
├── runtest.sh					## Execution script for pipeline testing.
├── find_reg_variants.nf				## Flow control script of this pipeline.
├── launchers						## Directory for different scripts to run nf-Reg-variants. (optional)
├── mkmodules					## Directory for submodule organization
│   ├── mk-extract-chromosomes			## Submodule to extract variants per chromosome from a single vcf.
│   ├── mk-filter-vcf			## Submodule to keep variants with at least one copy of an alternative allele.
│   ├── mk-rejoin-chromosomes			## Submodule to concatenate vcfs from different chromosomes.
│   ├── mk-split-chromosomes			## Submodule to make chunks of a chromosome vcf file.
│   ├── mk-untangle-multiallelic			## Submodule to split multiallelic variants.
│   ├── mk-get-GeneHancer-variants			## Submodule to separate variants in GeneHancer regions.
│   ├── mk-get-FANTOM_CAT-variants			## Submodule to separate variants in FANTOM_CAT regions.
│   ├── mk-get-GWAScatalog-variants			## Submodule to separate GWAS catalog variants.
│   ├── mk-get-GWASmxb-variants			## Submodule to separate GWAS MXB Biobank variants.
│   ├── mk-get-allGWAS-variants		## Submodule to separate GWAS catalog and GWASmxb variants.
│   ├── mk-vcf2tsv			## Submodule to convert vcf files to tsv format.
│   └── mk-run-vep			## Submodule to annotate variants with VEP.
└── test							## Test directory.
    ├── data						## Test data directory
    └──reference							## Test references directory.

````

#### References
Under the hood nf-Reg-variants implements some widely known tools. Please include the following ciations in your work:

* Israel Aguilar Ordoñez 2020. VEPextended. protocols.io https://dx.doi.org/10.17504/protocols.io.bkhvkt66
* Israel Aguilar Ordoñez 2020. nf-vcf-cataloguer. protocols.io https://dx.doi.org/10.17504/protocols.io.bkmzku76
* Fishilevich, S., Nudel, R., Rappaport, N., Hadar, R., Plaschkes, I., Iny Stein, T., ... & Lancet, D. (2017). GeneHancer: genome-wide integration of enhancers and target genes in GeneCards. Database, 2017.
* Karczewski, K. J., Francioli, L. C., Tiao, G., Cummings, B. B., Alföldi, J., Wang, Q., ... & Gauthier, L. D. (2019). Variation across 141,456 human exomes and genomes reveals the spectrum of loss-of-function intolerance across human protein-coding genes. BioRxiv, 531210.
* MacArthur, J., Bowler, E., Cerezo, M., Gil, L., Hall, P., Hastings, E., ... & Pendlington, Z. M. (2016). The new NHGRI-EBI Catalog of published genome-wide association studies (GWAS Catalog). Nucleic acids research, 45(D1), D896-D901.
* McLaren, W., Gil, L., Hunt, S. E., Riat, H. S., Ritchie, G. R., Thormann, A., ... & Cunningham, F. (2016). The ensembl variant effect predictor. Genome biology, 17(1), 122.
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.
* Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J., & Kircher, M. (2018). CADD: predicting the deleteriousness of variants throughout the human genome. Nucleic acids research, 47(D1), D886-D894.
* Quinlan, Aaron R., and Ira M. Hall. "BEDTools: a flexible suite of utilities for comparing genomic features." Bioinformatics 26.6 (2010): 841-842.

---
### Developed at RegRNALab

### Contact
If you have questions, requests, or bugs to report, please email
<judith.vballesteros@gmail.com>

#### Dev Team
Judith Ballesteros-Villascán <judith.vballesteros@gmail>
