# This script is adapted from https://github.com/gooberholtzer/emd-on-tsne
# Adaptation 1: Made script more succinct and more efficient.
# Adaptation 2: Include the package installation codes.

# Install packages if required
if(!require('emdist')) {install.packages('emdist')}
if(!require('dplyr')) {install.packages('dplyr')}
if(!require('gplots')) {install.packages('gplots')}
if(!require('RColorBrewer')) {install.packages("RColorBrewer")}

# Load packages
library("emdist")
library("dplyr")
library("gplots")
library("RColorBrewer")

# source(file="Emdist Cohort.R")

setwd(".")
PrimaryDirectory <- paste(getwd(),"/txt", sep="")
cohort <- read.csv("txt/cohort.csv", header = FALSE)
FileNames <- list.files(path = PrimaryDirectory, pattern = "txt")

# Create a matrix from the spreadsheet
# Change nrow to = number of samples
emd_vector <- pull(cohort, V3)
emd_matrix <- matrix(emd_vector, nrow = length(FileNames))
rownames(emd_matrix) <- cohort[1:length(FileNames),1]
colnames(emd_matrix) <- cohort[1:length(FileNames),1]

# clutser rows and columns
clustRows <- hclust(as.dist(1-cor(t(emd_matrix), method = "pearson")),
                    method = "complete")

clustColumns <- hclust(as.dist(1-cor(t(emd_matrix), method = "pearson")),
                       method = "complete")

# Cut the resulting tree and create color vector for clusters.  
# Change the value of k to break into different groups
module.assign <- cutree(clustRows, k=5)
module.color <- rainbow(length(unique(module.assign)), start=0.1, end=0.9) 
module.color <- module.color[as.vector(module.assign)] 

# Make the heatmap
mypalette <- brewer.pal(11,"RdYlBu")
heatmap.2(emd_matrix, 
          Rowv=as.dendrogram(clustRows), 
          Colv=as.dendrogram(clustColumns),
          RowSideColors=module.color,
          col=mypalette, scale='row', labRow=NA,
          density.info="none", trace="none",  
          cexRow=1, cexCol=1, margins=c(8,20)) 