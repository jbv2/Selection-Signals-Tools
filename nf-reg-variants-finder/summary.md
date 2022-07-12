# Summmary of commands for preparing references and inputs files.

*By Judith Ballesteros Villascán*
**June 2021**

---

### **Programs**

The programs that I installed for preparing files for using the pipeline, are:

|Program|Version|
|:-----:|:-----:|
| [ensembl-vep](https://github.com/Ensembl/ensembl-vep.git) | 104 |
| [bigWigToWig](http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/) | NA |
| [bedops](ttps://github.com/bedops/bedops.git) | 2.34.9 |
| [liftOver](http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/liftOver) | NA |
| [bcftools](https://samtools.github.io/bcftools/howtos/install.html) | 1.11 |
| [samtools](http://www.htslib.org/download/) | 1.11 |
| [bedtools](https://bedtools.readthedocs.io/en/latest/content/installation.html) | 2.29.1 |
| [CrossMap](http://crossmap.sourceforge.net/) | 0.5.2 |

-----

### **References files**

The files for VEP references and their given format are:

| File | Genome version | Original Format | Format Giver | Plugin or Custom | Purpose | Fields kept | \# Features (lines) |
|:----:|:----:|:------:|:--:|:------:|:-------:|:--:|:---:|
| [LINSIGHT](http://compgen.cshl.edu/LINSIGHT/LINSIGHT.bw) | hg19 | BigWig | BED-like | Custom | Functional Score | Chr,Start,End,Score | 221,053,480 |
| [gwRVIS](https://az.app.box.com/v/jarvis-gwrvis-scores/folder/122133161526?page=2) | hg19 | BED | BED-like | Custom | Functional score | Chr,Start,End,Score | 2,789,619,000 |
| [JARVIS](https://az.app.box.com/v/jarvis-gwrvis-scores/folder/122133161526?page=2) | hg19 | BED | BED-like | Custom | Functional score | Chr,Start,End,Score | 1,971,013,482 |
| [FANTOM_CAT](https://fantom.gsc.riken.jp/5/suppl/Hon_et_al_2016/data/assembly/lv4_stringent/FANTOM_CAT.lv4_stringent.only_lncRNA.bed.gz) | hg19 | BED | BED | Custom  | lncRNA DB | 12 fields | 35,988 |
| [GWASC](https://www.ebi.ac.uk/gwas/api/search/downloads/alternative)| GRCh38 | TSV | VCF | Custom | GWAS DB | Chr,pos,trait,gene,risk_allele,p-val,mlog, beta,sample_N,pubmedID | 112,999 |
| [GeneHancer](https://owncloud.incpm.weizmann.ac.il/index.php/s/3KFV2lYTKlZfHp2/authenticate) | GRCh38 | GFF | BED-like | Custom | Enhancers & Promoters DB | Chr,Start,End,Type,ID,Gene(s),Scores | 391,678 |
| [GWASmxb](/data/projects/MXB_freeze_30Jan19/MXB_30Jan19/MXB_freeze_v2/GWAS_results/questionnaire_phenotypes/) | GRCh38 | TSV | VCF | Custom | GWAS mxb | Chr,Pos,ID,REF,ALT,trait,p_value,beta,freq,N | BOLT: 9281, SAIGE: 636 |
| [phyloP100](http://hgdownload.soe.ucsc.edu/goldenPath/hg19/phyloP100way/hg19.100way.phyloP100way.bw) | GRCh37 | BigWig | BigWig |  Plugin | Conservation Score | All because it's Plugin | NA |
| [phastCons100](http://hgdownload.soe.ucsc.edu/goldenPath/hg19/phastCons100way/hg19.100way.phastCons.bw) | GRCh37 | BigWig | BigWig |  Plugin | Conservation Score | All because it's Plugin | NA |
| [CADD](https://cadd.gs.washington.edu/download) | GRCh37 | TSV | TSV | Plugin | Functional Score | All because it's Plugin | 8,575,974,284 |
| [FATHMM-MKL](https://github.com/HAShihab/fathmm-MKL) | GRCh37 | TSV | TSV | Plugin |Functional Score | All because it's Plugin | 8,574,474,285 |
| [gnomAD](http://ftp.ensembl.org/pub/data_files/homo_sapiens/GRCh37/variation_genotype/gnomad/r2.1/genomes/) | GRCh38 | VCF | VCF | Custom | Global frequencies | All because it's file from VEP | 42,879,939 |
| [GWAVA](ftp://ftp.sanger.ac.uk/pub/resources/software/gwava/) | hg19 | BED | BED | Plugin | Functional Score | All because it's Plugin | 49,999,357 |

Files in hg19, are compatible with GRCh37, except from chrM, so, they were not converted.

Files in GRCh38 were converted to GRCh37 using:
* LiftOver for BEDs
* CrossMap for VCFs
* [ChainFile_hg38ToHg19](ftp://hgdownload.cse.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz)

BED and BED-like files were prepared for being used as custom annotation in VEP with:
```
grep -v "#" myData.bed | sort -k1,1 -k2,2n -k3,3n -t$'\t' | bgzip -c > myData.bed.gz
tabix -p bed myData.bed.gz
```

VCF files were compressed with bgzip and made its index with tabix.

Plugin files were downloaded and used as recommended in [VEP documentation](https://www.ensembl.org/info/docs/tools/vep/script/vep_plugins.html#postgap).

**IMPORTANT**

The references files for testing this pipeline are subsets of chromosome 22, due to the space of a repository.

---

### **Inputs for Pipeline**

All the variants dataset in GRCh37 of MXB in plink format, were converted to VCF using:

```
# Convert plink2vcf
plink --bfile MXB_30Jan19_uind.clean.151.geno0.05.ind0.05 --keep-allele-order --recode vcf --out MXB_30Jan19_uind.clean.151.geno0.05.ind0.05

# Change chromosomes 23,24,25 and 26 to X,Y,XY and MT
bcftools annotate --rename-chrs chromosomes.txt --threads 6 -o MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.renamed.vcf -Oz MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.vcf

# Add AF, AN, AC fields to VCF and sort.
bcftools +fill-tags MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.renamed.vcf| bcftools sort | bgzip > MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.af.sorted.vcf.gz

# Index new file
tabix -p vcf MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.af.sorted.vcf.gz

# Keep variants with iHS selection signal
bcftools view --regions-file selscan/allMXB_allchr.ihs.out.100bins.norm.bed.gz MXB_30Jan19_uind.clean.151.geno0.05.ind0.05.af.sorted.vcf.gz | bgzip > MXB_30Jan19_uind.clean.151.
geno0.05.ind0.05.af.sorted.ihs.vcf.gz

```


All VCFs with selection signals, are the inputs for this pipeline.

Also, test-data for running this pipeline is a subset of chromosome 22.

---

If you want to know any command in detail, specially for references, please ask for the `Bitácora_Judith.md` file.
