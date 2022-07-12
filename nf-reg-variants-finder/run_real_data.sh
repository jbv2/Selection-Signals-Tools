#!/bin/bash
		echo -e "======\n Running NF execution for all dataset \n======" \
		&& nextflow run find_reg_variants.nf \
			--vcffile real-data/data/MXB_1KG_IBS_CHB_aa_REALderived_90NatAm.mesoamerican_lncrnas_top1.vcf.gz \
			--cadd_reference real-data/reference/whole_genome_SNVs.tsv.gz \
		  --gwava real-data/reference/gwava_scores.bed.gz \
		  --fathmm_mkl_reference real-data/reference/fathmm-MKL_Current.tab.gz \
		  --linsight_score real-data/reference/LINSIGHT_GRCh37_hg19.bed.gz \
		  --gwrvis_score real-data/reference/gwrvisGRCh37_hg19.bed.gz \
		  --jarvis_score real-data/reference/jarvis_GRCh37_hg19.bed.gz \
			--genome_reference real-data/reference/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz \
			--gnomad_reference /data/reference_panels/gnomAD/gnomad.genomes.r2.1.1.sites.vcf.bgz \
			--genehancer_reference real-data/reference/geneHancer_GRCh37.bed.gz \
			--gwascatalog_reference real-data/reference/gwascatalog_GRCh37.vcf.gz \
			--gwasmxb_saige_reference real-data/reference/gwas_mxb_saige_GRCh37.vcf.gz \
		  --gwasmxb_bolt_reference real-data/reference/gwas_mxb_bolt_GRCh37.vcf.gz \
		  --ihs_value real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.ihs_top1.bed.gz \
			--xp_ehh_value real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.xpehh_top1.bed.gz \
			--pbs_per_snp real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.pbs_snp.bed.gz \
			--pbs_per_gene_ensembl real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.pbs_per_gene_ensembl_top1.bed.gz \
			--pbs_per_gene_fantom real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.pbs_per_gene_fantom_top1.bed.gz \
			--pbs_per_gene_genehancer real-data/reference/MXBiobank_complete_phase_ancestral_90NatAm.pbs_per_gene_genehancer_top1.bed.gz \
		  --fantomcat_reference real-data/reference/FANTOM_CAT.lv4.only_lncRNA_consensus.bed.gz \
			--lncrna_promoters_reference real-data/reference/lncRNAs_promoters.bed.gz \
		  --phylop100_reference real-data/reference/hg19.100way.phyloP100way.bw \
		  --phastcons_reference real-data/reference/hg19.100way.phastCons.bw \
		  --synonyms real-data/reference/chr_synonyms.txt \
			--gene_info_fantom real-data/reference/gene.info.FANTOM.tsv \
			--chr_length real-data/reference/human19_chr.bed \
		  --vcf_info_field "ANN" \
		  --species "homo_sapiens" \
		  --buffer_size "10000" \
		  --fork_vep "1" \
		  --output_dir real-data/results_mesoamerican_lncrnas/ \
			-resume \
			-with-report real-data/results/`date +%Y%m%d_%H%M%S`_report.html \
			-with-dag real-data/results/`date +%Y%m%d_%H%M%S`.DAG.html \
		&& echo -e "======\n Reg variants finder: Pipeline SUCCESSFUL \n======"
