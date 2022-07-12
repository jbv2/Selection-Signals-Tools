## load libraries
library("dplyr")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## For debugging only
# args[1] <- "test/data/test_data.anno_vep.fantomcat.tsv"
# args[2] <- "test/data/test_data.anno_vep.fantomcat.extracted.tsv"

## Load data
fantomcat_tsv.df <- read.csv(file = args[1], header = T, sep = "\t", stringsAsFactors = F) %>%
  select(-IMPACT, -HGVSc, -HGVSp, -cDNA_position, -CDS_position, -Protein_position, -Amino_acids, -Codons, -VARIANT_CLASS, -SYMBOL_SOURCE, -HGNC_ID, -SOURCE, -GENE_PHENO, -HGVS_OFFSET, -HGVSg, -CLIN_SIG, -SOMATIC, -PHENO, -CHECK_REF, -MOTIF_NAME, -MOTIF_POS, -HIGH_INF_POS, -MOTIF_SCORE_CHANGE, -gwascatalog, -gnomADg, -Allele, -Feature_type, -Feature, -EXON, -INTRON, -FANTOM.CAT_lncRNAID, -Consequence) %>%
  mutate(POS_0=POS-1, .before=POS)

new_fantomcat_tsv.df <- args[2]

write.table(x = fantomcat_tsv.df, file = new_fantomcat_tsv.df, quote = F, sep = "\t", row.names = F)
