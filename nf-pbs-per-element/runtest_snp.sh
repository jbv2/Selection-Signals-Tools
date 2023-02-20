echo -e "======\n Testing NF execution just for SNPs \n======" \
&& rm -rf test/results/ \
&& nextflow run pbs_snp.nf \
	--vcffile "test/data/test_data.vcf.gz" \
	--pop_outgroup "test/reference/ibs.pop" \
	--pop_ingroup "test/reference/chb.pop" \
	--pop_target "test/reference/mxb.pop" \
  --pop_1 "mxb" \
  --pop_2 "chb" \
  --pop_3 "ibs" \
  --output_dir test/results-snp \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per SNP: Basic pipeline TEST SUCCESSFUL \n======"
