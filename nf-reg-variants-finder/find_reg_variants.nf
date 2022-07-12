#!/usr/bin/env nextflow

/*================================================================
The RegRNALab presents...
  The "Regulatory Variants Finder" Pipeline
- A functional effect prediction tool
==================================================================
Version: 0.1.0
Project repository: git clone https://github.com/jbv2/Selection-Signals-Tools.git
==================================================================
Authors:
- Bioinformatics Design
 Judith Ballesteros-Villascán (judith.vballesteros@gmail)
- Bioinformatics Development
 Judith Ballesteros-Villascán (judith.vballesteros@gmail)
- Nextflow Port
 Judith Ballesteros-Villascán (judith.vballesteros@gmail)

 June 2022
=============================
Pipeline Processes In Brief:
.
Pre-processing:
  _pre1_extract_chromosomes
	_pre2_split_chromosomes
  _pre3_untangle_multiallelic
Core-processing:
  _001_run_vep
  _002_rejoin_chromosomes
	_003_get_GeneHancer
	_004_get_FANTOM_CAT
	_005_get_promoters_lncRNAs_variants
	_006_get_GWASCatalog
	_007_get_GWASmxb
Pos-processing
	_pos1_vcf2tsv
	_pos2_organize_vcfs
	_pos3_get_lncRNAs_introns_exons
	_pos4_get_enhancers_promoters
	_pos5_plot_venn_variants_elements ##TO DO
	_pos6_plot_overview ##TO DO
	_pos7_plot_gwasc_traits_per_element ##TODO

================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The Regulatory Variants Finder Pipeline
  - A functional effect prediction tool
  v${version}
  ==========================================
	Usage:
  nextflow run vep-annotator.nf --vcffile <path to input 1> [--output_dir path to results ]
	  --vcffile    <- compressed vcf file for annotation;
				accepted extension is vcf.gz;
				vcf file must have a TABIX index with .tbi extension, located in the same directory as the vcf file
	  --output_dir     <- directory where results, intermediate and log files will bestored;
				default: same dir where --query_fasta resides
	  -resume	   <- Use cached results if the executed project has been run before;
				default: not activated
				This native NF option checks if anything has changed from a previous pipeline execution.
				Then, it resumes the run from the last successful stage.
				i.e. If for some reason your previous run got interrupted,
				running the -resume option will take it from the last successful pipeline stage
				instead of starting over
				Read more here: https://www.nextflow.io/docs/latest/getstarted.html#getstart-resume
	  --help           <- Shows Pipeline Information
	  --version        <- Show ExtendAlign version
	""".stripIndent()
}

/*//////////////////////////////
  Define pipeline version
  If you bump the number, remember to bump it in the header description at the begining of this script too
*/
version = "0.0.3"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "RegVarFinder"

/*
  Initiate default values for parameters
  to avoid "WARN: Access to undefined parameter" messages
*/
params.vcffile = false  //if no inputh path is provided, value is false to provoke the error during the parameter validation block
params.help = false //default is false to not trigger help message automatically at every run
params.version = false //default is false to not trigger version message automatically at every run

/*//////////////////////////////
  If the user inputs the --help flag
  print the help message and exit pipeline
*/
if (params.help){
	helpMessage()
	exit 0
}

