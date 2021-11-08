## ---------------------------
##
## Script name: PBS Calculator
##
## Purpose of script: This script can take Fst Data from VCFTools and calculate PBS values
##
## Author: Judith Ballesteros
##
## Date Created: "2021-10-26"
##
## Copyright (c) Judith Ballesteros, "2021-10-26"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: Based on Fernanda-Miron pipeline
##   
##
## ---------------------------

# Charging library
library("dplyr")
library("ggplot2")
library("ggrepel")
library("tidyr")
library("cowplot")
library("stringr")
library("patchwork")

## Read args from command line
args <- commandArgs(trailingOnly = T)

# Uncomment for debbuging
# Comment for production mode only
args[1] <- "./test/data/"  ## Dir with CSVs of fst results
args[2] <- "./test/data/pbs.tsv" ## Output
args[3] <- "mx_chb"
args[4] <- "mx_pel"
args[5] <- "pel_chb"

## Place args into named object
file_dir <- args[1]
pbs_file <- args[2]
pop1_pattern <- args[3]
pop2_pattern <- args[4]
pop3_pattern <- args[5]

## Get all the fst.csv files in path
csv.names <- list.files(path = file_dir, pattern = "*.fst", full.names = T)

# Define a function to import and process fst output from vcftools
fst_reader<-function(filename,pops){
  fst<-read.table(file = filename, header = T, stringsAsFactors = F, sep = "\t") #read in fst output from vcftools
  fst[,1][which(is.na(fst[,1]))]<-0 #change NA's to 0, the NA's are produced by vcftools when there is no variation at a site
  assign(pops,fst,envir = .GlobalEnv) #export dataframe with pop names as variable names
}

## Getting dataframe names
pop1 <- as.list(strsplit(csv.names[1], "/") [[1]])
pop1_saved <- as.character(pop1[length(pop1)])

pop2 <- as.list(strsplit(csv.names[2], "/") [[1]])
pop2_saved <- as.character(pop1[length(pop2)])

pop3 <- as.list(strsplit(csv.names[3], "/") [[1]])
pop3_saved <- as.character(pop1[length(pop3)])

## Segment for avoiding random
## Pop1 must be 1 vs 3: i.e.: Native Mexican vs CHB
pops <- c(pop1_saved, pop2_saved, pop3_saved)
if (str_detect(string = pop1_saved, pattern = pop1_pattern) == "TRUE") {
  pop1 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop1_pattern) == "TRUE") {
    pop1 <- pop2_saved
  } else {
    pop1 <- pop3_saved
  }
}

## Pop2 must be 1 vs 2: i.e.: Native Mexican vs PEL
if (str_detect(string = pop1_saved, pattern = pop2_pattern) == "TRUE") {
  pop2 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop2_pattern) == "TRUE") {
    pop2 <- pop2_saved
  } else {
    pop2 <- pop3_saved
  }
}

## Pop3 must be 3 vs 2: i.e.: CHB vs PEL
if (str_detect(string = pop1_saved, pattern = pop3_pattern) == "TRUE") {
  pop3 <- pop1_saved
} else {
  if (str_detect(string = pop2_saved, pattern = pop3_pattern) == "TRUE") {
    pop3 <- pop2_saved
  } else {
    pop3 <- pop3_saved
  }
}

## Uploading fst files
fst_pop1 <- fst_reader(filename = csv.names[1], pops = pop1 ) %>%
  rename(WEIR_AND_COCKERHAM_FST=basename(csv.names[1]) %>% sub(pattern = ".weir.fst", replacement = ""))
fst_pop2 <- fst_reader(filename = csv.names[2], pops = pop2 ) #%>% select(-Gene)
fst_pop3 <- fst_reader(filename = csv.names[3], pops = pop3 ) #%>% select(-Gene)


# Make a list of your dataframes and join them all together
fst_pop1_pop2 <- inner_join(x = fst_pop1, 
                            y = fst_pop2,
                            by = c("Initial_position", "Final_Position", "SNP_Number",
                                   "gene_lenght", "SNP_by_1KB"))
