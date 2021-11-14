echo -e "======\n NF execution \n======" \
&& rm -rf real-data/results/ \
&& nextflow run pbs_per_snp.nf \
	--vcffile "real-data/data/MXB_1KG_IBS_CHB.vcf.gzMXB_1KG_IBS_CHB_aa_derived.vcf.gz" \
	--pop_outgroup "real-data/reference/pop_chb" \
	--pop_ingroup "real-data/reference/pop_ibs" \
	--pop_target "real-data/reference/pop_mxb" \
	--pop_1 "mxb_chb" \
	--pop_2 "mxb_ibs" \
	--pop_3 "ibs_chb" \
	--output_dir real-data/results/ \
	-resume \
	-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
	&& echo -e "======\n MXB Population Branch Statistics per SNP: Pipeline SUCCESSFUL \n======"
