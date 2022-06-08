echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
	--vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_derived_90NatAm.vcf.gz" \
	--ref_gene "real-data/reference/genehancer_simmulated_export.tsv" \
	--pop_ingroup "real-data/reference/pop_chb" \
	--pop_outgroup "real-data/reference/pop_ibs" \
	--pop_target "real-data/reference/pop90_mxb" \
  --pop_2 "mxb_chb" \
  --pop_1 "mxb_ibs" \
  --pop_3 "chb_ibs" \
  --output_dir real-data/results90/genehancer_simmulated/mxb_chb_ibs \
	-resume \
	-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
