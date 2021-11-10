echo -e "======\n NF execution \n======" \
&& rm -rf real-data/results/genehncer \
&& nextflow run pbs_per_gene.nf \
	--vcffile "real-data/data/MXB_1KG_IBS_CHB.vcf.gz" \
	--ref_gene "real-data/reference/genehancer_export.tsv"  \
	--pop_outgroup "real-data/reference/pop_chb" \
	--pop_ingroup "real-data/reference/pop_ibs" \
	--pop_target "real-data/reference/pop_mxb" \
  --pop_1 "mx_chb" \
  --pop_2 "mx_ibs" \
  --pop_3 "pel_chb" \
  --output_dir real-data/results/genehancer \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
