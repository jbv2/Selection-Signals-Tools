echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Central_North_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_central" \
  --pop_1 "north_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90/fantom/north_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Gulf_North_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_gulf" \
  --pop_1 "north_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90/fantom/north_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Mayan_North_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_mayan" \
  --pop_1 "north_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90/fantom/north_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/North_Oaxaca_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_oaxaca" \
  --pop_1 "north_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90/fantom/north_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/North_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_western" \
  --pop_1 "north_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90/fantom/north_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Central_Oaxaca_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_central" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90/fantom/oaxaca_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Gulf_Oaxaca_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_gulf" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90/fantom/oaxaca_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Mayan_Oaxaca_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_mayan" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90/fantom/oaxaca_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/North_Oaxaca_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_north" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90/fantom/oaxaca_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Oaxaca_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_western" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90/fantom/oaxaca_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Central_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_central" \
  --pop_1 "western_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90/fantom/western_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Gulf_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_gulf" \
  --pop_1 "western_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90/fantom/western_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Mayan_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_mayan" \
  --pop_1 "western_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90/fantom/western_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/North_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_north" \
  --pop_1 "western_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90/fantom/western_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/Oaxaca_Western_CHB_aa_derived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_oaxaca" \
  --pop_1 "western_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90/fantom/western_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
