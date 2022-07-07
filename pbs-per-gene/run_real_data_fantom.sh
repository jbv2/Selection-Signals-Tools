echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_gulf" \
  --pop_1 "central_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90_derived/fantom/central_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_mayan" \
  --pop_1 "central_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90_derived/fantom/central_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_north" \
  --pop_1 "central_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90_derived/fantom/central_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_oaxaca" \
  --pop_1 "central_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90_derived/fantom/central_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_central" \
  --pop_2 "central_western" \
  --pop_1 "central_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90_derived/fantom/central_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_gulf" \
  --pop_2 "gulf_central" \
  --pop_1 "gulf_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/gulf_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_gulf" \
  --pop_2 "gulf_mayan" \
  --pop_1 "gulf_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90_derived/fantom/gulf_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_gulf" \
  --pop_2 "gulf_north" \
  --pop_1 "gulf_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90_derived/fantom/gulf_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_gulf" \
  --pop_2 "gulf_oaxaca" \
  --pop_1 "gulf_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90_derived/fantom/gulf_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_gulf" \
  --pop_2 "gulf_western" \
  --pop_1 "gulf_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90_derived/fantom/gulf_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_central" \
  --pop_1 "mayan_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/mayan_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_gulf" \
  --pop_1 "mayan_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90_derived/fantom/mayan_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_central" \
  --pop_1 "mayan_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90_derived/fantom/mayan_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_oaxaca" \
  --pop_1 "mayan_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90_derived/fantom/mayan_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_mayan" \
  --pop_2 "mayan_western" \
  --pop_1 "mayan_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90_derived/fantom/mayan_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_central" \
  --pop_1 "north_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/north_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_gulf" \
  --pop_1 "north_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90_derived/fantom/north_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_mayan" \
  --pop_1 "north_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90_derived/fantom/north_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_oaxaca" \
  --pop_1 "north_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90_derived/fantom/north_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_north" \
  --pop_2 "north_western" \
  --pop_1 "north_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90_derived/fantom/north_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_central" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/oaxaca_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_gulf" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90_derived/fantom/oaxaca_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_mayan" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "mayan_chb" \
  --output_dir real-data/results90_derived/fantom/oaxaca_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_north" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90_derived/fantom/oaxaca_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_western" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_oaxaca" \
  --pop_2 "oaxaca_western" \
  --pop_1 "oaxaca_chb" \
  --pop_3 "western_chb" \
  --output_dir real-data/results90_derived/fantom/oaxaca_western \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_central" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_central" \
  --pop_1 "western_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/western_central \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_gulf" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_gulf" \
  --pop_1 "western_chb" \
  --pop_3 "gulf_chb" \
  --output_dir real-data/results90_derived/fantom/western_gulf \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_mayan" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_mayan" \
  --pop_1 "western_chb" \
  --pop_3 "central_chb" \
  --output_dir real-data/results90_derived/fantom/western_mayan \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_north" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_north" \
  --pop_1 "western_chb" \
  --pop_3 "north_chb" \
  --output_dir real-data/results90_derived/fantom/western_north \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======" \
&& echo -e "======\n NF execution \n======" \
&& nextflow run pbs_per_gene.nf \
        --vcffile "real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.vcf.gz" \
        --ref_gene "real-data/reference/fantom_export.tsv" \
        --pop_ingroup "real-data/reference/pop90_oaxaca" \
        --pop_outgroup "real-data/reference/pop_chb" \
        --pop_target "real-data/reference/pop90_western" \
  --pop_2 "western_oaxaca" \
  --pop_1 "western_chb" \
  --pop_3 "oaxaca_chb" \
  --output_dir real-data/results90_derived/fantom/western_oaxaca \
        -resume \
        -with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
        -with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
&& echo -e "======\n MXB Population Branch Statistics per feature calculator: Pipeline SUCCESSFUL \n======"
