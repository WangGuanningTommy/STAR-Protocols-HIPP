# STAR-Protocols-HIPP

Large-scale high-throughput immune profiling is required to study the pharmacodynamic effects of drugs on the human immune system in clinical trials.
The Human Immune Profiling Pipeline (HIPP) provides an end-to-end solution from flow cytometry data to computational approaches (dimension reduction)
and unbiased patient clustering based on lymphocyte landscape.
The HIPP can be applied to studying human immune responses in immunotherapy and vaccination, in blood and tumor, and in health and disease.
Moreover, this workflow might be adjusted to patient stratification and phenotyping based on other multi-parametric or high-dimensional data
like DNA/RNA sequencing, mass spectrometry, and biochemical tests.

## Requirements:
.fcs files with high dimensional features (umap_1, umap_2).  

# Scripts:
### FCS to TXT.R:
.fcs to .txt conversion.

Input: .fcs files with high dimensional features (umap_1, umap_2).  
Output: .txt files with "renamedcols".

### Config.R:
EMD algorithm settings

### Flow EMD.R:
Define functions for the EMD calculations.

### Emdist Cohort.R:
Perform EMD calculation.

Input: .txt files with “renamedcols” in the txt folder (from FCS to TXT.R).  
Output: EMD figures in the txt/graphics folder.

### EMD Clusting.R:
EMD visualization (heatmap).

Input: EMD results (from Emdist Cohort.R).  
Output: EMD results in heatmap.

### EMD Summary.R:
Summarize the file names and EMD groups in one spreadsheet.

Input: EMD results (from Emdist Cohort.R).  
Output: EMD results in spreadsheet.

### Max Iterations Comparison.R:
Optional script for different max iteration comparison in Config.R.

# Reference:
The Human Immune Profiling Pipeline for high-throughput interrogation of immune responses STAR Protocols (under revision)
