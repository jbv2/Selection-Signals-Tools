##Example for ihs and xp-ehh using test-data
##Judith Ballesteros
#------

##Loading libraries
library(rehh)
library("vcfR") ## For reading VCFs
library("R.utils") ## For reading compressed VCFs
library("dplyr")
library("QCEWAS")
options(warn=-1)
args = commandArgs(trailingOnly=TRUE)

## Load args´
## For debuggin only.
## Comment for running in mk
 # args[1] <- 21 ## first chromosome
 # args[2] <- 22 ## last chromosome
 # args[3] <- "test/data/test_chrom" ## stem
 # args[4] <- ".vcf.gz" # extension
 # args[5] <- "./MXBiobank_complete_phase.ihs.tsv" ##output
 
##Assign args
first_chrom <- args[1]
last_chrom <- args[2]
stem <- args[3]
end_file <- args[4]
ihs_table <- args[5]
outliers_ihs <- gsub(ihs_table,
                     pattern = ".ihs.tsv",
                     replacement = ".ihs_outliers.tsv")
ihs_qqman_table <- gsub(ihs_table,
                     pattern = ".ihs.tsv",
                     replacement = ".ihs_qqman.tsv")

##iHS

## Reading VCFs and calculating EHH per chromosome in first population
for(i in first_chrom:last_chrom) {
  # haplotype file name for each chromosome
  hh <- data2haplohh(hap_file = paste(stem, i, end_file, sep = ""),
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table",
                     haplotype.in.columns = T,
                     remove_multiple_markers = T)
  # perform scan on a single chromosome (calculate iHH values)
  scan <- scan_hh(hh)
  # concatenate chromosome-wise data frames to
  # a data frame for the whole genome
  # (more efficient ways certainly exist...)
  if (i == first_chrom) {
    wgscan <- scan
  } else {
    wgscan <- rbind(wgscan, scan)
  }
}

# calculate genome-wide iHS values
wgscan.ihs <- ihh2ihs(wgscan)

## Detecting outliers for iHS
cr.mxb_ihs <- calc_candidate_regions(wgscan.ihs,
                                 threshold = 4,
                                 pval = TRUE,
                                 window_size = 1E6,
                                 overlap = 1E5,
                                 min_n_extr_mrk = 2)

##Converting iHS to abs
wgscan.ihs[["ihs"]][["IHS"]] <- abs(wgscan.ihs[["ihs"]][["IHS"]])

##Save results to tables
wgascan.ihs.ihs <- wgscan.ihs[["ihs"]]
wgscan.ihs.frequency_class <- wgscan.ihs[["frequency.class"]]

write.table(x = wgascan.ihs.ihs, file = ihs_table, quote = F, sep = "\t")
write.table(x = cr.mxb_ihs, file = outliers_ihs, quote = F, sep = "\t")

##Use qqman for plotting
ihs <- wgscan.ihs$ihs
# create new data frame
wgscan.ihs.qqman <- data.frame(
  CHR = as.integer(factor(ihs$CHR, 
                          levels = unique(ihs$CHR))),
  # chromosomes as integers
  BP = ihs$POSITION,         # base pairs
  P = 10**(-ihs$LOGPVALUE),  # transform back to p-values
  SNP = row.names(ihs)       # SNP names
)

wgscan.ihs.qqman <- wgscan.ihs.qqman %>%
  filter(P != "NA")

## Saving qqman data as table
write.table(x = wgscan.ihs.qqman, file = ihs_qqman_table, quote = F, sep = "\t", row.names = F)