all_fst <- left_join(x = fst_pop1_pop2,
                     y = fst_pop3, 
                     by = c("Initial_position", "Final_Position","SNP_Number",
                            "gene_lenght", "SNP_by_1KB"))

# Making a function for PBS calculation
## As reported in Ávila-Arcos(2019)
#PBSnm=Tnm-chb +Tnm-ceu -Tchb-ceu/2
#T=-log(1-Fst´)
pbs.f<-function(pop1_out,pop1_pop2,pop2_out) {
  Tpop1_out= -log(1-pop1_out)
  Tpop1_pop2= -log(1-pop1_pop2)
  Tpop2_out= -log(1-pop2_out)
  pbs= (Tpop1_out + Tpop1_pop2 - Tpop2_out)/2
  pbs
}

# Running for my data
pbsresults<-pbs.f(pop1_out = all_fst[1],
              pop1_pop2 = all_fst[7],
              pop2_out = all_fst[8])

# Turn PBS into data frame and merge
pbsresults_2 <-all_fst[,2:6]
pbsresults_2 <-cbind(pbsresults_2 ,pbsresults)
pbsresults_2 <- pbsresults_2 %>% 
  rename(PBS_value = paste0(pop1,".Fst.x"))

#set negative pbs values to 0 for convenience
pbsresults_2$PBS_value[which(pbsresults_2$PBS_value<0)]<-0

# Arranging PBS values
pbsresults_2 <- pbsresults_2 %>% 
  arrange(order_by = -PBS_value, .keep = T)


# Uploading diccionary for genes
# Getting dictionary name
diccionary.df <- read.table(file = dictionary, header = T,
                         sep = "\t", stringsAsFactors = F)
colnames(diccionary.df) <- c("Chrom", "ID", "Initial_position", "Final_Position", "Gene_name")

# Merging to know the gen name
final_dataset <- left_join(x = pbsresults_2,
                     y =diccionary.df,
                     by = c("Initial_position", "Final_Position")) %>%
  select(Chrom, Initial_position, Final_Position, Gene_name, PBS_value, gene_lenght, SNP_Number) %>%
    rename(Start=Initial_position, End=Final_Position, Gene=Gene_name, PBS=PBS_value, Gene_Length=gene_lenght)

## Writting results to a table
write.table(x = final_dataset, file = pbs_file, quote = F, sep = " \t", row.names = F)

# # Plotting PBS vs number pf SNPs per gene
# PBS_b.pl <- ggplot(data = final_dataset, aes(x = SNP_Number , y = PBS_value )) +
#   geom_point() +
#   ylab("PBS") +
#   xlab("Number of SNPs per gene") +
#   geom_hline( yintercept = 0.060, lty = "dashed" ) +
#   theme_cowplot() +
#   geom_label_repel(data= final_dataset %>% filter(PBS_value > 0.060),
#                      aes(label=Gene_name),
#                      color = 'black',
#                      size = 4)
# 
# ## Plot frequency of PBS
# PBS_a.pl <- ggplot(data = final_dataset, aes(x = PBS_value)) +
#   geom_histogram(stat = "bin", position = "stack", bins = 50, fill = "black") +
#   ylab("Frequency") +
#   xlab("PBS") +
#   geom_text_repel(data = highlight, 
#                    aes(label=Gene_name, x = PBS_value, y = 0), force = T, force_pull = T, arrow = T) +
#   theme_cowplot()
#   
# plot_grid(plotlist = c(PBS_a.pl, PBS_b.pl))
# 
# pathcwork <- (PBS_a.pl | PBS_b.pl) 
# 
# PBS.pl <- pathcwork + plot_annotation(tag_levels = 'A')
# 
# ## Saving
# ggsave(filename = png_file, 
#        plot = PBS.pl, 
#        device = "png", 
#        width = 20, height = 10, units = "cm", 
#        dpi = 300)
