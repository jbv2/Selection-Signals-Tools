# PBSprep_module

This module takes the Fst outputs of vcftools
and convert them into a unique .csv with all the information

Basic ideas:
  1. Grab .log.log and .log.weir.fst files
  2. Create a unique .csv file with all the information

## Inputs:
This module take 2 input format files

    1) Multiple .log.log files from vcftools

        Example lines:

        VCFtools - 0.1.15
        (C) Adam Auton and Anthony Marcketta 2009

        Parameters as interpreted:
        --vcf out.recode.vcf
        --chr 3
        --to-bp 197341
        --weir-fst-pop pop_chb
        --weir-fst-pop pop_pel
        --keep pop_chb
        --keep pop_pel
        --out 109707.log
        --from-bp 109707

    Keeping individuals in 'keep' list
    After filtering, kept 188 out of 252 Individuals
    Outputting Weir and Cockerham Fst estimates.
    Weir and Cockerham mean Fst estimate: 0.022853
    Weir and Cockerham weighted Fst estimate: 0.043111
    After filtering, kept 3575 out of a possible 358026 Sites
    Run Time = 18.00 seconds


    2) Multiple .log.weir.fst files from vcftools
      Example lines:

      CHROM	POS	WEIR_AND_COCKERHAM_FST
      3	196799	0.00114229
      3	196801	-nan
      3	196804	0.0265248
      3	196843	-nan
      3	196862	0.021527

## Output
A .csv file with all the fst information
    Example lines:

    "Weighted_Fst","Initial_position","Final_Position","SNP_Number","gene_lenght","SNP_by_1KB"
    0.043111,109707,197341,3575,87634,40.7946687358788
    0.033162,123563,133500,382,9937,38.4421857703532
    0.058977,196763,409417,8904,212654,41.8708324320257

#### Module Dependencies
 R:
 4.0.5 version (or more recent ones)

 RStudio:
 4.0.3 version (or more recent ones)

 RStudio packages:
 library("stringr")
 library("dplyr")
 library("tidyverse")

#### Authors
María Fernanda Mirón Toruño
