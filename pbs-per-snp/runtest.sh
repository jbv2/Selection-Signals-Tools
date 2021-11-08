echo -e "======\n Testing NF execution \n======" \
&& rm -rf test/results/ \
&& nextflow run pbs_per_snp.nf \
	--vcffile "test/data/out.recode.vcf.gz" \
	--pop_outgroup "test/reference/pop_chb" \
	--pop_ingroup "test/reference/pop_pel" \
	--pop_target "test/reference/pop_mxl" \
  --pop_1 "mx_chb" \
  --pop_2 "mx_pel" \
  --pop_3 "pel_chb" \
  --output_dir test/results \
	-resume \
	-with-report test/results/`date +%Y%m%d_%H%M%S`_report.html \
	-with-dag test/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per snp: Basic pipeline TEST SUCCESSFUL \n======"
