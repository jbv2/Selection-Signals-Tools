##Example for ihs and xp-ehh using test-data
##Judith Ballesteros
#------

##Loading libraries
library(rehh)
library("vcfR") ## For reading VCFs
library("R.utils") ## For reading compressed VCFs
library("dplyr")
options(warn=-1)
args = commandArgs(trailingOnly=TRUE)

## Load args´
## For debuggin only.
## Comment for running in mk
 # args[1] <- "./test/data/test_data_chrom21.vcf.gz" ## stem
 # args[2] <- "./MXBiobank_complete_phase.ihs.tsv" ##output
 # args[3] <- "5"
 # args[4] <- "./test/data/test_data_chrom21.rsid"

##Assign args
prereq <- args[1]
ihs_table <- args[2]
outliers_ihs <- gsub(ihs_table,
                     pattern = ".ihs.tsv",
                     replacement = ".ihs_outliers.tsv")
# ihs_qqman_table <- gsub(ihs_table,
#                      pattern = ".ihs.tsv",
#                      replacement = ".ihs_qqman.tsv")
threads_ihs <- args[3] 
rsid <- args[4]

##iHS

## Reading VCF and calculating EHH per chromosome in first population
  hh <- data2haplohh(hap_file = prereq,
                     polarize_vcf = TRUE,
                     vcf_reader = "data.table",
                     haplotype.in.columns = T,
                     remove_multiple_markers = T)
  # perform scan on a single chromosome (calculate iHH values)
  scan <- scan_hh(hh, phased = T, polarized = T, threads = threads_ihs)

# calculate genome-wide iHS values
wgscan.ihs <- ihh2ihs(scan)

## Detecting outliers for iHS
cr.mxb_ihs <- calc_candidate_regions(wgscan.ihs,
                                 threshold = 3,
                                 pval = TRUE,
                                 window_size = 1E6,
                                 overlap = 1E5,
                                 min_n_extr_mrk = 2)

##Converting iHS to abs
wgscan.ihs[["ihs"]][["IHS"]] <- abs(wgscan.ihs[["ihs"]][["IHS"]])

##Save results to tables
wgascan.ihs.ihs <- wgscan.ihs[["ihs"]]
wgscan.ihs.frequency_class <- wgscan.ihs[["frequency.class"]]

##Reading rsids
rsid.df <- read.table(file = rsid, header = F, sep = "\t", stringsAsFactors = F) %>%
  rename(CHR=V1, BP=V2, rsID=V3) %>%
  mutate(CHR=as.character(CHR))

##Use qqman for plotting
ihs <- wgscan.ihs$ihs
# create new data frame
wgscan.ihs.qqman <- data.frame(
  CHR = ihs$CHR, # chromosomes as character
  BP = ihs$POSITION,         # base pairs
  P = 10**(-ihs$LOGPVALUE),  # transform back to p-values
  SNP = row.names(ihs)       # SNP names
)

##Filtering NA and changing SNPs names
wgscan.ihs.qqman <- wgscan.ihs.qqman %>%
  filter(P != "NA") %>%
  left_join(y = rsid.df, by = c("CHR","BP")) %>%
  select(-SNP) %>%
  rename(SNP=rsID, POSITION=BP)

## Merging qqman and rehh dataframes
ihs_results <- inner_join(ihs, wgscan.ihs.qqman, c("CHR", "POSITION"))

##Saving results
write.table(x = ihs_results, file = ihs_table, quote = F, sep = "\t", row.names = F)
write.table(x = cr.mxb_ihs, file = outliers_ihs, quote = F, sep = "\t", row.names = F)
