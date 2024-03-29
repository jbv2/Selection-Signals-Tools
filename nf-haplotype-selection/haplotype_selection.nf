#!/usr/bin/env nextflow

/*================================================================
The RegRNALab presents...
  The "The MXB iHS and XP-EHH calculator"
- A pipeline that runs iHS and XP-EHH
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
=============================
Pipeline Processes In Brief:
.
Pre-processing:
  _pre1_extract_autosomes
Core-processing:
  _001_run_ihs
	_002_run_xpehh
Pos-processing
	_pos1_concatenate_ihs
	_pos2_concatenate_xpehh
	_pos3_plot_ihs
	_pos4_plot_xpehh

================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The MXB iHS and XP-EHH calculator
  - A pipeline for common haplotype selection analyses
  v${version}
  ==========================================
	Usage:
  nextflow run haplotype_selection.nf --vcffile <path to input 1> [--output_dir path to results ]
	  --vcffile    <- compressed vcf file for annotation;
				accepted extension is vcf.gz;
				vcf file must have a TABIX index with .tbi extension, located in the same directory as the vcf file
	  --output_dir     <- directory where results, intermediate and log files will bestored
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
version = "0.1.0"

/*//////////////////////////////
  Define pipeline Name
  This will be used as a name to include in the results and intermediates directory names
*/
pipeline_name = "nf-haplotype-selection"

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
	println "The MXB iHS and XP-EHH calculator v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by jballesteros at OCTOBER 2021
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
The MXB iHS and XP-EHH calculator
- A pipeline for common selection analyses
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

/* Load vcf files into channel */
Channel
  .fromPath("${params.vcffile}*")
	.toList()
  .set{ vcf_inputs }

/* Get parameters into a channel */
min_af = Channel.fromPath("${params.min_af}*")
geno = Channel.fromPath("${params.geno}*")
min_alleles = Channel.fromPath("${params.min_alleles}*")
max_alleles = Channel.fromPath("${params.max_alleles}*")

/* mix channels for params */
min_af
.mix(geno
	,min_alleles
  ,max_alleles)
.toList()
.set{ parameters_for_filter }


/* _pre1_extract_autosomes */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-extract-autosomes/*")
	.toList()
	.set{ mkfiles_pre1 }

process _pre1_extract_autosomes {

	publishDir "${intermediates_dir}/_pre1_extract_autosomes/",mode:"symlink"

	input:
	file sample from vcf_inputs
	file parameters from parameters_for_filter
	file mk_files from mkfiles_pre1


	output:
	file "*_chrom*.vcf.gz" into results_pre1_for_001, results_pre1_for_002 mode flatten
	//file "*_chrom*.vcf.gz" into results_pre1_extract_autosomes mode flatten

	"""
	export MIN_AF="${params.min_af}"
  export MIN_ALLELES="${params.min_alleles}"
  export MAX_ALLELES="${params.max_alleles}"
	export GENO="${params.geno}"
	bash runmk.sh
	"""

}

/* _001_run_ihs */
/* Get parameters into a channel */
threads = Channel.fromPath("${params.threads}*")
threads
.toList()
.set{ parameters_threads }

/* 	Process _001_run_ihs */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-run-ihs/*")
	.toList()
	.set{ mkfiles_001 }

process _001_run_ihs {

	publishDir "${results_dir}/_001_run_ihs/",mode:"copy"

	input:
	file sample from results_pre1_for_001
	file mk_files from mkfiles_001
	file threads from parameters_threads

	output:
	file "*.tsv" into results_001_run_ihs mode flatten

	"""
	export THREADS="${params.threads}"
	bash runmk.sh
	"""

}

/* _002_run_xpehh */
/* Get parameters into a channel */
first_pop = Channel.fromPath("${params.first_pop}*")
second_pop = Channel.fromPath("${params.second_pop}*")
stem_ingroup = Channel.fromPath("${params.stem_ingroup}*")
end_file_ingroup = Channel.fromPath("${params.end_file_ingroup}*")

/* mix channels for VEP required references */
first_pop
.mix(second_pop
  ,stem_ingroup
  ,end_file_ingroup)
.toList()
.set{ references_for_selection }

/* 	Process _002_run_xpehh */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-run-xpehh/*")
	.toList()
	.set{ mkfiles_002 }

process _002_run_xpehh {

	publishDir "${results_dir}/_002_run_xpehh/",mode:"symlink"

	input:
	file sample from results_pre1_for_002
	file mk_files from mkfiles_002
	file refs from references_for_selection
	file threads from parameters_threads

	output:
	file "*.tsv" into results_002_run_xpehh mode flatten mode flatten

	"""
	export FIRST_POP="${params.first_pop}"
  export SECOND_POP="${params.second_pop}"
  export STEM_INGROUP="${get_baseName(params.stem_ingroup)}"
  export END_FILE_INGROUP="${params.end_file_ingroup}"
	export THREADS="${params.threads}"
	bash runmk.sh
	"""

}

/* 	Process _pos1_concatenate_ihs */
/* Gather every tsv */
results_001_run_ihs
  .toList()
  .set{ inputs_for_pos1 }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-concatenate-ihs/*")
	.toList()
	.set{ mkfiles_pos1 }

process _pos1_concatenate_ihs {

	publishDir "${intermediates_dir}/_pos1_concatenate_ihs/",mode:"copy"

	input:
	file sample from inputs_for_pos1
	file mk_files from mkfiles_pos1

	output:
	file "*.csv" into results_pos1_concatenate_ihs

	"""
	bash runmk.sh
	"""

}

/* _pos2_concatenate_xpehh */
/* Gather every tsv */
results_002_run_xpehh
  .toList()
  .set{ inputs_for_pos2 }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-concatenate-xpehh/*")
	.toList()
	.set{ mkfiles_pos2 }

process _pos2_concatenate_xpehh {

	publishDir "${intermediates_dir}/_pos2_concatenate_xpehh/",mode:"copy"

	input:
	file sample from inputs_for_pos2
	file mk_files from mkfiles_pos2

	output:
	file "*.csv" into results_pos2_concatenate_xpehh

	"""
	bash runmk.sh
	"""

}

/* 	Process _pos3_plot_ihs */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-plot-ihs/*")
	.toList()
	.set{ mkfiles_pos3 }

process _pos3_plot_ihs {

	publishDir "${results_dir}/_pos3_plot_ihs/",mode:"copy"

	input:
	file results from results_pos1_concatenate_ihs
	file mk_files from mkfiles_pos3

	output:
	file "*.png" into results_pos3_plot_ihs

	"""
	bash runmk.sh
	"""

}

/* 	Process _pos4_plot_xpehh */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-plot-xpehh/*")
	.toList()
	.set{ mkfiles_pos4 }

process _pos4_plot_xpehh {

	publishDir "${results_dir}/_pos4_plot_xpehh/",mode:"copy"

	input:
	file results from results_pos2_concatenate_xpehh
	file mk_files from mkfiles_pos4

	output:
	file "*.png" into results_pos4_plot_xpehh

	"""
	bash runmk.sh
	"""

}
