echo -e "======\n Real data NF execution \n======" \
&& rm -rf real-data/results/ \
&& nextflow run mxb_selection_signals_tool.nf \
	--vcffile "real-data/data/MXBiobank_complete_phase.vcf.gz" \
	--min_af "0.05" \
	--geno "0.05" \
	--min_alleles "2" \
	--max_alleles "2" \
  --first_pop "MXB" \
  --second_pop "PEL" \
  --stem_ingroup "real-data/reference/PEL.chr" \
  --end_file_ingroup ".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz" \
  --output_dir real-data/results \
	-resume \
	-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Selection Signals Tool: Pipeline SUCCESSFUL \n======"
