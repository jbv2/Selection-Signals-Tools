## This script takes .log Fst files and prepare a file for PBS calculation

## Uploading libraries
library("stringr")
library("dplyr")
library("tidyverse")

## Read args from command line
args <- commandArgs(trailingOnly = T)

# Uncomment for debbuging
# Comment for production mode only
# args[1] <- "./test/data/" ## dir
# args[2] <- "pelvsmxl" ##output file


## Place args into named object
log_dir <- args[1]
filename <- args[2]

## Running  
graficadora <- function(logfst, snpfile){
  logfile <- readLines(logfst)
  fsnp_file <- read.table(snpfile, header = T, sep = "\t", stringsAsFactors = F)
  fst_value <- grep("Weir and Cockerham weighted Fst estimate:",logfile, value=TRUE)
  initial_bp <- grep("--from-bp",logfile, value=TRUE)
  final_bp <- grep("--to-bp",logfile, value=TRUE)
  nombres <- c("Weighted_Fst", "Initial_position", "Final_Position", "SNP_Number")
  la_data <- data.frame(fst_value, initial_bp, final_bp, nrow(fsnp_file))
  colnames(la_data) <- nombres
  fixed_data.df<- la_data %>%
    mutate(Weighted_Fst = gsub("Weir and Cockerham weighted Fst estimate: ",
                               "", Weighted_Fst)) %>%
    mutate(Initial_position = gsub("--from-bp ",
                                   "", Initial_position)) %>%
    mutate(Final_Position = gsub("--to-bp ",
                                 "", Final_Position))
  fixed_data.df <- transform(fixed_data.df, Initial_position = as.numeric(Initial_position))
  fixed_data.df <- transform(fixed_data.df, Final_Position = as.numeric(Final_Position))
  fixed_data.df <- transform(fixed_data.df, Weighted_Fst = as.numeric(Weighted_Fst))
}

pop <- filename

## Read all the files
for (variable in pop) {
  lognames <- list.files(path = log_dir, pattern = paste("*",variable,".log", sep = ""),  full.names = T)
  snpnames <- list.files(path = log_dir, pattern = paste("*",variable,".weir.fst", sep = ""), full.names = T)
  
  ## Calculating for each gen
  pruebax <- mapply(graficadora, lognames, snpnames)
  df <- data.frame(matrix(unlist(pruebax), nrow=length(lognames), byrow=TRUE),stringsAsFactors=FALSE)
  
  ## Renaming columns
  df_final <- df %>%
    rename("Weighted_Fst" = "X1",
           "Initial_position" = "X2",
           "Final_Position" = "X3",
           "SNP_Number" = "X4")
  
  
  ## Adding gene lenght and SNP´s by 1 KB
  normalized.df <- df_final %>%
    mutate(gene_lenght = Final_Position - Initial_position) %>%
    mutate(SNP_by_1KB = (1000*SNP_Number)/gene_lenght) %>%
    mutate("Gene" = sub(pattern = ".[a-z]*.log*", replacement = "", basename(lognames)))
  
  output_file <- paste(log_dir,variable,".csv", sep = "")
  
  ## Saving dataframe
  write.table(x = normalized.df, file = output_file, quote = F, row.names = FALSE, sep = "\t")
}



