# Differential Gene Expression Analysis — GSE148355

This folder contains a complete DESeq2-based analysis of the **GSE148355** dataset, which compares **liver tissue samples from total hepatectomy patients** versus **normal tissues**.

## 📌 Objective

Identify significantly differentially expressed genes (DEGs) between two groups (hepatectomy vs. normal tissue), and visualize the results using standard bioinformatics plots.

---

## 🧬 Dataset Description

- **Source:** [GEO: GSE148355](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE148355)  
- **Groups:**
  - **Case:** Total hepatectomy samples (e.g., GSM4462519–GSM4462583)
  - **Control:** Normal liver tissues (e.g., GSM4462456–GSM4462471)

---

## 🧪 Analysis Pipeline

The analysis was performed in R using the following steps:

1. Load raw count matrix and gene annotation
2. Filter low-expression and low-variance genes
3. Construct metadata and create DESeq2 object
4. Run DESeq2 and apply log2 fold change shrinkage with `apeglm`
5. Export full and filtered DEG lists
6. Visualize results using:
   - MA Plot
   - Volcano plot (all genes & top 20)
   - Heatmap of significant genes

> 📂 See the R script: `DEG_analysis_GSE148355.R`

---

## 📁 Output Files

| File | Description |
|------|-------------|
| `DEGs_GSE148355_filtered.csv` | Table of significant DEGs (FDR < 0.05 and |log2FC| > 1) |
| `res-plot.pdf`                | MA plot of DEGs |
| `Volcano3.pdf`               | Volcano plot with top 20 genes |
| `Heatmap-top.pdf`           | Heatmap of most significant DEGs |

---

## 📦 Required Packages

- DESeq2
- apeglm
- ggplot2
- RColorBrewer
- pheatmap
- EnhancedVolcano

You can install the missing packages using:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("DESeq2", "apeglm", "EnhancedVolcano"))
install.packages(c("pheatmap", "ggplot2", "RColorBrewer"))

---

## 📘 License
This example is provided as part of the Bioinformatics-Templates repository under the MIT License.



