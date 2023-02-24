# This script is adapted from https://github.com/gooberholtzer/emd-on-tsne
# Adaptation: Made script more succinct and more efficient.

source(file="Flow EMD.R")

cohort_dir <- paste(getwd(),"/txt", sep="")
output_file <- paste(cohort_dir,"/cohort.csv", sep="")
graphics_output_dir <- paste( cohort_dir, "/graphics", sep="")

count = 0;

run_emd <- function( sample1, sample2 ) {
  count <<- count + 1
  output_graphic_file <-  paste( graphics_output_dir, "/pairing_", count, ".png", sep="")
  results <- execute_emd( sample1, sample2, output_graphic_file )
  write.table( data.frame(as.list(results)), file = output_file, append = T, sep = ",", col.names = F, row.names = F) 
  return( results["result"])
}

unlink(paste(cohort_dir, "/cohort.csv", sep=""))

dir.create(graphics_output_dir, showWarnings = FALSE)
unlink( paste(graphics_output_dir, "/*.png", sep=""))

samples <- list.files(path = cohort_dir, pattern = "*.txt", full.names = T)

matrix_with_results <- outer( samples, samples, FUN= Vectorize(run_emd) )

print( sprintf("results are stored in %s", output_file))

