echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run mxb_selection_signals_tool.nf \
	--vcffile "test/data/test.vcf.gz" \
	--min_af "0" \
	--geno "0.001" \
	--min_alleles "0" \
	--max_alleles "100" \
  --first_pop "MXB" \
  --second_pop "PEL" \
  --stem_ingroup "test/reference/test_1000g_" \
  --end_file_ingroup ".vcf.gz" \
  --output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Selection Signals Tool: Basic pipeline TEST SUCCESSFUL \n======"
