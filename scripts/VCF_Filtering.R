# Basic VCF Filtering Template in R
vcf <- readLines("variants.vcf")
vcf <- vcf[!grepl("^##", vcf)]
vcf[1] <- gsub("#", "", vcf[1])
writeLines(vcf, "filtered_variants.tsv")

vcf_table <- read.table("filtered_variants.tsv", header=TRUE)

# Filter by quality
filtered <- subset(vcf_table, QUAL >= 60)
write.csv(filtered, "high_quality_variants.csv", row.names=FALSE)
