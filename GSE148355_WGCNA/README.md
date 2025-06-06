# Work Sample – WGCNA Analysis of GSE148355 RNA-Seq Data

This project simulates a freelance bioinformatics task, where a client requested a complete **Weighted Gene Co-expression Network Analysis (WGCNA)** of the [GSE148355](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE148355) RNA-Seq dataset to identify co-expression modules and their associations with clinical traits (population, gender, age).

---

## 🎯 Objective

- Filter highly variable genes
- Identify network modules via WGCNA
- Correlate modules with clinical traits
- Extract and annotate hub genes in significant modules (e.g., green module)
- Visualize dendrograms, trait heatmaps, and MM vs GS plots

---

## 📁 Folder Structure

### `Client Inputs/`
- Raw counts and sample metadata
- Annotation file
- Simulated task description from client

### `Expected Output/`
- Filtered gene expression matrix
- Annotated hub genes in the green module
- All plots saved in `Figures/`

### `Task Brief/`
- Simulated prompt and technical description

### `Compliance/`
- Declaration of originality, public data usage, and license compliance

### `Scripts/`
- Fully reproducible R script (`GSE148355_WGCNA.R`) with relative paths

---

## 📊 Key Findings

- The **green module** was strongly associated with population group (r = 0.63, p = 1.7e−06)
- Multiple hub genes with high module membership (MM > 0.8) and gene significance (GS > 0.2) were identified
- Visualizations and exported data are included in `Expected Output/`

---

## ⚖️ Licensing & Ethics

- Data source: [NCBI GEO – GSE148355](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE148355)
- No confidential or personally identifiable data used
- Work created independently for demonstration; not tied to any client or institution

---

## 📬 Contact

Feel free to reach out for full pipeline extensions (e.g., enrichment analysis, raw FASTQ processing), new datasets, or custom client requests.

