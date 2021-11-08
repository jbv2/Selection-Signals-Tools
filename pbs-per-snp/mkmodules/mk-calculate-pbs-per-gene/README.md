# PBS_module

This module calculate Population Branch Statistic
by genetic region, then for the gen with maximum PBS
calculate PBS per SNP and plots the results.

Basic ideas
  1. Calcule PBS by genetic region
  2. Plot PBS by genetic region
  2. Calcule PBS by snp for the gene with higher PBS value
  3. Plot PBS by snp
  4. Plot Allele frequencies for SNP with higher PBS

## Inputs
This module takes three files with .csv extension (one for each pop)
  Example lines:

    "Weighted_Fst","Initial_position","Final_Position","SNP_Number","gene_lenght","SNP_by_10KB"
    0.10332,109707,197341,3575,87634,407.946687358788
    0.098857,123563,133500,382,9937,384.421857703532
    0.081789,196763,409417,8904,212654,418.708324320257
    -0.0056318,282689,282792,5,103,485.436893203883

  Files with FST by SNP for all the genes
  Example format: 6692319.chbvsmxl.log.weir.fst
  Example lines:

    CHROM	POS	WEIR_AND_COCKERHAM_FST
    3	6692322	-nan
    3	6692388	-nan
    3	6692393	-nan
    3	6692411	-nan
    3	6692421	0.0810832

Three files with allele freq for the gene with higher PBS
  Example format: AF_pel.frq
    Example lines:

    CHROM	POS	N_ALLELES	N_CHR	{ALLELE:FREQ}
    3	60069	2	206	C:1	T:0
    3	60079	2	206	A:1	G:0
    3	60157	2	206	G:1	A:0
    3	60189	2	206	A:1	G:0

## Output
This module creates a .PNG file plotting PBS results
Example:

![plot](./test/results/pbs.png)

## Module Dependencies
 R:
 4.0.5 version (or more recent ones)

 RStudio:
 4.0.3 version (or more recent ones)

# Authors
María Fernanda Mirón Toruño
