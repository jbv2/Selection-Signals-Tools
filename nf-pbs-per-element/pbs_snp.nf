#!/usr/bin/env nextflow

/*================================================================
The RegRNALab presents...
  The "MXB Population Branch Statistics per element calculator"
- A pipeline to run PBS per gene per genomic element
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
	_pre3a_get_fst_for_ingroup_outgroup_snp
	_pre3b_get_fst_for_target_ingroup_snp
	_pre3c_get_fst_for_target_outgroup_snp

Core-processing:
	_002_calculate_pbs_per_snp


================================================================*/

/* Define the help message as a function to call when needed *//////////////////////////////
def helpMessage() {
	log.info"""
  ==========================================
  The PBS per element calculator
  - A pipeline for running PBS per gene or genomic feature (as lncRNA or enhancers)
  v${version}
  ==========================================
	Usage:
  nextflow run pbs_per_element.nf --vcffile <path to input 1> [--output_dir path to results ]
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
	  --version        <- Show Pipeline version
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
pipeline_name = "MXB-PBSsnp"

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
	println "MXB PBS per element v${version}"
	exit 0
}

/*//////////////////////////////
  Define the Nextflow version under which this pipeline was developed or successfuly tested
  Updated by jballesteros at JULY 2022
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
  " For more information, execute: nextflow run pbs_per_element.nf --help"
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
The MXB PBS snp calculator
- A pipeline for running PBS per snp
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
pop_target = Channel.fromPath("${params.pop_target}*")
pop_ingroup = Channel.fromPath("${params.pop_ingroup}*")
pop_outgroup = Channel.fromPath("${params.pop_outgroup}*")
pop_1 = Channel.fromPath("${params.pop_1}*")
pop_2 = Channel.fromPath("${params.pop_2}*")
pop_3 = Channel.fromPath("${params.pop_3}*")

/* mix channels for params */
pop_target
.mix(pop_ingroup
  ,pop_outgroup
  ,pop_1
  ,pop_2
  ,pop_3)
.toList()
.set{ pops }

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
	file mk_files from mkfiles_pre1


	output:
	file "*_chrom*.vcf.gz" into results_pre1_extract_autosomes_3b, results_pre1_extract_autosomes_3a, results_pre1_extract_autosomes_3c

	"""
	bash runmk.sh
	"""

}


/* _pre3a_get_fst_for_ingroup_outgroup_snp */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-get-fst-for-ingroup_outgroup-snp/*")
	.toList()
	.set{ mkfiles_pre3a }

process _pre3a_get_fst_for_ingroup_outgroup_snp {

	publishDir "${intermediates_dir}/_pre3a_get_fst_for_ingroup_outgroup_snp/",mode:"symlink"

	input:
	file vcf from results_pre1_extract_autosomes_3a
	file populations from pops
	file mk_files from mkfiles_pre3a


	output:
	file "*.fst" into results_pre3a_get_fst_per_snp

	"""
  export POP_INGROUP="${get_baseName(params.pop_ingroup)}"
  export POP_OUTGROUP="${get_baseName(params.pop_outgroup)}"
  export POP_2="${params.pop_2}"
  export POP_3="${params.pop_3}"
	bash runmk.sh
	"""

}

/* _pre3b_get_fst_for_target_ingroup_snp */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-get-fst-for-target_ingroup-snp/*")
	.toList()
	.set{ mkfiles_pre3b }

process _pre3b_get_fst_for_target_ingroup_snp {

	publishDir "${intermediates_dir}/_pre3b_get_fst_for_target_ingroup_snp/",mode:"symlink"

	input:
	file vcf from results_pre1_extract_autosomes_3b
	file populations from pops
	file mk_files from mkfiles_pre3b


	output:
	file "*.fst" into results_pre3b_get_fst_per_snp

	"""
  export POP_INGROUP="${get_baseName(params.pop_ingroup)}"
  export POP_TARGET="${get_baseName(params.pop_target)}"
  export POP_2="${params.pop_2}"
  export POP_1="${params.pop_1}"
	bash runmk.sh
	"""

}

/* _pre3c_get_fst_for_target_outgroup_snp */
/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-get-fst-for-target_outgroup-snp/*")
	.toList()
	.set{ mkfiles_pre3c }

process _pre3c_get_fst_for_target_outgroup_snp {

	publishDir "${intermediates_dir}/_pre3c_get_fst_for_target_outgroup_snp/",mode:"symlink"

	input:
	file vcf from results_pre1_extract_autosomes_3c
	file populations from pops
	file mk_files from mkfiles_pre3c


	output:
	file "*.fst" into results_pre3c_get_fst_per_snp

	"""
  export POP_OUTGROUP="${get_baseName(params.pop_outgroup)}"
  export POP_TARGET="${get_baseName(params.pop_target)}"
  export POP_3="${params.pop_3}"
  export POP_1="${params.pop_1}"
	bash runmk.sh
	"""

}


/* _002_calculate_pbs_per_snp */
/* Gather fst results  */
	results_pre3a_get_fst_per_snp
  .mix(results_pre3b_get_fst_per_snp
		,results_pre3c_get_fst_per_snp)
  .collect()
  .set{ inputs_for_002 }

/* Read mkfile module files */
Channel
	.fromPath("${workflow.projectDir}/mkmodules/mk-calculate-pbs-per-snp/*")
	.toList()
	.set{ mkfiles_002 }

process _002_calculate_pbs_per_snp {

	publishDir "${results_dir}/_002_calculate_pbs_per_snp/",mode:"copy"

	input:
	file fst from inputs_for_002
	file populations from pops
	file mk_files from mkfiles_002


	output:
	file "*.bed" into results_002_calculate_pbs_per_snp

	"""
	export POP_1="${params.pop_1}"
	export POP_2="${params.pop_2}"
	export POP_3="${params.pop_3}"
	bash runmk.sh
	"""

}
