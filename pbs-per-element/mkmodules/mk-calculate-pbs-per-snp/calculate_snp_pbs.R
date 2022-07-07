## ---------------------------
##
## Script name: Calculate PBS per SNP
##
## Purpose of script: This script can take Fst data from VCFTools and calculate PBS values. 
##
## Author: Judith Ballesteros-Villascán
##
## Date Created: "2021-10-26"
##
## Copyright (c) Judith Ballesteros, "2021-10-26"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: NONE
##
## ---------------------------

# Load libraries
library("dplyr")
library("tidyr")

## Read args from command line
args <- commandArgs(trailingOnly = T)

## For debugging only
## Comment this lines for running on mkmodule
# args[1] <- "test/data/" # Dir with weighted Fst results
# args[2] <- "test/data/mxb_chb_ibs_snp_pbs.tsv" # Output pop1_pop2_pop3_pbs.tsv
# args[3] <- "mxb_ibs"
# args[4] <- "mxb_chb"
# args[5] <- "chb_ibs"

## Assign args
directory <- args[1]
pbs_results <- args[2]
pop1_pop3 <- args[3]
pop1_pop2 <- args[4]
pop2_pop3 <- args[5]

pop1_pop3_fst <- paste0(directory,pop1_pop3,".compute")
pop1_pop2_fst <- paste0(directory,pop1_pop2,".compute")
pop2_pop3_fst <- paste0(directory,pop2_pop3,".compute")

## Read args
pop1_pop3_fst.df <- read.csv(file = pop1_pop3_fst,
                              header = T,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(pop1_pop3=replace_na(replace = 0,
                                           WEIR_AND_COCKERHAM_FST)) %>%
  select(-WEIR_AND_COCKERHAM_FST)

pop1_pop2_fst.df <- read.csv(file = pop1_pop2_fst,
                              header = T,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(pop1_pop2=replace_na(replace = 0,
                                           WEIR_AND_COCKERHAM_FST)) %>%
  select(-WEIR_AND_COCKERHAM_FST)

pop2_pop3_fst.df <- read.csv(file = pop2_pop3_fst,
                              header = T,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(pop2_pop3=replace_na(replace = 0,
                                           WEIR_AND_COCKERHAM_FST)) %>%
  select(-WEIR_AND_COCKERHAM_FST)

## Join dataframes
Fst <- full_join(pop1_pop3_fst.df,
                          pop1_pop2_fst.df,
                          c("CHROM", "POS")) %>%
  full_join(pop2_pop3_fst.df,
            c("CHROM", "POS")) %>%
  unique()

## Defining PBS function
## As reported in Ávila-Arcos(2019)
# PBSnm=(Tnm-chb +Tnm-ibs -Tchb-ibs)/2
# T=-log(1-Fst)
get_pbs.f <- function(target_outgroup,target_ingroup,ingroup_outgroup) {
  T_target_outgroup = -log(1-target_outgroup)
  T_target_ingroup = -log(1-target_ingroup)
  T_ingroup_outgroup = -log(1-ingroup_outgroup)
  PBS = (T_target_outgroup + T_target_ingroup - T_ingroup_outgroup)/2
  PBS
}

## Applying PBS function 
# Negative values are set as 0
pbs <- Fst %>%
  mutate(PBS=get_pbs.f(Fst$pop1_pop3,
                       Fst$pop1_pop2,
                       Fst$pop2_pop3)) %>%
  mutate_at(.vars = vars(contains("PBS")),
                .funs = list(~ ifelse(PBS < 0, 0, .))) %>%
  select(-pop1_pop2,-pop1_pop3, -pop2_pop3) %>%
  mutate(PBS=round(PBS, 6)) %>%
  filter(PBS != "Inf",
         PBS != "NA",
         .preserve = T) %>%
  mutate(start=POS-1, .before = POS) %>%
  arrange(as.numeric(CHROM), start, .keep = T)

## Saving data frame
write.table(x = pbs, file = pbs_results, quote = F, sep = " \t", row.names = F, col.names = F)