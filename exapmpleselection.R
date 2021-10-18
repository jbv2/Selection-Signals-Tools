library(rehh)
library("vcfR") ## For reading VCFs
library("R.utils") ## For reading compressed VCFs

#make.example.files()

## Code for calculating iHS in a single chromosome 
hh <-                  # data input
  data2haplohh(
    hap_file = "bta12_cgu.hap",
    map_file = "map.inp",
    chr.name = "12",
    allele_coding = "map"
  )
scan <- scan_hh(hh)    # calculation of EHH and integration
# (combine results from different chromosomes)
ihs <- ihh2ihs(scan)   # log ratio for alleles and standardization
manhattanplot(ihs)     # plot of the statistics


## Example for reading a VCF
hh <- data2haplohh(hap_file = "bta12_cgu.vcf.gz",
                   polarize_vcf = FALSE,
                   vcf_reader = "data.table")

## Code for calculating xp-ehh
library(rehh.data)
data(wgscan.cgu) ; data(wgscan.eut)
## results from a genome scan (44,057 SNPs) see ?wgscan.eut and ?wgscan.cgu for details
xpehh.cgu_eut <- ies2xpehh(scan_pop1 =  wgscan.cgu,
                           scan_pop2 =  wgscan.eut,
                           popname1 = "CGU",
                           popname2 = "EUT")
## Para xpehh se debe usar otra población

## Detecting outliers for xp-ehh
cr.cgu <- calc_candidate_regions(xpehh.cgu_eut,
                                 threshold = 4,
                                 pval = TRUE,
                                 window_size = 1E6,
                                 overlap = 1E5,
                                 min_n_extr_mrk = 2)
cr.cgu

manhattanplot(xpehh.cgu_eut,
              main = "xp-ehh (CGU cattle breed)", cr = cr.cgu, cr.lab.cex = 0)
manhattanplot(xpehh.cgu_eut,
              pval = TRUE,
              threshold = 4,
              main = "p-value of xpehh (CGU cattle breed)")

##Using qqman
# extract data frame from result list
data(wgscan.cgu)
wgscan.ihs.cgu <- ihh2ihs(wgscan.cgu)
ihs <- wgscan.ihs.cgu$ihs

# create new data frame
wgscan.cgu.ihs.qqman <- data.frame(
  CHR = as.integer(factor(ihs$CHR, 
                          levels = unique(ihs$CHR))),
  # chromosomes as integers
  BP = ihs$POSITION,         # base pairs
  P = 10**(-ihs$LOGPVALUE),  # transform back to p-values
  SNP = row.names(ihs)       # SNP names
)

##Use qqman
library(qqman)
qqman::manhattan(wgscan.cgu.ihs.qqman,
                 col = c("red","green"),
                 chrlabs = unique(ihs$CHR),
                 suggestiveline = 4,
                 highlight = "F1205400",
                 annotatePval = 0.0001)

## For xp-ehh
xpehh <- xpehh.cgu_eut

# create new data frame
wgscan.cgu.xpehh.qqman <- data.frame(
  CHR = as.integer(factor(xpehh$CHR, 
                          levels = unique(xpehh$CHR))),
  # chromosomes as integers
  BP = xpehh$POSITION,         # base pairs
  P = 10**(-xpehh$LOGPVALUE),  # transform back to p-values
  SNP = row.names(xpehh)       # SNP names
)


qqman::manhattan(wgscan.cgu.xpehh.qqman,
                 col = c("red","green"),
                 chrlabs = unique(xpehh$CHR),
                 annotatePval = 0.0001)
