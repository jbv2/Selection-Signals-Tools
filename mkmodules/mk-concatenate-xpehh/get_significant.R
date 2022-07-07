## ---------------------------
##
## Script name: Get significant
##
## Purpose of script: This script takes rehh results and keep  p < 0.01
##
## Author: Judith Ballesteros-Villascán
##
## Date Created: "2022-07-06"
##
## Copyright (c) Judith Ballesteros, "2022-07-06"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: NONE
##
## ---------------------------

##Loading libraries
library("dplyr")
args = commandArgs(trailingOnly=TRUE)

## Load args
## For debuggin only.
## Comment for running in mk
# args[1] <- "test/data/xp_ehh_results.csv"

##Assign args
input <- args[1]
output <- gsub(pattern = ".csv", replacement = "_top1.csv", x = input)

input.df <- read.table(file = input, header = T, sep = "\t", stringsAsFactors = F)

##Filter by p value
significant <- input.df %>%
  filter(P < 0.01)

##Save results 
write.table(x = significant, file = output, quote = F, sep = "\t", row.names = F)
