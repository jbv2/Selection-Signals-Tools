echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run pbs_per_element.nf \
	--vcffile "test/data/test_data.vcf.gz" \
	--ref_gene "test/reference/fantom_test.bed" \
	--pop_outgroup "test/reference/ibs.pop" \
	--pop_ingroup "test/reference/chb.pop" \
	--pop_target "test/reference/mxb.pop" \
  --pop_1 "mxb" \
  --pop_2 "chb" \
  --pop_3 "ibs" \
  --output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Basic pipeline TEST SUCCESSFUL \n======"
