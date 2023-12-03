
library(FactoMineR)

# Reading the dataset
data <- read.csv("balanced_dataset.csv")

# Selecting only the numerical columns for PCA, excluding 'id', 'sentry_object', and 'hazardous'
selected_columns <- data[, c('est_diameter_min', 'est_diameter_max', 'relative_velocity', 'miss_distance', 'absolute_magnitude')]

# Performing PCA
pca_results <- PCA(selected_columns, scale.unit = TRUE, graph = FALSE)

# Returning the summary of PCA results
summary(pca_results)

