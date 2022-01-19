##Example for ihs and xp-ehh using test-data
##Judith Ballesteros
#------

##Loading libraries
library(rehh)
library("vcfR") ## For reading VCFs
library("R.utils") ## For reading compressed VCFs
library("dplyr")
library(qqman)
#library(RColorBrewer)
library("QCEWAS")
options(warn=-1)
args = commandArgs(trailingOnly=TRUE)

## Load args´
## For debuggin only.
## Comment for running in mk
 # args[1] <- 21
 # args[2] <- "test/data/test_chrom"
 # args[3] <- ".vcf.gz"
 # args[4] <- "MXB"
 # args[5] <- "PEL"
 # args[6] <- "test/data/MXBiobank_complete_phase.xpehh.tsv"
 # args[7] <- "test/reference/test_1000g_"
 # args[8] <- ".vcf.gz"

##Assign args
chrom <- args[1]
stem <- args[2]
end_file <- args[3]
first_pop <- args[4]
second_pop <- args[5]
xpehh_table <- args[6]
outliers_xpehh <- gsub(xpehh_table,
                     pattern = ".xpehh.tsv",
                     replacement = ".xp_ehh_outliers.tsv")
xpehh_qqman_table <- gsub(xpehh_table,
                     pattern = ".xpehh.tsv",
                     replacement = ".xp_ehh_qqman.tsv")
stem_ingroup <- args[7]
end_file_ingroup <- args[8]


##XP-EHH
## For paralellizing from mkfile, we will calculate statistic per chromosome and in other module, concatenate results.

## Reading VCFs and calculating EHH per chromosome in first population
# haplotype file name for each chromosome
hh <- data2haplohh(hap_file = paste(stem,
                                    end_file,
                                    sep = ""),
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table",
                     haplotype.in.columns = T,
                     remove_multiple_markers = T)
# perform scan on a single chromosome (calculate iHH values)
scan <- scan_hh(hh)

## Reading VCFs and calculating EHH per chromosome in ingroup
# haplotype file name for each chromosome
hh <- data2haplohh(hap_file = paste(stem_ingroup,
                                    chrom,
                                    end_file_ingroup,
                                    sep = ""),
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table",
                     remove_multiple_markers = T, haplotype.in.columns = T)
# perform scan on a single chromosome (calculate iHH values)
scan_ingroup <- scan_hh(hh)

# Calculate XP-EHH
xpehh.mxb_pel <- ies2xpehh(scan_pop1 =  scan,
                           scan_pop2 =  scan_ingroup,
                           popname1 = first_pop,
                           popname2 = second_pop,
                           include_freq = F)

## Detecting outliers for XP-EHH
cr.mxb_xp_ehh <- calc_candidate_regions(xpehh.mxb_pel,
                                        threshold = 4,
                                        pval = TRUE,
                                        window_size = 1E6,
                                        overlap = 1E5,
                                        min_n_extr_mrk = 2)


##Save results to tables
write.table(x = xpehh.mxb_pel,
            file = xpehh_table,
            quote = F,
            sep = "\t")
write.table(x = cr.mxb_xp_ehh,
            file = outliers_xpehh,
            quote = F,
            sep = "\t")

# create new data frame for qqman
wgscan.xpehh.qqman <- data.frame(
  CHR = as.integer(xpehh.mxb_pel$CHR),
  # chromosomes as integers
  BP = xpehh.mxb_pel$POSITION,         # base pairs
  P = 10**(-xpehh.mxb_pel$LOGPVALUE),  # transform back to p-values
  SNP = row.names(xpehh.mxb_pel)       # SNP names
)

wgscan.xpehh.qqman <- wgscan.xpehh.qqman %>%
  filter(P != "NA")

## Saving qqman data as table
write.table(x = wgscan.xpehh.qqman,
            file = xpehh_qqman_table,
            quote = F,
            sep = "\t", row.names = F)