/*//////////////////////////////
  If the user inputs the --version flag
  print the pipeline version
*/
if (params.version){
	println "Regulatory Variants Finder v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by jballesteros at JUNE 2021
*/
nextflow_required_version = '20.10.0'
/*
  Try Catch to verify compatible Nextflow version
  If user Nextflow version is lower than the required version pipeline will continue
  but a message is printed to tell the user maybe it's a good idea to update her/his Nextflow
*/
try {
	if( ! nextflow.version.matches(">= $nextflow_required_version") ){
		throw GroovyException('Your Nextflow version is older than Pipeline required version')
	}
} catch (all) {
	log.error "-----\n" +
			"  This pipeline requires Nextflow version: $nextflow_required_version \n" +
      "  But you are running version: $workflow.nextflow.version \n" +
			"  The pipeline will continue but some things may not work as intended\n" +
			"  You may want to run `nextflow self-update` to update Nextflow\n" +
			"============================================================"
}

/*//////////////////////////////
  INPUT PARAMETER VALIDATION BLOCK
  TODO (jballesteros) NOT NOW
*/

/* Check if vcffile provided
    if they were not provided, they keep the 'false' value assigned in the parameter initiation block above
    and this test fails
*/
if ( !params.vcffile ) {
  log.error " Please provide both, the --vcffile \n\n" +
  " For more information, execute: nextflow run find_reg_variants.nf --help"
  exit 1
}

/*
Output directory definition
Default value to create directory is the parent dir of --vcffile
*/
params.output_dir = file(params.vcffile).getParent()

/*
  Results and Intermediate directory definition
  They are always relative to the base Output Directory
  and they always include the pipeline name in the variable (pipeline_name) defined by this Script
  This directories will be automatically created by the pipeline to store files during the run
*/
results_dir = "${params.output_dir}/${pipeline_name}-results/"
intermediates_dir = "${params.output_dir}/${pipeline_name}-intermediate/"

/*
Useful functions definition
*/
/* define a function for extracting the file name from a full path */
/* The full path will be the one defined by the user to indicate where the reference file is located */
def get_baseName(f) {
	/* find where is the last appearance of "/", then extract the string +1 after this last appearance */
  	f.substring(f.lastIndexOf('/') + 1);
}


/*//////////////////////////////
  LOG RUN INFORMATION
*/
log.info"""
==========================================
The Regulatory Variants Finder Pipeline
- A functional effect prediction tool
v${version}
==========================================
"""
log.info "--Nextflow metadata--"
/* define function to store nextflow metadata summary info */
def nfsummary = [:]
/* log parameter values beign used into summary */
/* For the following runtime metadata origins, see https://www.nextflow.io/docs/latest/metadata.html */
nfsummary['Resumed run?'] = workflow.resume
nfsummary['Run Name']			= workflow.runName
nfsummary['Current user']		= workflow.userName
/* string transform the time and date of run start; remove : chars and replace spaces by underscores */
nfsummary['Start time']			= workflow.start.toString().replace(":", "").replace(" ", "_")
nfsummary['Script dir']		 = workflow.projectDir
nfsummary['Working dir']		 = workflow.workDir
nfsummary['Current dir']		= workflow.launchDir
nfsummary['Launch command'] = workflow.commandLine
log.info nfsummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "\n\n--Pipeline Parameters--"
/* define function to store nextflow metadata summary info */
def pipelinesummary = [:]
/* log parameter values beign used into summary */
pipelinesummary['VCFfile']			= params.vcffile
// pipelinesummary['vars per chunk']			= params.variants_per_chunk
pipelinesummary['REF: vep']			= params.vep_cache
pipelinesummary['vep gversion']			= params.vep_genome_version
pipelinesummary['REF: genome']			= params.genome_reference
pipelinesummary['REF: gnomAD']			= params.gnomad_reference
pipelinesummary['REF: GeneHancer']			= params.genehancer_reference
pipelinesummary['REF: FANTOM CAT']			= params.fantomcat_reference
pipelinesummary['REF: GWAS catalog']			= params.gwascatalog_reference
pipelinesummary['REF: GWASmxb saige']			= params.gwasmxb_saige_reference
pipelinesummary['REF: GWASmxb bolt']			= params.gwasmxb_bolt_reference
pipelinesummary['REF: CADD']			= params.cadd_reference
pipelinesummary['REF: FATHMM-MKL']			= params.fathmm_mkl_reference
pipelinesummary['REF: GWAVA']			= params.gwava
pipelinesummary['REF: LINSIGHT']			= params.linsight_score
pipelinesummary['REF: gwRVIS']			= params.gwrvis_score
pipelinesummary['REF: JARVIS']			= params.jarvis_score
pipelinesummary['Results Dir']		= results_dir
pipelinesummary['Intermediate Dir']		= intermediates_dir
/* print stored summary info */
log.info pipelinesummary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "==========================================\nPipeline Start"

/*//////////////////////////////
  PIPELINE START
*/

/*
	READ INPUTS
*/

/* Load vcf files AND TABIX INDEX into channel */
Channel
  .fromPath("${params.vcffile}*")
	.toList()
  .set{ vcf_inputs }

/* _pre1_extract_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-extract-chromosomes/*")
	.toList()
	.set{ mkfiles_pre1 }

process _pre1_extract_chromosomes {

	publishDir "${intermediates_dir}/_pre2_extract_chromosomes/",mode:"symlink"

	input:
	file sample from vcf_inputs
	file mk_files from mkfiles_pre1

	output:
	file "*.subsampled*.vcf" into results_pre1_extract_chromosomes mode flatten

	"""
	bash runmk.sh
	"""

}

/* _pre2_split_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-split-chromosomes/*")
	.toList()
	.set{ mkfiles_pre2 }

process _pre2_split_chromosomes {

	publishDir "${intermediates_dir}/_pre2_split_chromosomes/",mode:"symlink"

	input:
	file sample from results_pre1_extract_chromosomes
	file mk_files from mkfiles_pre2

	output:
	file "*.chunk*.vcf" into results_pre2_split_chromosomes mode flatten

	"""
	bash runmk.sh
	"""

}

/* 	Process _pre3_untangle_multiallelic */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-untangle-multiallelic/*")
	.toList()
	.set{ mkfiles_pre3 }

process _pre3_untangle_multiallelic {

	publishDir "${intermediates_dir}/_001_untangle_multiallelic/",mode:"symlink"

	input:
	file sample from results_pre2_split_chromosomes
	file mk_files from mkfiles_pre3

	output:
	file "*.untangled_multiallelics.vcf" into results_pre3_untangle_multiallelic

	"""
	bash runmk.sh
	"""

}

/* 	Process _001_vep_extended*/
/* Get every annotation reference into a channel */
cadd_reference = Channel.fromPath("${params.cadd_reference}*")
gwava = Channel.fromPath("${params.gwava}*")
fathmm_mkl_reference = Channel.fromPath("${params.fathmm_mkl_reference}*")
linsight_score = Channel.fromPath("${params.linsight_score}*")
gwrvis_score = Channel.fromPath("${params.gwrvis_score}*")
jarvis_score = Channel.fromPath("${params.jarvis_score}*")
genome_reference = Channel.fromPath("${params.genome_reference}*")
gnomad_reference = Channel.fromPath("${params.gnomad_reference}*")
fantomcat_reference = Channel.fromPath("${params.fantomcat_reference}*")
lncrna_promoters_reference = Channel.fromPath("${params.lncrna_promoters_reference}*")
genehancer_reference = Channel.fromPath("${params.genehancer_reference}*")
gwascatalog_reference = Channel.fromPath("${params.gwascatalog_reference}*")
gwasmxb_saige_reference = Channel.fromPath("${params.gwasmxb_saige_reference}*")
gwasmxb_bolt_reference = Channel.fromPath("${params.gwasmxb_bolt_reference}*")
ihs_value = Channel.fromPath("${params.ihs_value}*")
xp_ehh_value = Channel.fromPath("${params.xp_ehh_value}*")
pbs_per_snp = Channel.fromPath("${params.pbs_per_snp}*")
pbs_per_gene_ensembl = Channel.fromPath("${params.pbs_per_gene_ensembl}*")
pbs_per_gene_fantom = Channel.fromPath("${params.pbs_per_gene_fantom}*")
pbs_per_gene_genehancer = Channel.fromPath("${params.pbs_per_gene_genehancer}*")
phylop100_reference = Channel.fromPath("${params.phylop100_reference}*")
phastcons_reference = Channel.fromPath("${params.phastcons_reference}*")
synonyms = Channel.fromPath("${params.synonyms}*")
vcf_info_field = Channel.fromPath("${params.vcf_info_field}*")
species = Channel.fromPath("${params.species}*")
buffer_size = Channel.fromPath("${params.buffer_size}*")
fork_vep = Channel.fromPath("${params.fork_vep}*")
vep_cache = Channel.fromPath("${params.vep_cache}*")
vep_genome_version = Channel.fromPath("${params.vep_genome_version}*")

/* mix channels for VEP required references */
cadd_reference
	.mix(genome_reference
		,gnomad_reference
		,fantomcat_reference
		,lncrna_promoters_reference
		,genehancer_reference
		,gwascatalog_reference
		,gwasmxb_saige_reference
		,gwasmxb_bolt_reference
		,gwava
    ,fathmm_mkl_reference
    ,linsight_score
    ,gwrvis_score
    ,jarvis_score
		,ihs_value
		,xp_ehh_value
		,pbs_per_snp
		,pbs_per_gene_ensembl
		,pbs_per_gene_fantom
		,pbs_per_gene_genehancer
		,phylop100_reference
		,phastcons_reference
		,synonyms
		,vcf_info_field
		,species
		,buffer_size
		,fork_vep
		,vep_cache
		,vep_genome_version
	)
	.toList()
	.set{ references_for_VEP }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-run-vep/*")
	.toList()
	.set{ mkfiles_001 }

process _001_run_vep {

	publishDir "${intermediates_dir}/_001/",mode:"symlink"

	input:
	file sample from results_pre3_untangle_multiallelic
	file refs from references_for_VEP
	file mk_files from mkfiles_001

	output:
	file "*.vep.vcf" into results_001_vep_extended mode flatten

	"""
	export VEP_CACHE="${params.vep_cache}"
	export VEP_GENOME_VERSION="${params.vep_genome_version}"
	export CADD="${get_baseName(params.cadd_reference)}"
	export FATHMM_MKL="${get_baseName(params.fathmm_mkl_reference)}"
	export GENOME_REFERENCE="${get_baseName(params.genome_reference)}"
	export GNOMAD_REFERENCE="${get_baseName(params.gnomad_reference)}"
	export GENEHANCER_REFERENCE="${get_baseName(params.genehancer_reference)}"
	export GWASCATALOG_REFERENCE="${get_baseName(params.gwascatalog_reference)}"
	export GWASMXB_SAIGE_REFERENCE="${get_baseName(params.gwasmxb_saige_reference)}"
	export GWASMXB_BOLT_REFERENCE="${get_baseName(params.gwasmxb_bolt_reference)}"
	export IHS_VALUE="${get_baseName(params.ihs_value)}"
	export XP_EHH_VALUE="${get_baseName(params.xp_ehh_value)}"
	export PBS_PER_SNP="${get_baseName(params.pbs_per_snp)}"
	export PBS_PER_GENE_ENSEMBL="${get_baseName(params.pbs_per_gene_ensembl)}"
	export PBS_PER_GENE_FANTOM="${get_baseName(params.pbs_per_gene_fantom)}"
	export PBS_PER_GENE_GENEHANCER="${get_baseName(params.pbs_per_gene_genehancer)}"
	export FANTOM_REFERENCE="${get_baseName(params.fantomcat_reference)}"
	export LNCRNA_PROMOTERS_REFERENCE="${get_baseName(params.lncrna_promoters_reference)}"
	export PHYLOP100="${get_baseName(params.phylop100_reference)}"
	export PHASTCONS="${get_baseName(params.phastcons_reference)}"
	export SYNONYMS="${get_baseName(params.synonyms)}"
	export VCF_INFO_FIELD="${params.vcf_info_field}"
	export SPECIES="${params.species}"
	export BUFFER_SIZE="${params.buffer_size}"
	export FORK_VEP="${params.fork_vep}"
	export JARVIS_SCORE="${get_baseName(params.jarvis_score)}"
	export GWRVIS_SCORE="${get_baseName(params.gwrvis_score)}"
	export LINSIGHT_SCORE="${get_baseName(params.linsight_score)}"
	export GWAVA="${get_baseName(params.gwava)}"
	bash runmk.sh
	"""

}

/* _002_rejoin_chromosomes */
/* Gather every vcf */
results_001_vep_extended
  .toList()
  .set{ inputs_for_002 }

/* 	Process _002_rejoin_chromosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-rejoin-chromosomes/*")
	.toList()
	.set{ mkfiles_002 }

process _002_rejoin_chromosomes {

	publishDir "${intermediates_dir}/_002_rejoin_chromosomes/",mode:"symlink"

	input:
	file sample from inputs_for_002
	file mk_files from mkfiles_002

	output:
	file "*.vcf" into results_002_rejoin_chromosomes, results_002_rejoin_chromosomes_b, results_002_rejoin_chromosomes_c, results_002_rejoin_chromosomes_d, results_002_rejoin_chromosomes_e, results_002_rejoin_chromosomes_f mode flatten

	"""
	bash runmk.sh
	"""

}

/* _003_get_GeneHancer */
/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-GeneHancer-variants/*")
  .toList()
  .set{ mkfiles_003 }

process _003_get_GeneHancer {

	publishDir "${intermediates_dir}/_003_get_GeneHancer/",mode:"symlink"

	input:
  file vcf from results_002_rejoin_chromosomes
	file mk_files from mkfiles_003

	output:
	file "*.GeneHancer.vcf" into results_003_get_GeneHancer_a, results_003_get_GeneHancer_b mode flatten
  file "*.GeneHancer.vcf" into c003_results_for_pos1

  """
	bash runmk.sh
	"""

}

/* _004_get_FANTOM_CAT */
/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-FANTOM_CAT-variants/*")
  .toList()
  .set{ mkfiles_004 }

process _004_get_FANTOM_CAT {

	publishDir "${intermediates_dir}/_004_get_FANTOM_CAT/",mode:"symlink"

	input:
  file vcf from results_002_rejoin_chromosomes_b
	file mk_files from mkfiles_004

	output:
	file "*.fantomcat.vcf" into results_004_get_Fantom_CAT_a, results_004_get_Fantom_CAT_b mode flatten
  file "*.fantomcat.vcf" into c004_results_for_pos1

  """
	bash runmk.sh
	"""

}

/* _005_get_promoters_lncRNAs_variants */
/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-promoters-lncRNAs-variants/*")
  .toList()
  .set{ mkfiles_005 }

process _005_get_promoters_lncRNAs_variants {

	publishDir "${intermediates_dir}/_005_get_promoters_lncRNAs/",mode:"symlink"

	input:
  file vcf from results_002_rejoin_chromosomes_c
	file mk_files from mkfiles_005

	output:
	file "*.lncRNA_promoters.vcf" into results_005_get_promoters_lncRNAs_a, results_005_get_promoters_lncRNAs_b mode flatten
  file "*.lncRNA_promoters.vcf" into c005_results_for_pos1

  """
	bash runmk.sh
	"""

}

/* _006_get_GWASCatalog */
/* preprocessing inputs */
/* Gather all results for 006 */
results_003_get_GeneHancer_a
	.mix(results_004_get_Fantom_CAT_a,
		results_005_get_promoters_lncRNAs_a)
	.set{ inputs_006 }

/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-GWAScatalog-variants/*")
  .toList()
  .set{ mkfiles_006 }

process _006_get_GWASCatalog {

	publishDir "${intermediates_dir}/_006_get_GWASCatalog/",mode:"symlink"

	input:
  file vcf from inputs_006
	file mk_files from mkfiles_006

	output:
	file "*.GWAScatalog.vcf" into results_006_get_GWASCatalog mode flatten
  file "*.GWAScatalog.vcf" into c006_results_for_pos1

  """
	bash runmk.sh
	"""

}

/* _007_get_GWASmxb */
/* preprocessing inputs */
/* Gather all results for 007 */
results_003_get_GeneHancer_b
	.mix(results_004_get_Fantom_CAT_b,
		results_005_get_promoters_lncRNAs_b)
	.set{ inputs_007 }

/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-GWASmxb-variants/*")
  .toList()
  .set{ mkfiles_007 }

process _007_get_GWASmxb {

	publishDir "${intermediates_dir}/_007_get_GWASmxb/",mode:"symlink"

	input:
  file vcf from inputs_007
	file mk_files from mkfiles_007

	output:
	file "*.GWASmxb*" into results_007_get_GWASmxb mode flatten
  file "*.GWASmxb*" into c007_results_for_pos1
	"""
	bash runmk.sh
	"""

}

////////////////

/* _pos1_vcf2tsv */
/* preprocessing inputs */
/* Gather all results from 002 - 006 */
/* also include results from pre2, pre3s1, pre3s2, pre3s3, and pre3s4*/
c003_results_for_pos1
	.mix(c004_results_for_pos1, c005_results_for_pos1, c006_results_for_pos1, results_002_rejoin_chromosomes_f)
	.flatten()
	.toList()
	.into{ inputs_pos1; pre_inputs_pos2 }

/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-vcf2tsv/*")
  .toList()
  .set{ mkfiles_pos1 }

process _pos1_vcf2tsv {

	publishDir "${results_dir}/_pos1_vcf2tsv/",mode:"symlink"
	publishDir "${results_dir}/gathered_results/tsv-tables/lncRNA_promoters/",mode:"copy",pattern:"*.lncRNA_promoters.*"
	publishDir "${results_dir}/gathered_results/tsv-tables/uncategorized/",mode:"copy",pattern:"*.anno_vep.tsv*"

	input:
  file vcf from inputs_pos1
	file mk_files from mkfiles_pos1

	output:
	file "*.tsv.gz" into results_pos1_vcf2tsv, pos1_for_pos3, pos1_for_pos4, pos1_for_pos5 mode flatten
	file "*.anno_vep.tsv.gz" into nofilter_tsv_results
	file "*lncRNA_promoters.tsv.gz" into lncRNA_promoters_results

 	"""
	bash runmk.sh
	"""

}


process _pos2_organize_vcfs {

	publishDir "${results_dir}/_pos2_organize_vcfs/",mode:"symlink"
	/* Organize SNV for gathered_results*/
	publishDir "${results_dir}/gathered_results/vcf-files/",mode:"copy", pattern:"*.vcf.*"


	input:
  file vcf from pre_inputs_pos2

	output:
	file "*.vcf.gz*"

	"""
	for ifile in *.vcf; do bgzip \$ifile; tabix -p vcf \$ifile.gz; done
	"""

}

