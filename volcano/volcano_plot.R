
# volcano_plot.R
# رسم Volcano Plot از خروجی DESeq2

library(ggplot2)

# خواندن داده
res <- read.csv("DESeq2_results.csv")

# تعریف significance
res$significant <- "Not Significant"
res$significant[res$padj < 0.05 & abs(res$log2FoldChange) >= 1] <- "Significant"

# رسم نمودار
p <- ggplot(res, aes(x=log2FoldChange, y=-log10(padj), color=significant)) +
  geom_point(alpha=0.7, size=1.5) +
  scale_color_manual(values=c("grey", "red")) +
  theme_minimal() +
  labs(title="Volcano Plot", x="log2(Fold Change)", y="-log10(Adjusted P-value)")

# ذخیره نمودار
ggsave("volcano_plot.png", p, width=6, height=5)
