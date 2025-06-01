# 🔬 Bioinformatics Analysis Templates

This repository contains modular and reusable R and Bash scripts for analyzing bulk RNA-Seq and variant call data (WES). It is intended to demonstrate practical, real-world pipelines that are well-documented and reproducible.

⚠️ **Note**: All data included here are simulated and for demonstration purposes only.

---

## 📁 Repository Structure

Bioinformatics-Templates/
├── README.md
├── scripts/
│ ├── DESeq2_pipeline.R
│ ├── VolcanoPlot.R
│ ├── Heatmap_Template.R
│ └── VCF_Filtering.R
├── data/
│ ├── example_counts.txt
│ └── example_metadata.csv
└── results/
└── demo_volcano_plot.png # optional

yaml
Copy
Edit

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
