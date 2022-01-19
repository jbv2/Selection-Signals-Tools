## ---------------------------
##
## Script name: PBS Calculator
##
## Purpose of script: This script can take Fst Data from VCFTools and calculate PBS values
##
## Author: Judith Ballesteros
##
## Date Created: "2021-10-26"
##
## Copyright (c) Judith Ballesteros, "2021-10-26"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: Based on Fernanda-Miron pipeline
##   
##
## ---------------------------

# Charging library
library("dplyr")
library("ggplot2")
library("ggrepel")
library("tidyr")
library("cowplot")
library("stringr")
library("patchwork")

## Read args from command line
args <- commandArgs(trailingOnly = T)

# Uncomment for debbuging
# Comment for production mode only
# args[1] <- "./test/data/"  ## Dir with CSVs of fst results
# args[2] <- "./test/results/pbs.tsv" ## Output
# args[3] <- "mx_chb"
# args[4] <- "mx_pel"
# args[5] <- "pel_chb"

## Place args into named object
file_dir <- args[1]
pbs_file <- args[2]
pop1_pattern <- args[3]
pop2_pattern <- args[4]
pop3_pattern <- args[5]

## Get all the fst.csv files in path
csv.names <- list.files(path = file_dir, pattern = "*.fst", full.names = T)

# Define a function to import and process fst output from vcftools
fst_reader<-function(filename,pops){
  fst<-read.table(file = filename, header = T, stringsAsFactors = F, sep = "\t") #read in fst output from vcftools
  fst[,1][which(is.na(fst[,1]))]<-0 #change NA's to 0, the NA's are produced by vcftools when there is no variation at a site
  assign(pops,fst,envir = .GlobalEnv) #export dataframe with pop names as variable names
}

## Getting dataframe names
pop1 <- as.list(strsplit(csv.names[1], "/") [[1]])
pop1_saved <- as.character(pop1[length(pop1)])

pop2 <- as.list(strsplit(csv.names[2], "/") [[1]])
pop2_saved <- as.character(pop2[length(pop2)])

pop3 <- as.list(strsplit(csv.names[3], "/") [[1]])
pop3_saved <- as.character(pop3[length(pop3)])

## Segment for avoiding random
## Pop1 must be 1 vs 3: i.e.: Native Mexican vs CHB
pops <- c(pop1_saved, pop2_saved, pop3_saved)
if (str_detect(string = pop1_saved, pattern = pop1_pattern) == "TRUE") {
  pop1 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop1_pattern) == "TRUE") {
    pop1 <- pop2_saved
  } else {
    pop1 <- pop3_saved
  }
}

## Pop2 must be 1 vs 2: i.e.: Native Mexican vs PEL
if (str_detect(string = pop1_saved, pattern = pop2_pattern) == "TRUE") {
  pop2 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop2_pattern) == "TRUE") {
    pop2 <- pop2_saved
  } else {
    pop2 <- pop3_saved
  }
}

## Pop3 must be 3 vs 2: i.e.: CHB vs PEL
if (str_detect(string = pop1_saved, pattern = pop3_pattern) == "TRUE") {
  pop3 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop3_pattern) == "TRUE") {
    pop3 <- pop2_saved
  } else {
    pop3 <- pop3_saved
  }
}


fst_pop1_colname <- paste(pop1_pattern,"_fst", sep = "")

## Uploading fst files
fst_pop1 <- fst_reader(filename = csv.names[1], pops = pop1 ) %>%
  rename(!!pop1_pattern := WEIR_AND_COCKERHAM_FST) 
fst_pop1[is.na(fst_pop1)] = 0
fst_pop2 <- fst_reader(filename = csv.names[2], pops = pop2 ) %>%
  rename(!!pop2_pattern := WEIR_AND_COCKERHAM_FST)
fst_pop2[is.na(fst_pop2)] = 0
fst_pop3 <- fst_reader(filename = csv.names[3], pops = pop3 ) %>%
  rename(!!pop3_pattern := WEIR_AND_COCKERHAM_FST)
fst_pop3[is.na(fst_pop3)] = 0



# Make a list of your dataframes and join them all together
fst_pop1_pop2 <- inner_join(x = fst_pop1, 
                            y = fst_pop2,
                            by = c("CHROM","POS"))
all_fst <- left_join(x = fst_pop1_pop2,
                     y = fst_pop3, 
                     by = c("CHROM", "POS")) 

# Making a function for PBS calculation
## As reported in Ávila-Arcos(2019)
#PBSnm=Tnm-chb +Tnm-ceu -Tchb-ceu/2
#T=-log(1-Fst´)
pbs.f<-function(pop1_out,pop1_pop2,pop2_out) {
  Tpop1_out= -log(1-pop1_out)
  Tpop1_pop2= -log(1-pop1_pop2)
  Tpop2_out= -log(1-pop2_out)
  pbs= (Tpop1_out + Tpop1_pop2 - Tpop2_out)/2
  pbs
}

# Running for my data
pbsresults<-pbs.f(pop1_out = all_fst[3],
              pop1_pop2 = all_fst[4],
              pop2_out = all_fst[5])

# Turn PBS into data frame and merge
pbsresults_2 <-all_fst[,1:2]
pbsresults_2 <-cbind(pbsresults_2 ,pbsresults)
pbsresults_2 <- pbsresults_2 %>% 
  rename(PBS_value = all_of(pop1_pattern))

#set negative pbs values to 0 for convenience
pbsresults_2$PBS_value[which(pbsresults_2$PBS_value<0)]<-0

# Arranging PBS values
final_dataset <- pbsresults_2 %>% 
  arrange(order_by = -PBS_value, .keep = T)

## Writting results to a table
write.table(x = final_dataset, file = pbs_file, quote = F, sep = " \t", row.names = F)

