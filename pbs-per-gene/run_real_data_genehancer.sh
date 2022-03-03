echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_enhncer.nf \
	--vcffile "real-data/data/Central_Gulf_CHB_aa_derived_90NatAm.vcf.gz" \
	--ref_gene "real-data/reference/genehancer_export.tsv" \
	--ref_gene_A "real-data/reference/genehancer_export_A.tsv" \
	--ref_gene_B "real-data/reference/genehancer_export_B.tsv" \
	--ref_gene_C "real-data/reference/genehancer_export_C.tsv" \
	--ref_gene_D "real-data/reference/genehancer_export_D.tsv" \
	--ref_gene_E "real-data/reference/genehancer_export_E.tsv" \
	--ref_gene_F "real-data/reference/genehancer_export_F.tsv" \
	--ref_gene_G "real-data/reference/genehancer_export_G.tsv" \
	--pop_ingroup "real-data/reference/pop90_gulf" \
	--pop_outgroup "real-data/reference/pop_chb" \
	--pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_gulf" \
  --pop_1 "central_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90/genehancer/central_gulf \
	-resume \
	-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
