# 📦 Load Required Libraries
if (!requireNamespace("DESeq2", quietly = TRUE)) BiocManager::install("DESeq2")
if (!requireNamespace("WGCNA", quietly = TRUE)) install.packages("WGCNA")
if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) BiocManager::install("EnhancedVolcano")
if (!requireNamespace("pheatmap", quietly = TRUE)) install.packages("pheatmap")
if (!requireNamespace("RColorBrewer", quietly = TRUE)) install.packages("RColorBrewer")

library(DESeq2)
library(WGCNA)
library(ggplot2)
library(RColorBrewer)
library(EnhancedVolcano)
library(pheatmap)

# 📂 Define File Paths (Relative Paths for GitHub Compatibility)
input_path <- "./"               # Assumes input files are in current working directory
output_path <- "./"              # Results will be written to current directory

# 📌 Load Raw Count Matrix
GSE148355 <- read.csv("GSE148355_raw_counts.csv", header = TRUE, row.names = 1, stringsAsFactors = FALSE)

# 📌 Load Gene Annotation and Set Row Names
GenIDGSE <- read.csv("Human.GRCh38.p13.annot.csv", header = TRUE, stringsAsFactors = FALSE)
rownames(GSE148355) <- make.unique(as.character(GenIDGSE[, 2]))

# 📌 Define Experimental Groups Based on GEO Sample IDs
totalHepatectomy <- c("GSM4462519", "GSM4462521", "GSM4462522", "GSM4462523", "GSM4462524", 
                      "GSM4462525", "GSM4462526", "GSM4462527", "GSM4462529", "GSM4462530", 
                      "GSM4462531", "GSM4462532", "GSM4462533", "GSM4462534", "GSM4462536", 
                      "GSM4462537", "GSM4462538", "GSM4462539", "GSM4462540", "GSM4462541", 
                      "GSM4462542", "GSM4462543", "GSM4462548", "GSM4462550", "GSM4462552", 
                      "GSM4462553", "GSM4462555", "GSM4462556", "GSM4462557", "GSM4462558", 
                      "GSM4462559", "GSM4462560", "GSM4462562", "GSM4462565", "GSM4462569", 
                      "GSM4462570", "GSM4462572", "GSM4462573", "GSM4462577", "GSM4462583")

NormalTissue <- c("GSM4462456", "GSM4462457", "GSM4462458", "GSM4462459", "GSM4462460",
                  "GSM4462461", "GSM4462462", "GSM4462463", "GSM4462464", "GSM4462465",
                  "GSM4462467", "GSM4462468", "GSM4462469", "GSM4462470", "GSM4462471")


# 📌 Subset and Filter Data
Case <- which(colnames(GSE148355) %in% totalHepatectomy)
Control <- which(colnames(GSE148355) %in% NormalTissue)
selected_samples <- c(Case, Control)
mydata <- GSE148355[, selected_samples]
mydata <- mydata[, order(colnames(mydata))]
mydata <- mydata[rowSums(mydata) > 0, ]

# Filter Low Expression and Low Variance Genes
mydata <- mydata[rowSums(mydata) > quantile(rowSums(mydata), 0.10), ]
mydata <- mydata[apply(mydata, 1, sd) > quantile(apply(mydata, 1, sd), 0.25), ]

# Metadata
conditions <- factor(c(rep("Control", length(Control)), rep("Case", length(Case))),
                     levels = c("Control", "Case"))
colData <- data.frame(row.names = colnames(mydata), condition = conditions)

# DESeq2 Analysis
dds <- DESeqDataSetFromMatrix(countData = mydata, colData = colData, design = ~ condition)
dds <- dds[rowSums(counts(dds)) > 10, ]
dds <- DESeq(dds)

# Shrinkage
if (!requireNamespace("apeglm", quietly = TRUE)) BiocManager::install("apeglm")
res <- lfcShrink(dds, coef = "condition_Case_vs_Control", type = "apeglm")

# Save Results
write.csv(as.data.frame(res), file.path(output_path, "DEGs_GSE148355.csv"))

# Significant DEGs
res_sig <- res[!is.na(res$padj) & res$padj < 0.05 & abs(res$log2FoldChange) > 1, ]
write.csv(as.data.frame(res_sig), file.path(output_path, "DEGs_GSE148355_filtered.csv"))

# MA Plot
plotMA(res, ylim = c(-5, 5))

# Volcano Plot
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1,
                title = 'Volcano Plot - Hepatectomy vs. Normal',
                subtitle = "Filtered by |LFC| > 1 and FDR < 0.05")

# Volcano Plot (Top 20 Genes)
top_genes <- head(rownames(res_sig[order(res_sig$padj), ]), 20)
EnhancedVolcano(res,
                lab = rownames(res),
                selectLab = top_genes,
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0.05,
                FCcutoff = 1,
                subtitle = "Top 20 Significant Genes")

# Heatmap
sig_gene_names <- rownames(res_sig)
heatmap_data <- mydata[sig_gene_names, ]
heatmap_data_log <- log2(heatmap_data + 1)

pheatmap(heatmap_data_log,
         show_rownames = FALSE,
         cluster_cols = TRUE,
         cluster_rows = TRUE,
         color = colorRampPalette(rev(brewer.pal(7, "RdBu")))(100),
         main = "Heatmap of Significant DEGs")

# Heatmap for Top 200
top200 <- rownames(res_sig[order(res_sig$padj), ])[1:min(200, nrow(res_sig))]
pheatmap(log2(mydata[top200, ] + 1),
         show_rownames = FALSE,
         cluster_cols = TRUE,
         cluster_rows = TRUE,
         main = "Top 200 Significant DEGs",
         color = colorRampPalette(rev(brewer.pal(7, "RdBu")))(100))



































