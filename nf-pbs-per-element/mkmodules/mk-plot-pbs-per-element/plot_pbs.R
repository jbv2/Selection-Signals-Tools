## ---------------------------
##
## Script name: Plot element PBS
##
## Purpose of script: This script plot PBS values. 
##
## Author: Judith Ballesteros-Villascán
##
## Date Created: "2022-07-03"
##
## Copyright (c) Judith Ballesteros, "2022-07-03"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: NONE
##
## ---------------------------

# Load libraries
library("ggplot2")
library("dplyr")
library("cowplot")

## Read args from command line
args <- commandArgs(trailingOnly = T)

## For debugging only
# args[1] <- "test/data/mxb_chb_ibs_pbs.tsv" # PBS input
# args[2] <- "test/data/mxb_chb_ibs_pbs.png" # Output

## Assign args
pbs <- args[1]
png <- args[2]

## Read args
pbs.df <- read.csv(file = pbs, header = T, sep = "\t", stringsAsFactors = F)

## Manipulate results to remove "Inf".
# Remove duplicates
pbs_2.df <- pbs.df %>%
  distinct(.keep_all = T) %>%
  mutate(PBS=as.numeric(PBS)) %>%
  filter(between(Chromosome, 1, 22)) %>%
  arrange(desc(PBS)) %>%
  arrange(desc(SNP.number)) %>%
  rename("SNP_Number"=SNP.number) %>%
  mutate(Color = ifelse(SNP_Number == 1, "#66C2A5",
                        ifelse(SNP_Number == 2, "#9dd8c5",
                               ifelse(SNP_Number == 3, "#FC8D62",
                                      ifelse(SNP_Number == 4, "#fdc4ad",
                                             ifelse(SNP_Number == 5, "#8DA0CB",
                                                    ifelse(SNP_Number == 6, "#c2cce3",
                                                           ifelse(SNP_Number == 7, "#E78AC3",
                                                                  ifelse(SNP_Number == 8, "#f4c9e4",
                                                                         ifelse(SNP_Number == 9, "#A6D854",
                                                                                ifelse(SNP_Number == 10, "#c6e692", "gray")))))))))))

## Plot  PBS per gene
pbs.pl <- ggplot(data = pbs_2.df, mapping = aes(x = SNP_Number, y = as.numeric(PBS), colour=Color)) +
  geom_point(show.legend = T) +
  xlab("SNPs per element") +
  ylab("PBS") +
  scale_color_identity("SNPs", labels = pbs_2.df$SNP_Number, breaks = pbs_2.df$Color, guide = "legend") +
  theme_classic() +
  theme(axis.title = element_text(size = 13, family = "AvantGarde"),
        axis.text = element_text(size = 10, family = "AvantGarde"),
        legend.title = element_text(family = "AvantGarde", size = 13),
        legend.text = element_text(family = "AvantGarde", size = 11),
        text = element_text(family = "AvantGarde")) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))
#pbs.pl

legend.pl <- ggplot(data = pbs_2.df, mapping = aes(x = SNP_Number, y = as.numeric(PBS), colour=Color)) +
  geom_point(show.legend = T) +
  scale_colour_manual(name = "SNPs",
                      labels = c(1:10),
                      values = c("#66C2A5","#9dd8c5", "#FC8D62", "#fdc4ad", "#8DA0CB", "#c2cce3", "#E78AC3", "#f4c9e4", "#A6D854", "#c6e692"),
                      aesthetics = "colour", limits = factor(1:10)) + 
  theme_classic() +
  theme(axis.title = element_text(size = 13, family = "AvantGarde"),
        axis.text = element_text(size = 10, family = "AvantGarde"),
        legend.title = element_text(family = "AvantGarde", size = 13),
        legend.text = element_text(family = "AvantGarde", size = 11),
        text = element_text(family = "AvantGarde")) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE)) +
  ylim(0,1.7)

legend <- get_legend(
  # create some space to the left of the legend
  legend.pl + theme(legend.box.margin = margin(0, 0, 0, 12))
)


two.pl <- plot_grid(
  pbs.pl + theme(legend.position="none"),
  align = 'vh',
  hjust = -0.5,
  vjust = 1,
  nrow = 1
)

freq.pl <- ggplot(pbs_2.df, mapping = aes(x = PBS)) +
  geom_histogram(stat = "bin", bins = 50) +
  ylab("Frequency") +
  theme_classic() +
  theme(axis.title = element_text(size = 13, family = "AvantGarde"),
        axis.text = element_text(size = 11, family = "AvantGarde"))
#freq.pl

## Gather results
final_plot.pl <- plot_grid(freq.pl, two.pl, legend, rel_widths = c(2.5, 3, .5), ncol = 3, label_fontfamily =  "AvantGarde", label_size = 15, scale = 0.90) + 
  theme(plot.background = element_rect(fill="white", color = NA))
#final_plot.pl

##Save plots.
ggsave(filename = png, plot = final_plot.pl, device = "png", width = 25, height = 10, dpi = 300, units = "cm")

