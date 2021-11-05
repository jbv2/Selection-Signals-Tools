# Fst_module

This module uses vcftools to calculate Fst from a .vcf file
for each gene provided by a biomart file

Basic ideas:
  1. Calculate Fst for the IDs and positions provided by a .vcf file
  2. Run Fst by vcftools for each coordinate provided by a biomart file

## Inputs
This module takes:
  1) A file with .vcf extension with the coordinates of the genes
  provided by mart_export.txt

  2) A biomart file with gene coordinates (mart_export.txt)
    Example lines:

    Chromosome/scaffold name	Gene stable ID	Gene start (bp)	Gene end (bp)	Gene name
    3	ENSG00000223587	11745	24849	LINC01986
    3	ENSG00000224918	53348	54346	AC066595.1
    3	ENSG00000224318	109707	197341	CHL1-AS2
    3	ENSG00000287140	123563	133500	AC066595.2

  3) Two files with IDs for specific populations (the ones the user want to use
  for Fst calculation) (pop_chb)
    Example lines:

    NA18525
    NA18526
    NA18528

## Output
A .log and .log.weir.fst files for each gene

### Module Dependencies

 vcftools:
 Version 0.1.15 (or more actualizated versions)

#### Authors
María Fernanda Mirón Toruño
