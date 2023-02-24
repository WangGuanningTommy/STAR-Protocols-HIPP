Cohort_max_iterations_2_binning_factor_2 <- read.csv("txt/cohort 2-2.csv")

Cohort_max_iterations_4_binning_factor_2 <- read.csv("txt/cohort 4-2.csv")

table(Cohort_max_iterations_2_binning_factor_2$X0 
      == Cohort_max_iterations_4_binning_factor_2$X0)

Max_Iteration_Comparison_dataframe <- data.frame(M2B2 = Cohort_max_iterations_2_binning_factor_2$X0, M4B2 = Cohort_max_iterations_4_binning_factor_2$X0)

library("ggplot2")

Max_Iteration_Comparison <- ggplot(Max_Iteration_Comparison_dataframe) + geom_point(aes(x = M2B2, y = M4B2)) + labs(title = "EMD Scores", x = "max iterations = 2", y = "max iterations = 4", size = 20) + theme_classic()

Max_Iteration_Comparison

ggsave("EMD Scores by Different Max Iteration.png", Max_Iteration_Comparison, width = 5.2, height = 5, dpi = 300)
