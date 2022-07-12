## load libraries
library("dplyr")
library(tidyr)
#library("stringr")
#library("reshape2")
#library("igraph")
#library(RColorBrewer)

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## For debugging only
# args[1] <- "test/data/mxb.samplechr22.anno_vep.common_freq.GeneHancer.tsv"
# args[2] <- "test/data/mxb.samplechr22.anno_vep.common_freq.GeneHancer.enhancers.tsv"


output <- args[2]

## Load data
GeneHancer_tsv.df <- read.csv(file = args[1], header = T, sep = "\t", stringsAsFactors = F) %>%
  select(-IMPACT, -HGVSc, -HGVSp, -cDNA_position, -CDS_position, -Protein_position, -Amino_acids, -Codons, -VARIANT_CLASS, -SYMBOL_SOURCE, -HGNC_ID, -SOURCE, -GENE_PHENO, -HGVS_OFFSET, -HGVSg, -CLIN_SIG, -SOMATIC, -PHENO, -CHECK_REF, -MOTIF_NAME, -MOTIF_POS, -HIGH_INF_POS, -MOTIF_SCORE_CHANGE, -gwascatalog, -gnomADg, -Allele, -Feature_type, -Feature, -EXON, -INTRON, -Consequence) %>%
  rename(AF_MXB=AF, AC_MXB=AC, AN_MXB=AN) %>%
  relocate(Type_GeneHancer_Genes, .after = ALT) %>%
    relocate(LINSIGHT_SCORE,
             .after = GWAVA) %>%
    relocate(gwRVIS_score,
             .after = LINSIGHT_SCORE) %>%
    relocate(JARVIS_score,
             .after = gwRVIS_score) %>%
    relocate(PhyloP100,
             .after = JARVIS_score) %>%
    relocate(PhastCons,
             .after = PhyloP100) %>%
    relocate(ihs,
             .before = CADD_PHRED) %>%
    relocate(xp_ehh,
             .after = ihs) %>%
    relocate(pbs_per_snp,
             .after = xp_ehh) %>%
  relocate(pbs_per_gene_ensembl,
           .after = pbs_per_snp) %>%
  relocate(pbs_per_gene_fantom,
           .after = pbs_per_gene_ensembl) %>%
  relocate(pbs_per_gene_genehancer,
           .after = pbs_per_gene_fantom) %>%
    relocate(Type_GeneHancer_Genes,
             .before = gwascatalog_GWAScat_DISEASE_orTRAIT) %>%
    relocate(AF_MXB,
             .before = AF.1) %>%
    relocate(AN_MXB,
             .before = AF_MXB) %>%
    relocate(AC_MXB,
             .before = AN_MXB) %>%
    relocate(TRANSCRIPTION_FACTORS,
             .before = SYMBOL) %>%
    relocate(gnomADg_AF_afr,
             .after = MAX_AF_POPS) %>%
    relocate(gnomADg_AF_amr,
             .after = gnomADg_AF_afr) %>%
    relocate(gnomADg_AF_asj,
             .after = gnomADg_AF_amr) %>%
    relocate(gnomADg_AF_eas,
             .after = gnomADg_AF_asj) %>%
    relocate(gnomADg_AF_fin,
             .after = gnomADg_AF_eas) %>%
    relocate(gnomADg_AF_nfe,
             .after = gnomADg_AF_fin) %>%
    relocate(gnomADg_AF_oth,
             .after = gnomADg_AF_nfe) %>%
  separate(Type_GeneHancer_Genes, sep = "&", fill = "warn", into = c("CHR_GH", "START_GH", "END_GH", "Type_Enhancer_Promoter","GeneHancer_ID","Gene1","Score1","Gene2","Score2","Gene3","Score3","Gene4","Score4","Gene5","Score5","Gene6","Score6","Gene7","Score7","Gene8","Score8","Gene9","Score9","Gene10","Score10","Gene11","Score11","Gene12","Score12","Gene13","Score13","Gene14","Score14","Gene15","Score15","Gene16","Score16","Gene17","Score17","Gene18","Score18","Gene19","Score19","Gene20","Score20")) %>%
  separate_rows(Type_Enhancer_Promoter,
                sep = "/")  %>%
  relocate(GeneHancer_ID,
           .after = ALT) %>%
  relocate(Type_Enhancer_Promoter,
           .after = GeneHancer_ID) %>%
  relocate(CHR_GH,
           .after = Type_Enhancer_Promoter) %>%
  relocate(START_GH,
           .after = CHR_GH) %>%
  relocate(END_GH, .after = START_GH) %>%
  relocate(gwascatalog_GWAScat_DISEASE_orTRAIT, .after = FANTOM.CAT_lncRNAID) %>%  #Change to DISEASE_orTRAIT
  relocate(gwascatalog_GWAScat_REPORTED_GENE, .after = gwascatalog_GWAScat_DISEASE_orTRAIT) %>%
  relocate(gwascatalog_GWAScat_MAPPED_GENE, .after = gwascatalog_GWAScat_REPORTED_GENE) %>%
  relocate(gwascatalog_GWAScat_P_VALUE, .after = gwascatalog_GWAScat_MAPPED_GENE) %>%
  relocate(gwascatalog_GWAScat_P_VALUE_MLOG, .after = gwascatalog_GWAScat_P_VALUE) %>%
  relocate(gwascatalog_GWAScat_OR_or_BETA, .after = gwascatalog_GWAScat_P_VALUE_MLOG) %>%
  relocate(gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE, .after = gwascatalog_GWAScat_OR_or_BETA) %>%
  relocate(gwascatalog_GWAScat_PUBMEDID, .after = gwascatalog_GWAScat_INITIAL_SAMPLE_SIZE) %>%
  mutate(LENGHT_GH=abs(as.numeric(END_GH) - as.numeric(START_GH)), .after = END_GH)

