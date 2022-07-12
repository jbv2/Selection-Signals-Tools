echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run find_reg_variants.nf \
	--vcffile test/data/test_data.vcf.gz \
	--cadd_reference test/reference/samplechr22_CADD.tsv.gz \
  --gwava test/reference/samplechr22_GWAVA.bed.gz \
  --fathmm_mkl_reference test/reference/fathmm_mkl_samplechr22.tab.gz \
  --linsight_score test/reference/samplechr22_linsight.bed.gz \
  --gwrvis_score test/reference/samplechr22_gwRVIS.bed.gz \
  --jarvis_score test/reference/samplechr22_jarvis.bed.gz \
	--genome_reference test/reference/chr22.fa.gz \
	--gnomad_reference test/reference/samplechr22_gnomAD.vcf.gz \
	--genehancer_reference test/reference/geneHancer_GRCh37_samplechr22.bed.gz \
	--gwascatalog_reference test/reference/gwasc_samplechr22.GRCh37.vcf.gz \
	--gwasmxb_saige_reference test/reference/gwas_mxb_saige_samplechr22.GRCh37.vcf.gz \
  --gwasmxb_bolt_reference test/reference/gwas_mxb_bolt_samplechr22.GRCh37.vcf.gz \
  --ihs_value test/reference/samplechr22_ihs_top1.bed.gz \
  --xp_ehh_value test/reference/samplechr22_xp_ehh_top1.bed.gz \
	--pbs_per_snp test/reference/samplechr22_pbs_per_snp_top1.bed.gz \
	--pbs_per_gene_ensembl test/reference/samplechr22_pbs_per_gene_ensembl_top1.bed.gz \
	--pbs_per_gene_fantom test/reference/samplechr22_pbs_per_gene_fantom_top1.bed.gz \
	--pbs_per_gene_genehancer test/reference/samplechr22_pbs_per_gene_genehancer_top1.bed.gz \
  --fantomcat_reference test/reference/FANTOM_CAT.lv4.only_lncRNA_samplechr22.bed.gz \
	--lncrna_promoters_reference test/reference/lncRNAs_promoters_samplechr22.bed.gz \
  --phylop100_reference test/reference/hg19.100way.samplechr22.phyloP100way.bw \
  --phastcons_reference test/reference/hg19.100way.samplechr22.phastCons.bw \
  --synonyms test/reference/chr_synonyms.txt \
	--gene_info_fantom test/reference/gene.info.FANTOM.tsv \
	--chr_length test/reference/human19_chr.bed \
  --vcf_info_field "ANN" \
  --species "homo_sapiens" \
  --buffer_size "10000" \
  --fork_vep "1" \
  --output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n Reg variants finder: Basic pipeline TEST SUCCESSFUL \n======"
