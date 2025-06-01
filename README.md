# 🔬 Bioinformatics Analysis Templates

This repository contains modular and reusable R and Bash scripts for analyzing bulk RNA-Seq and variant call data (WES). It is intended to demonstrate practical, real-world pipelines that are well-documented and reproducible.

⚠️ **Note**: All data included here are simulated and for demonstration purposes only.

---

## 📁 Repository Structure

Bioinformatics-Templates/
├── README.md
├── demo_analysis.Rmd
├── deseq2/
│   ├── DESeq2_pipeline.R
│   ├── DESeq2_results.csv
│   ├── example_counts.txt
│   └── example_metadata.csv
├── heatmap/
│   ├── Heatmap_Template.R
│   ├── heatmap.png
│   └── normalized_counts.csv
├── vcf_filtering/
│   ├── VCF_Filtering.R
│   ├── myvcf.vcf
│   └── vcf_filtered.csv
└── volcano/
    ├── volcano_plot.R
    ├── volcano_plot.png
    └── expression_matrix.csv
---

## 📜 Included Scripts

| Script Name            | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `DESeq2_pipeline.R`    | Normalizes RNA-Seq count data and identifies differentially expressed genes |
| `VolcanoPlot.R`        | Generates a volcano plot from DESeq2 results                                |
| `Heatmap_Template.R`   | Draws a heatmap of selected or all genes using scaled expression data       |
| `VCF_Filtering.R`      | Parses and filters VCF data based on quality, depth, and other metrics      |

---

## 🧬 Sample Data

| File                   | Description                                      |
|------------------------|--------------------------------------------------|
| `example_counts.txt`   | Simulated count matrix (genes × samples)         |
| `example_metadata.csv` | Sample group labels (Control / Case)             |

---
Scripts Overview

DESeq2_pipeline.R: Full workflow for identifying differentially expressed genes using count and metadata input.

Heatmap_Template.R: Generates clustered heatmaps using normalized expression data.

VCF_Filtering.R: Parses and filters raw VCF data (SNP, InDel, Mixed) based on quality metrics (QD, FS, DP, GQ, SOR).

volcano_plot.R: Plots log2FoldChange vs. -log10(p-value) from DESeq2 results.

Usage

Each subfolder is self-contained. You can:

Download the full repo.

Navigate to a specific folder (e.g. deseq2/).

Run the corresponding .R script using R or RStudio.

Requirements

R >= 4.2

R packages: DESeq2, ggplot2, pheatmap, readr, dplyr, Hmisc, enrichR, etc.

For exact package requirements, see each script's header.




## ▶️ How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/somayehsarirchi/Bioinformatics-Templates.git
   cd Bioinformatics-Templates
Open any R script in the scripts/ folder and edit paths as needed.

Run the code using R or RStudio. Make sure required libraries (e.g., DESeq2, ggplot2, pheatmap) are installed.

💻 About
These scripts are part of my academic and freelance bioinformatics work. I regularly work with RNA-Seq, WES, and scRNA-seq datasets using tools such as DESeq2, HISAT2, GATK, Seurat, and custom Bash workflows.

If you're interested in custom pipelines or scientific collaboration, feel free to contact me.

Somayeh Sarirchi
Bioinformatics Scientist
📧 s.sarirchi@gmail.com
