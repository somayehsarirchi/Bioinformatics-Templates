# Volcano Plot Template using DESeq2 Results
library(ggplot2)

# Read results
res <- read.csv("DESeq2_results.csv")

# Define thresholds
res$threshold <- as.factor(abs(res$log2FoldChange) > 1 & res$padj < 0.05)

# Plot
ggplot(res, aes(x=log2FoldChange, y=-log10(padj), color=threshold)) +
  geom_point(alpha=0.6, size=1.75) +
  theme_minimal() +
  labs(title="Volcano Plot", x="log2 Fold Change", y="-log10 Adjusted P-value") +
  scale_color_manual(values=c("gray", "red"))
