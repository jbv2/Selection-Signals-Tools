library("valr")

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## For debugging only
# args[1] <- "probe_introns.bed"
# args[2] <- "probe_introns_exons.bed"

x <- read_bed12(filename = args[1])

exons <- bed12_to_exons(x)
introns <- create_introns(x)

write.table(x = exons, file = args[2], quote = F, sep = "\t", col.names = F, row.names = F)

write.table(x = introns,
            file = gsub(args[2], pattern = "exons", replacement = "introns"),
            append = F,quote = F, sep = "\t", row.names = F, col.names = F)
