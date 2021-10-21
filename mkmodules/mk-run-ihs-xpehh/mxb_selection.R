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
 # args[1] <- 1
 # args[2] <- 22
 # args[3] <- "./MXBiobank_complete_phase_chrom"
 # args[4] <- ".vcf.gz"
 # args[5] <- "MXB"
 # args[6] <- "PEL"
 # args[7] <- "./MXBiobank_complete_phase.ihs.tsv"
 # args[8] <- "./PEL.chr"
 # args[9] <- ".phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"

##Assign args
first_chrom <- args[1]
last_chrom <- args[2]
stem <- args[3]
end_file <- args[4]
first_pop <- args[5]
second_pop <- args[6]
ihs_table <- args[7]
outliers_ihs <- gsub(ihs_table,
                     pattern = ".ihs.tsv",
                     replacement = ".ihs_outliers.tsv")
ihs_qqman_table <- gsub(ihs_table,
                     pattern = ".ihs.tsv",
                     replacement = ".ihs_qqman.tsv")
xp_ehh <- gsub(ihs_table,
               pattern = ".ihs.tsv",
               replacement = ".xp_ehh.tsv")
outliers_xp_ehh <- gsub(ihs_table,
                        pattern = ".ihs.tsv",
                        replacement = ".xp_ehh_outliers.tsv")
xp_ehh_qqman_table <- gsub(ihs_table,
                        pattern = ".ihs.tsv",
                        replacement = ".xp_ehh_qqman.tsv")
stem_ingroup <- args[8]
end_file_ingroup <- args[9]


##iHS

## Reading VCFs and calculating EHH per chromosome in first population
for(i in first_chrom:last_chrom) {
  # haplotype file name for each chromosome
  hh <- data2haplohh(hap_file = paste(stem, i, end_file, sep = ""),
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table")
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
#ymax_ihs <- max(wgscan.ihs[["ihs"]][["IHS"]], na.rm = T)

##Save results to tables
wgascan.ihs.ihs <- wgscan.ihs[["ihs"]]
wgscan.ihs.frequency_class <- wgscan.ihs[["frequency.class"]]

write.table(x = wgascan.ihs.ihs, file = ihs_table, quote = F, sep = "\t")
write.table(x = cr.mxb_ihs, file = outliers_ihs, quote = F, sep = "\t")

## Plot iHS values
# palette(brewer.pal(name = "Set2", n = 8))
# 
# png(filename = "./mxb_ihs.png", width = 14, height = 10, units = "cm", res = 300)
# manhattanplot(wgascan.ihs.ihs, threshold = c(2, -2), cr = cr.mxb_ihs, cr.lab.cex = 0, ylab = "abs(iHS)", main = "iHS (MXB)",
#               ylim = c(0.15, ymax_ihs+.5))
# dev.off()

## Plot iHS pvals
#png(filename = "./mxb_ihs_pval.png", width = 14, height = 10, units = "cm", res = 300)
#manhattanplot(wgscan.ihs, pval = T, cr = cr.mxb, cr.lab.cex = 0)
#dev.off()

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
write.table(x = wgscan.ihs.qqman, file = ihs_qqman_table, quote = F, sep = "\t")


## Plotting p_val with qman
# png(filename = "./mxb_ihs_pval.png", width = 14, height = 10, units = "cm", res = 300)
# manhattan(wgscan.ihs.qqman, col = brewer.pal(name = "Set2", n = 8),
#                  chrlabs = unique(ihs$CHR),
#                  annotatePval = 0.0001,
#                  suggestiveline = 4,
#                  annotateTop = T)
# dev.off()

## Plottting lambda
# qq(wgscan.ihs.qqman$P, main = paste("lambda=",lam))
# lam =P_lambda(wgscan.ihs.qqman$P)


## XP-EHH

## Reading VCFs and calculating EHH per chromosome in ingroup
for(i in first_chrom:last_chrom) {
  # haplotype file name for each chromosome
  hh <- data2haplohh(hap_file = paste(stem_ingroup,i, end_file_ingroup, sep = ""),
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table", remove_multiple_markers = T)
  # perform scan on a single chromosome (calculate iHH values)
  scan <- scan_hh(hh)
  # concatenate chromosome-wise data frames to
  # a data frame for the whole genome
  # (more efficient ways certainly exist...)
  if (i == first_chrom) {
    wgscan_ingroup <- scan
  } else {
    wgscan_ingroup <- rbind(wgscan_ingroup, scan)
  }
}

# Calculate XP-EHH
xpehh.mxb_pel <- ies2xpehh(scan_pop1 =  wgscan,
                           scan_pop2 =  wgscan_ingroup,
                           popname1 = first_pop,
                           popname2 = second_pop, include_freq = F)

## Detecting outliers for XP-EHH
cr.mxb_xp_ehh <- calc_candidate_regions(xpehh.mxb_pel,
                                     threshold = 4,
                                     pval = TRUE,
                                     window_size = 1E6,
                                     overlap = 1E5,
                                     min_n_extr_mrk = 2)


##Save results to tables
write.table(x = xpehh.mxb_pel, file = xp_ehh, quote = F, sep = "\t")
write.table(x = cr.mxb_xp_ehh, file = outliers_xp_ehh, quote = F, sep = "\t")

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
write.table(x = wgscan.xpehh.qqman, file = xp_ehh_qqman_table, quote = F, sep = "\t")

# if (!is.na(xpehh.mxb_pel$XPEHH_MXB_PEL)) {
#   manhattan(wgscan.xpehh.qqman, col = brewer.pal(name = "Set2", n = 8),
#             chrlabs = unique(ihs$CHR),
#             annotatePval = 0.0001,
#             suggestiveline = 4,
#             annotateTop = T)
#   } else {print("No")
# }
# 
# 
# png(filename = "./mxb_xp_ehh.png", width = 14, height = 10, units = "cm", res = 300)
# manhattanplot(xpehh.mxb_pel, main = "xp-ehh (MXB)")
# dev.off()
