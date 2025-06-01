# VCF_Filtering.R
# Parse and filter VCF for high-quality variants

# Load packages
library(dplyr)

# Read VCF lines
vcf_lines <- readLines("myvcf.vcf")

# Extract header (lines starting with ##) and column names (line starting with #CHROM)
header <- vcf_lines[grep("^##", vcf_lines)]
column_names <- strsplit(vcf_lines[grep("^#CHROM", vcf_lines)], "\t")[[1]]

# Extract variant data (lines not starting with #)
variant_lines <- vcf_lines[!grepl("^#", vcf_lines)]
vcf_df <- read.table(text = variant_lines, sep = "\t", header = FALSE, stringsAsFactors = FALSE)
colnames(vcf_df) <- column_names

# Split INFO field into individual components
extract_info_field <- function(info, key) {
  match <- regmatches(info, regexpr(paste0(key, "=.*?;"), info))
  value <- sub(paste0(key, "="), "", sub(";$", "", match))
  return(as.numeric(value))
}

vcf_df$QD <- sapply(vcf_df$INFO, extract_info_field, key = "QD")
vcf_df$FS <- sapply(vcf_df$INFO, extract_info_field, key = "FS")
vcf_df$SOR <- sapply(vcf_df$INFO, extract_info_field, key = "SOR")
vcf_df$DP <- sapply(vcf_df$INFO, extract_info_field, key = "DP")
vcf_df$GQ <- sapply(vcf_df$INFO, extract_info_field, key = "GQ")

# Filter variants based on thresholds
filtered_vcf <- vcf_df %>%
  filter(QD >= 2, FS <= 60, SOR <= 3, DP >= 10, GQ >= 20)

# Save filtered output
write.csv(filtered_vcf, "vcf_filtered.csv", row.names = FALSE)
