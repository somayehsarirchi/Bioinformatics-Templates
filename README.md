# Bioinformatics Analysis Templates

This repository contains modular R/bash pipelines and example datasets for common bioinformatics workflows. It includes end-to-end analysis scripts and results for:

- 🧬 Bulk RNA-Seq differential expression analysis (DESeq2)
- 🌡 Heatmap generation
- 🌋 Volcano plot visualization
- 🧬 VCF filtering for WES-derived variant files
- 🧪 Weighted Gene Co-expression Network Analysis (WGCNA)
- 🔁 Raw RNA-Seq data preprocessing from FASTQ to Count Matrix

⚠️ **All data and results are included for demonstration purposes only and contain no real patient identifiers or confidential content.**

---

## 📁 Folder Structure

```
Bioinformatics-Templates/
├── README.md
├── CITATION.cff
├── LICENSE
├── demo_analysis.Rmd
├── deseq2/                   # DESeq2 pipeline + example data
├── heatmap/                  # Heatmap template + matrix
├── volcano/                  # Volcano plot script + matrix
├── vcf_filtering/            # VCF filtering script + demo data
├── Raw_FASTQ_to_CountMatrix/ # Raw FASTQ → Count Matrix Bash pipeline
│   └── scripts/
├── GSE148355_WGCNA/          # WGCNA analysis example on GEO dataset
```

---

## 📜 Scripts Overview

| Script Name                 | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| `DESeq2_pipeline.R`         | Normalize RNA-Seq counts and identify DEGs                                  |
| `Heatmap_Template.R`        | Generate clustered heatmap from expression matrix                           |
| `volcano_plot.R`            | Create volcano plot of DEGs from DESeq2 results                             |
| `VCF_Filtering.R`           | Apply filters to VCF files based on quality/depth/etc.                      |
| `pipeline.sh`               | Bash pipeline from `fastq-dump` to `htseq-count`                            |
| `WGCNA_analysis.R`          | Full WGCNA pipeline using GSE148355 dataset                                 |

---

## 📂 Sample Data

| File                        | Description                                               |
|----------------------------|-----------------------------------------------------------|
| `example_counts.txt`        | Simulated raw count matrix                                |
| `example_metadata.csv`      | Sample metadata with group labels                        |
| `expression_matrix.csv`     | Expression matrix for heatmap/volcano                    |
| `myvcf.vcf`                 | Demo VCF file for variant filtering                      |
| `vcf_filtered.csv`          | Filtered VCF output                                      |
| `GSE148355_raw_counts.csv`  | Real RNA-Seq counts from GEO                              |
| `traits.csv`                | Sample traits (e.g. group, gender, age)                  |

---

## 🚀 How to Use

1. Clone the repository:
```bash
git clone https://github.com/somayehsarirchi/Bioinformatics-Templates.git
cd Bioinformatics-Templates
```

2. Navigate to the relevant analysis folder (e.g., `deseq2/`, `GSE148355_WGCNA/`)

3. Run the script in R, RStudio, or terminal:
```r
source("DESeq2_pipeline.R")
```

4. Render the demo notebook (optional):
Open `demo_analysis.Rmd` in RStudio and click **Knit** to generate the report.

---

## ⚙️ Requirements

- R version ≥ 4.2
- Tools: [sratoolkit](https://github.com/ncbi/sra-tools), [HISAT2](https://daehwankimlab.github.io/hisat2/), [HTSeq](https://htseq.readthedocs.io/)
- Required R packages: `DESeq2`, `WGCNA`, `pheatmap`, `ggplot2`, `readr`, `Hmisc`, `enrichR`, etc.
- Bash and Java (for FASTQ processing)

---

## 📜 License

This project is licensed under the [MIT License](./LICENSE).

---

## 📦 Citation

If you use this repository or its scripts, please cite it as:

Somayeh Sarirchi (2025). *Bioinformatics Analysis Templates: RNA-seq, VCF filtering, and Visualization Pipelines*. GitHub repository: https://github.com/somayehsarirchi/Bioinformatics-Templates  
DOI: [10.5281/zenodo.16493302](https://doi.org/10.5281/zenodo.16493302)

---

## 👩‍🔬 Author

**Somayeh Sarirchi**  
Bioinformatics Scientist  
📧 s.sarirchi@gmail.com  
🔗 [GitHub Profile](https://github.com/somayehsarirchi)
