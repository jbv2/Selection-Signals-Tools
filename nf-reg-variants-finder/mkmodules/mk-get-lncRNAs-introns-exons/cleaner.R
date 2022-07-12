## load libraries
library("dplyr")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## For debugging only
# args[1] <- "test/data/mxb_ihs_22.anno_dbSNP_vep.snv.common_freq.fantomcat.GWAScatalog.introns_exons.tsv.build"
# args[2] <- "test/data/mxb_ihs_22.anno_dbSNP_vep.snv.common_freq.fantomcat.GWAScatalog.introns_exons.tsv"

# Load data
introns_exons <- args[1]

introns_exons.df <- read.csv(file = introns_exons,
                             header = T,
                             sep = "\t",
                             stringsAsFactors = F) %>%
  select(-POS_0) %>%
  rename(exon_intron_coordinates=coordinates,
         AF_MXB=AF,
         number_exon_intron=number,
         exon_intron_type=type,
         AC_MXB=AC, AN_MXB=AN) %>%
  group_by(lnc_coordinates) %>%
  distinct(lnc_coordinates,ID,
           .keep_all = T) %>%
  group_by(CHROM,
           POS) %>%
  relocate(lncID,
           .after = ALT) %>%
  relocate(lnc_coordinates,
           .after = lncID) %>%
  relocate(exon_intron_coordinates,
           .after = lnc_coordinates) %>%
  relocate(exon_intron_type,
           .after = exon_intron_coordinates) %>%
  relocate(number_exon_intron,
           .after = exon_intron_type) %>%
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
           .after = number_exon_intron) %>%
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
  filter(pbs_per_gene_fantom != "." | xp_ehh != "." | ihs != ".",
         .preserve = T)

write.table(x = introns_exons.df,
            file = args[2],
            quote = F,
            sep = "\t",
            row.names = F,
            col.names = T)

number_introns_exons <- group_by(introns_exons.df, exon_intron_type) %>%
  distinct(lnc_coordinates, exon_intron_type) %>%
  select(exon_intron_type) %>%
  count(exon_intron_type)

number_variants <- group_by(introns_exons.df,
                            ID) %>%
  select(ID) %>%
  unique() %>%
  n_distinct()

number_lnc <- group_by(introns_exons.df,
                       lnc_coordinates) %>%
  select(lnc_coordinates) %>%
  unique() %>%
  n_distinct()

if (length(number_introns_exons$exon_intron_type) > 1) {
  final_table.df <- data.frame(number_introns_exons) %>%
    t() %>%
    as.data.frame() %>%
    rename(number_of_exons=V1,
           number_of_introns=V2) %>%
  mutate(number_of_variants=number_variants,
         number_of_lncRNA=number_lnc) %>%
    select(number_of_variants,
           number_of_lncRNA,
           number_of_exons,
           number_of_introns) %>%
    t() %>%
    as.data.frame()

  write.table(x = final_table.df,
              file = gsub(args[2],
                          pattern = ".tsv",
                          replacement = ".summary.tsv"),
              quote = F,
              row.names = T,
              col.names = F,
              sep = "\t")
}

## Making top of lncRNAs with more variants
top.df <- select(introns_exons.df,
                 lncID,
                 lnc_coordinates,
                 exon_intron_type,
                 number_exon_intron,
                 ID,
                 REF,
                 ALT) %>%
  group_by(lncID) %>%
  mutate(variants_per_lncID = n()) %>%
  group_by(lnc_coordinates) %>%
  mutate(variants_per_lnc_coordinates = n()) %>%
  select(-CHROM, -POS)

write.table(x = top.df,
            file = gsub(args[2],
                        pattern = ".tsv",
                        replacement = ".top_variants_per_lncRNA.tsv"),
            quote = F,
            row.names = F,
            col.names = T,
            sep = "\t")

length(number_introns_exons$exon_intron_type)
