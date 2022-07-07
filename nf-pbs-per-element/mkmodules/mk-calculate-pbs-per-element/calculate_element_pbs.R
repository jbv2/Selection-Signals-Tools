## ---------------------------
##
## Script name: Calculate element PBS
##
## Purpose of script: This script can take weighted Fst data from VCFTools and calculate PBS values per element. 
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
# args[2] <- "test/data/mxb_chb_ibs_pbs.tsv" # Output pop1_pop2_pop3_pbs.tsv
# args[3] <- "mxb_ibs"
# args[4] <- "mxb_chb"
# args[5] <- "chb_ibs"

## Assign args
directory <- args[1]
pbs_results <- args[2]
pop1_pop3 <- args[3]
pop1_pop2 <- args[4]
pop2_pop3 <- args[5]
top1_bed <- gsub(pattern = ".tsv", replacement = "top1.bed", x = pbs_results)
  
pop1_pop3_wfst <- paste0(directory,pop1_pop3,".wfst")
pop1_pop2_wfst <- paste0(directory,pop1_pop2,".wfst")
pop2_pop3_wfst <- paste0(directory,pop2_pop3,".wfst")

## Read args
pop1_pop3_wfst.df <- read.csv(file = pop1_pop3_wfst,
                              header = F,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(V6=replace_na(replace = 0,
                       V6)) %>%
  rename(Chromosome="V1",
         Start="V2",
         End="V3",
         Element="V4",
         "SNP number"=V5,
         pop1_pop3="V6")

pop1_pop2_wfst.df <- read.csv(file = pop1_pop2_wfst,
                              header = F,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(V6=replace_na(replace = 0,
                       V6)) %>%
  rename(Chromosome="V1",
         Start="V2",
         End="V3",
         Element="V4",
         "SNP number"=V5,
         pop1_pop2="V6")

pop2_pop3_wfst.df <- read.csv(file = pop2_pop3_wfst,
                              header = F,
                              sep = "\t",
                              stringsAsFactors = F) %>%
  mutate(V6=replace_na(replace = 0,
                       V6)) %>%
  rename(Chromosome="V1",
         Start="V2",
         End="V3",
         Element="V4",
         "SNP number"=V5,
         pop2_pop3="V6")

## Join dataframes
Weighted_Fst <- full_join(pop1_pop3_wfst.df,
                          pop1_pop2_wfst.df,
                          c("Chromosome", "Start","End","Element","SNP number")) %>%
  full_join(pop2_pop3_wfst.df,
            c("Chromosome", "Start","End","Element","SNP number"))

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
pbs <- Weighted_Fst %>%
  mutate(PBS=get_pbs.f(Weighted_Fst$pop1_pop3,
                       Weighted_Fst$pop1_pop2,
                       Weighted_Fst$pop2_pop3)) %>%
  mutate_at(.vars = vars(contains("PBS")),
                .funs = list(~ ifelse(PBS < 0, 0, .))) %>%
  select(-pop1_pop2,-pop1_pop3, -pop2_pop3) %>%
  mutate(PBS=round(PBS, 6)) %>%
  filter(PBS != "Inf",
         PBS != "NA",
         `SNP number` != 0,
         .preserve = T)

## Saving data frame
write.table(x = pbs, file = pbs_results, quote = F, sep = " \t", row.names = F)

## Getting Top 1% 
one_percent <- round(length(pbs$PBS) * 0.01)
pbs_bed <- pbs %>%
  filter(`SNP number`<=10) %>%
  arrange(-PBS,`SNP number`) %>%
  unite(col = "INFO", c(Element,PBS,`SNP number`), sep = "_")

pbs_bed <- pbs_bed[1:one_percent,]  %>%
  arrange(as.numeric(Chromosome), Start)
write.table(x = pbs_bed, file = top1_bed, quote = F, sep = "\t", row.names = F, col.names = F)