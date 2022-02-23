echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Mayan_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_western" \
  --pop_1 "mayan_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90/fantom/mayan_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"