enhancers.df <- GeneHancer_tsv.df %>%
  filter(Type_Enhancer_Promoter == "Enhancer")

promoters.df <- GeneHancer_tsv.df %>%
  filter(Type_Enhancer_Promoter == "Promoter")

## Writing VEP annotations to table
#Enhancers
write.table(x = enhancers.df, file = output, quote = F, sep = "\t", row.names = F, col.names = T)

#Promoters
write.table(x = promoters.df, file = gsub(output,
                                          pattern = "enhancers.tsv",
                                          replacement = "promoters.tsv"), quote = F, sep = "\t", row.names = F, col.names = T)

## Loking for top enhancers with most variation
# count the number of variants per GeneHancerID
variants_per_GeneHancerID.df <- enhancers.df %>%
  group_by(GeneHancer_ID) %>%
  summarise( number_of_variants = n() ) %>%
  arrange(desc(number_of_variants))

# Count the number of variants per GeneHancerID normalizing by length
variants_per_GeneHancerID_normalized.df <- enhancers.df %>%
  group_by(GeneHancer_ID) %>%
  summarise( variants = n())

variants_per_GeneHancerID_normalized.df <- left_join(x = variants_per_GeneHancerID_normalized.df, y = enhancers.df) %>%
  mutate(number_of_variants_normalized= variants/LENGHT_GH) %>%
  select(GeneHancer_ID, number_of_variants_normalized) %>%
  arrange(desc(number_of_variants_normalized)) %>%
  distinct()

variants_per_GH.df <- left_join(variants_per_GeneHancerID.df, variants_per_GeneHancerID_normalized.df) %>%
  arrange(desc(number_of_variants_normalized))

##Output to tsv
write.table(x = variants_per_GH.df, file = gsub(output,
                                                       pattern = "enhancers.tsv",
                                                       replacement = "variants_per_enhancer.tsv"), quote = F, sep = "\t", row.names = F, col.names = T)


## Loking for top promoters with most variation
# count the number of variants per promoter
variants_per_promoter.df <- promoters.df %>%
  group_by(GeneHancer_ID) %>%
  summarise( number_of_variants = n() ) %>%
  arrange(desc(number_of_variants))

# Count the number of variants per promoters normalizing by length
variants_per_promoter_normalized.df <- promoters.df %>%
  group_by(GeneHancer_ID) %>%
  summarise( variants = n())

variants_per_promoter_normalized.df <- left_join(x = variants_per_promoter_normalized.df, y = promoters.df) %>%
  mutate(number_of_variants_normalized= variants/LENGHT_GH) %>%
  select(GeneHancer_ID, number_of_variants_normalized) %>%
  arrange(desc(number_of_variants_normalized)) %>%
  distinct()

variants_per_promoter.df <- left_join(variants_per_promoter.df, variants_per_promoter_normalized.df) %>%
  arrange(desc(number_of_variants_normalized)) %>%
  rename(Promoter_GH_ID=GeneHancer_ID)

##Output to tsv
write.table(x = variants_per_promoter.df, file = gsub(output,
                                                       pattern = "enhancers.tsv",
                                                       replacement = "variants_per_promoter.tsv"), quote = F, sep = "\t", row.names = F, col.names = T)


# ## Prepare data for network
# network.df <- filter(GeneHancer_tsv.df, Type_Enhancer_Promoter == "Enhancer") %>%
#   select(matches("Gene|Score"), -Gene, -gwascatalog_GWAScat_REPORTED_GENE, -gwascatalog_GWAScat_MAPPED_GENE, -LINSIGHT_SCORE, -gwRVIS_score, -JARVIS_score) %>%
#   distinct(GeneHancer_ID, .keep_all = T) %>%
#   unite(Gene, Gene1, Gene2, Gene3, Gene4, Gene5, Gene6, Gene7, Gene8, Gene9, Gene10, Gene11, Gene12, Gene13, Gene14, Gene15, Gene16, Gene17, Gene18, Gene19, Gene20) %>%
#   unite(Score, Score1, Score2, Score3, Score4, Score5, Score6, Score7, Score8, Score9, Score10, Score11, Score12, Score13, Score14, Score15, Score16, Score17, Score18, Score19, Score20) %>%
#   separate_rows(2:3, sep = "_") %>%
#   filter(Gene!="NA")
#
# mygraph <- graph.data.frame(network.df, directed = T)
# coords = layout_with_fr(mygraph)
# deg <- degree(mygraph)
# score <- network.df$Score
#
# # Create a vector of color
# coul  <- c(brewer.pal(name="Dark2", n = length(network.df)))
# colores <- network.df$GeneHancer_ID %>% unique()
# my_color <- coul[as.numeric(as.factor(colores))]
#
#
# E(net)$width <- E(net)$weight/6
#
# # Plot graph
# plot(mygraph,
#      layout=coords,
#      edge.arrow.size=0.09,
#      vertex.size=deg,
#      vertex.label.cex=0.5,
#      vertex.label.color="black",
#      vertex.label=NA,
#      vertex.color=my_color,
#      edge.curved=F,
#      edge.color="cornflowerblue",
#      edge.arrow.size=score)
# legend("bottomleft", legend=levels(as.factor(colores)),
#        col = coul,
#        bty = "n", pch=,
#        pt.cex = 1,
#        cex = 1.1,
#        text.col=coul,
#        horiz = F,
#        inset = c(-0.2, 0.01),
#        y.intersp=0.5)
