# This script is adapted from https://github.com/gooberholtzer/emd-on-tsne
# Adaptation: Made script more succinct and more efficient.

max_iterations <- 2

# A binning factor of 1 groups uMAP values into matrix coordinates based on simple rounding to whole numbers
# A factor of 2 (for example) creates half as many bins as a factor of 1 

binning_factor <- 2

print( sprintf("Max iterations is %d", max_iterations))
print( sprintf("Binning factor is %f", binning_factor ))