echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
	--vcffile "real-data/data/Central_Mayan_CHB_aa_derived_90NatAm.vcf.gz" \
	--ref_gene "real-data/reference/genehancer_export.tsv" \
	--pop_ingroup "real-data/reference/pop90_mayan" \
	--pop_outgroup "real-data/reference/pop_chb" \
	--pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_mayan" \
  --pop_1 "central_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90/genehancer/central_mayan \
	-resume \
	-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
