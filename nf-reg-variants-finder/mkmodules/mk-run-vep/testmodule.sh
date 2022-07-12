#!/usr/bin/env bash
## This small script runs a module test with the sample data

###
## environment variable setting
# VEP_GENOME_VERSION="GRCh38 or GRCh37, for human"
export VEP_GENOME_VERSION="GRCh37"
export GENOME_REFERENCE="test/reference/chr22.fa.gz" # this should point to VEP toplevel fasta
export GNOMAD_REFERENCE="test/reference/samplechr22_gnomAD.vcf.gz"
export IHS_VALUE="test/reference/samplechr22_ihs_top1.bed.gz"
export XP_EHH_VALUE="test/reference/samplechr22_xp_ehh_top1.bed.gz"
export PBS_PER_SNP="test/reference/samplechr22_pbs_per_snp_top1.bed.gz"
export PBS_PER_GENE_ENSEMBL="test/reference/samplechr22_pbs_per_gene_ensembl_top1.bed.gz"
export PBS_PER_GENE_FANTOM="test/reference/samplechr22_pbs_per_gene_fantom_top1.bed.gz"
export PBS_PER_GENE_GENEHANCER="test/reference/samplechr22_pbs_per_gene_genehancer_top1.bed.gz"
export GENEHANCER_REFERENCE="test/reference/geneHancer_GRCh37_samplechr22.bed.gz"
export FANTOM_REFERENCE="test/reference/FANTOM_CAT.lv4.only_lncRNA_samplechr22.bed.gz"
export LNCRNA_PROMOTERS_REFERENCE="test/reference/lncRNAs_promoters_samplechr22.bed.gz"
export GWASCATALOG_REFERENCE="test/reference/gwasc_samplechr22.GRCh37.vcf.gz"
export GWASMXB_BOLT_REFERENCE="test/reference/gwas_mxb_bolt_samplechr22.GRCh37.vcf.gz"
export GWASMXB_SAIGE_REFERENCE="test/reference/gwas_mxb_saige_samplechr22.GRCh37.vcf.gz"
export LINSIGHT_SCORE="test/reference/samplechr22_linsight.bed.gz"
export GWRVIS_SCORE="test/reference/samplechr22_gwRVIS.bed.gz"
export JARVIS_SCORE="test/reference/samplechr22_jarvis.bed.gz"
export PHYLOP100="test/reference/hg19.100way.samplechr22.phyloP100way.bw"
export PHASTCONS="test/reference/hg19.100way.samplechr22.phastCons.bw"
export GWAVA="test/reference/samplechr22_GWAVA.bed.gz"
export CADD="test/reference/samplechr22_CADD.tsv.gz"
export FATHMM_MKL="test/reference/fathmm_mkl_samplechr22.tab.gz"
export SYNONYMS="test/reference/chr_synonyms.txt"
export VCF_INFO_FIELD="ANN"
export SPECIES="homo_sapiens"
export BUFFER_SIZE="10000"
export FORK_VEP="2"
###

echo "[>..] test running this module with data in test/data"
## Remove old test results, if any; then create test/reults dir
rm -rf test/results
mkdir -p test/results
echo "[>>.] results will be created in test/results"
## Execute runmk.sh, it will find the basic example in test/data
## Move results from test/data to test/results
## results files are *.anno_dbSNP_vep.vcf
./runmk.sh \
&& mv test/data/*.vep.vcf test/results \
&& echo "[>>>] Module Test Successful"
