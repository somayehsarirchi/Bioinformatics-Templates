# 📦 Load libraries
if (!requireNamespace("DESeq2")) install.packages("DESeq2")
library(DESeq2)

# 📂 Load count data and metadata
counts <- read.table("../data/example_counts.txt", header = TRUE, row.names = 1)
metadata <- read.csv("../data/example_metadata.csv")
metadata$group <- as.factor(metadata$group)
rownames(metadata) <- metadata$sample
metadata <- metadata[colnames(counts), , drop = FALSE]  # match order

# 🔬 Create DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = metadata,
                              design = ~ group)

# 🧹 Filter low counts
dds <- dds[rowSums(counts(dds)) > 10, ]

# ⚙️ Run DESeq2 pipeline
dds <- DESeq(dds)

# 📈 Extract results
res <- results(dds)
res <- res[order(res$padj), ]
summary(res)

# 💾 Save results
write.csv(as.data.frame(res), "../results/DESeq2_results.csv", row.names = TRUE)