/* _pos3_get_lncRNAs_introns_exons */
/* _pos2_organize_vcfs */
pos1_for_pos3
	.flatten()
	.toList()
	.set{ inputs_pos3 }

fantomcat_reference = Channel.fromPath("${params.fantomcat_reference}*")
.toList()
.set{ fantom_ref }

/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-lncRNAs-introns-exons/*")
  .toList()
  .set{ mkfiles_pos3 }

process _pos3_get_lncRNAs_introns_exons {

	publishDir "${results_dir}/_pos3_get_lncRNAs_introns_exons/",mode:"symlink"

	input:
  file tsv from inputs_pos3
	file mk_files from mkfiles_pos3
	file reference from fantom_ref

	output:
	file "*.tsv" into results_pos3_get_lncRNAs_introns_exons, pos3_for_pos8, pos3_for_pos9, pos3_for_pos10, pos3_for_pos11, pos3_for_pos12 mode flatten
  """
	export FANTOM_REFERENCE="${get_baseName(params.fantomcat_reference)}"
	bash runmk.sh
	"""

}

/* _pos4_get_enhancers_promoters */
pos1_for_pos4
	.flatten()
	.toList()
	.set{ inputs_pos4 }

/* Read mkfile module files */
Channel
  .fromPath("${workflow.projectDir}/mkmodules/mk-get-enhancers-promoters/*")
  .toList()
  .set{ mkfiles_pos4 }

process _pos4_get_enhancers_promoters {

	publishDir "${results_dir}/_pos4_get_enhancers_promoters/",mode:"symlink"

	input:
  file tsv from inputs_pos4
	file mk_files from mkfiles_pos4

	output:
	file "*.tsv" into results_pos4_get_enhancers_promoters, pos4_for_pos10, pos4_for_pos11, pos4_for_pos12 mode flatten
  """
	bash runmk.sh
	"""

}

/* _pos5_organize_final_tsv */
results_pos3_get_lncRNAs_introns_exons
.mix(results_pos4_get_enhancers_promoters)
.set{ inputs_pos5 }


process _pos5_organize_final_tsv {

	/* Organize SNV results via publishdir multiple directives */
	publishDir "${results_dir}/gathered_results/tsv-tables/GeneHancer/",mode:"copy",pattern:"*.GeneHancer.*"
	publishDir "${results_dir}/gathered_results/tsv-tables/fantomcat/",mode:"copy",pattern:"*.fantomcat.*"

	input:
  file tsv from inputs_pos5

	output:
	file "*.tsv.gz*"

	"""
	for ifile in *.tsv; do bgzip \$ifile; done
	"""

	}
