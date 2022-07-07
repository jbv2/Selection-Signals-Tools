# ---------------------------
##
## Script name: Plot iHS
##
## Purpose of script: Plot iHS results from rehh
##
## Author: Judith Ballesteros-Villascán
##
## Date Created: "2022-07-06"
##
## Copyright (c) Judith Ballesteros, "2022-07-06"`
## Email: judith.vballesteros@gmail.com
##
## ---------------------------
##
## Notes: NONE
##
## ---------------------------

##Loading libraries
library("dplyr")
library("ggplot2")
library("ggrepel")
args = commandArgs(trailingOnly=TRUE)

## Load args
## For debuggin only.
## Comment for running in mk
# args[1] <- "test/data/ihs_results.csv"
# args[2] <- "test/data/ihs_results.png"

##Asign args
results <- args[1]
output <- args[2]

## Read args
results.df <- read.csv(file = results, header = T, sep = "\t", stringsAsFactors = F) %>%
  rename(BP=POSITION)

my_y_title <- expression(paste("iHS ", -log[10],italic("(p)")))

##Trying another manhattan from: https://www.r-graph-gallery.com/101_Manhattan_plot.html
# Prepare the dataset
don <- results.df %>% 
  
  # Compute chromosome size
  group_by(CHR) %>% 
  summarise(chr_len=max(BP)) %>% 
  
  # Calculate cumulative position of each chromosome
  mutate(tot=cumsum(chr_len)-chr_len) %>%
  select(-chr_len) %>%
  
  # Add this info to the initial dataset
  left_join(results.df, ., by=c("CHR"="CHR")) %>%
  
  # Add a cumulative position of each SNP
  arrange(CHR, BP) %>%
  mutate( BPcum=BP+tot) %>%
  
  # Add highlight and annotation information
  mutate( is_annotate=ifelse(-log10(P)>2.5, "yes", "no")) 

# Prepare X axis
axisdf <- don %>% group_by(CHR) %>% summarize(center=( max(BPcum) + min(BPcum) ) / 2 )

# Make the plot
ihs.pl <- ggplot(don, aes(x=BPcum, y=-log10(P))) +
  
  # Show all points
  geom_point( aes(color=as.factor(CHR)), alpha=0.8, size=1.3) +
  scale_color_manual(values = rep(c("grey", "black"), 22 )) +
  
  # custom X axis:
  scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center ) +
  scale_y_continuous(expand = c(0, 0), limits = c(0,max(don$LOGPVALUE + .5)) ) +     # remove space between plot area and x axis
  ylab(my_y_title) +
  xlab("Chromosome") +
  
  # Add highlighted points
  geom_point(data=subset(don, is_annotate=="yes"), color="orange", size=2) +
  geom_hline(yintercept=2.5, linetype='dotted', col = 'red')+
  # Add label using ggrepel to avoid overlapping
  geom_label_repel( data=subset(don, is_annotate=="yes"), aes(label=SNP), size=3) +
  
  # Custom the theme:
  theme_classic() +
  theme( 
    legend.position="none",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text = element_text(family = "AvantGarde", size = 15),
    axis.title = element_text(family = "AvantGarde", size = 15) 
  ) 

##Save ihs plot
ggsave(filename = output, plot = ihs.pl, device = "png", dpi = 300, width = 10, height = 6, units = "in")
