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
 # args[1] <- 21
 # args[2] <- "./test/data/test_data_chrom21.vcf.gz"
 # args[3] <- "MXB"
 # args[4] <- "PEL"
 # args[5] <- "./test/data/MXBiobank_complete_phase.xpehh.tsv"
 # args[6] <- "./test/reference/test_1000g_"
 # args[7] <- ".vcf.gz"
 # args[8] <- "2"
 # args[9] <- "./test/data/test_data_chrom21.rsid"

##Assign args
chrom <- args[1]
prereq <- args[2]
first_pop <- args[3]
second_pop <- args[4]
xpehh_table <- args[5]
outliers_xpehh <- gsub(xpehh_table,
                     pattern = ".xpehh.tsv",
                     replacement = ".xp_ehh_outliers.tsv")
# xpehh_qqman_table <- gsub(xpehh_table,
#                      pattern = ".xpehh.tsv",
#                      replacement = ".xp_ehh_qqman.tsv")
stem_ingroup <- args[6]
end_file_ingroup <- args[7]
threads_xp_ehh <- args[8]
rsid <- args[9]


##XP-EHH
## For paralellizing from mkfile, we will calculate statistic per chromosome and in other module, concatenate results.

## Reading VCF and calculating EHH per chromosome in first population
hh <- data2haplohh(hap_file = prereq,
                   polarize_vcf = TRUE,
                   vcf_reader = "data.table",
                   haplotype.in.columns = T,
                   remove_multiple_markers = T, )
# perform scan on a single chromosome (calculate iHH values)
scan <- scan_hh(hh, phased = T, polarized = T, threads = threads_xp_ehh)

# ## Reading VCFs and calculating EHH per chromosome in ingroup
# # haplotype file name for each chromosome
hh <- data2haplohh(hap_file = paste(stem_ingroup,
                                    chrom,
                                    end_file_ingroup,
                                    sep = ""),
                   polarize_vcf = TRUE,
                   vcf_reader = "data.table",
                   haplotype.in.columns = T,
                   remove_multiple_markers = T)
# perform scan on a single chromosome (calculate iHH values)
scan_ingroup <- scan_hh(hh, phased = T, polarized = T, threads = threads_xp_ehh)

# Calculate XP-EHH
xpehh.mxb_pel <- ies2xpehh(scan_pop1 =  scan,
                           scan_pop2 =  scan_ingroup,
                           popname1 = first_pop,
                           popname2 = second_pop,
                           include_freq = F)

## Detecting outliers for XP-EHH
cr.mxb_xp_ehh <- calc_candidate_regions(xpehh.mxb_pel,
                                        threshold = 3,
                                        pval = TRUE,
                                        window_size = 1E6,
                                        overlap = 1E5,
                                        min_n_extr_mrk = 2)

rsid.df <- read.table(file = rsid, header = F, sep = "\t", stringsAsFactors = F) %>%
  rename(CHR=V1, BP=V2, rsID=V3) %>%
  mutate(CHR=as.character(CHR))

# create new data frame for qqman
wgscan.xpehh.qqman <- data.frame(
  CHR = as.character(xpehh.mxb_pel$CHR),
  # chromosomes as integers
  BP = xpehh.mxb_pel$POSITION,         # base pairs
  P = 10**(-xpehh.mxb_pel$LOGPVALUE),  # transform back to p-values
  SNP = row.names(xpehh.mxb_pel)       # SNP names
)

## Filtering NA 
wgscan.xpehh.qqman <- wgscan.xpehh.qqman %>%
  filter(P != "NA") %>%
  left_join(y = rsid.df, by = c("CHR","BP")) %>%
  select(-SNP) %>%
  rename(SNP=rsID, POSITION=BP)

## Merging qqman and rehh dataframes
xp_results <- inner_join(xpehh.mxb_pel, wgscan.xpehh.qqman, c("CHR", "POSITION"))

##Save results to tables
write.table(x = xp_results,
            file = xpehh_table,
            quote = F,
            sep = "\t", row.names = F)
write.table(x = cr.mxb_xp_ehh,
            file = outliers_xpehh,
            quote = F,
            sep = "\t", row.names = F)
