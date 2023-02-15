# This script is adapted from https://github.com/sydneycytometry/CSV-to-FCS 
# Ashhurst TM, Marsh-Wakefield F, Putri GH et al. (2020). bioRxiv. 2020.10.22.349563.
# Adaptation 1: Modify the input from CSV to FCS and the output from FCS to TXT.
# Adaptation 2: Modify the column names to uMAP1 and uMAP2.

# Install packages if required
if(!require('flowCore')) {BiocManager::install("flowCore")}
if(!require('Biobase')) {install.packages('Biobase')}
if(!require('data.table')) {install.packages('data.table')}
if(!require('readr')) {install.packages("readr")}

# Load packages
library('flowCore')
library('Biobase')
library('data.table')
library('readr')

# Finds the directory where this script is located
dirname(rstudioapi::getActiveDocumentContext()$path)
getwd()
PrimaryDirectory <- getwd()
PrimaryDirectory

# Important, the only FCS files in the directory should be the one desired for analysis. If more than one are found, only the first file will be used
# See a list of FCS files
FileNames <- list.files(path=PrimaryDirectory, pattern = ".fcs$")

# See file names in a list
as.matrix(FileNames) # See file names in a list

# Read data from Files into list of data frames
# Creates and empty list to start
DataList=list()

# Loop to read files into the list
for (File in FileNames) {
  tempdata <- exprs(read.FCS(File, transformation = FALSE))
  tempdata <- tempdata[1:nrow(tempdata),1:ncol(tempdata)]
  File <- gsub(".fcs", "", File)
  DataList[[File]] <- tempdata
}

rm(tempdata)
AllSampleNames <- names(DataList)

# Check data quality
head(DataList)

# System time 
x <- Sys.time()
x <- gsub(":", "-", x)
x <- gsub(" ", "_", x)

# Create output folder
newdir <- paste0("Output_FCS-to-TXT", "_", x)
setwd(PrimaryDirectory)
dir.create(paste0(newdir), showWarnings = FALSE)
setwd(newdir)

# Write files
for(i in c(1:length(AllSampleNames))){
  data_subset <- DataList[i][[1]]
  data_subset <- as.data.frame(data_subset)
  colnames(data_subset)
  dim(data_subset)
  a <- names(DataList)[i]
  write.table(data_subset, paste0(a, ".txt"), sep = "\t", col.names = NA)
}

# Write files with uMAP1 and uMAP2 columns
# These files will be used for next step
FileNames <- list.files(pattern = ".txt")
i <- 1
for(i in 1:length(FileNames)){
  txtFile <- read.table(FileNames[i], header = TRUE)
  uMAPcolumns <- grep( "umap_.", colnames(txtFile))
  txtFile <- txtFile[,c(1,uMAPcolumns)]
  colnames(txtFile) <- c("cell_ID","uMAP1", "uMAP2")  
  write_tsv(txtFile, paste0(FileNames[i], "_renamedcols.txt"))
}
