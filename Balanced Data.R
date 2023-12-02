# Load necessary library
library(dplyr)
# Read the dataset
data <- read.csv('neo_v2.csv')

# Remove duplicates based on ID
data_unique <- data %>% distinct(id, .keep_all = TRUE)

# Splitting the data into hazardous and non-hazardous datasets
hazardous_data <- filter(data_unique, hazardous == TRUE)
non_hazardous_data <- filter(data_unique, hazardous == FALSE)

# Calculate the total number of samples needed
total_samples <- nrow(data_unique)

# Since hazardous data is only 20% of the dataset, we use all of it
hazardous_samples <- nrow(hazardous_data)

# Calculate the number of non-hazardous samples needed to achieve the 55% ratio
# For this, first calculate the total desired size of the final dataset
final_dataset_size <- hazardous_samples / 0.45
non_hazardous_samples <- round(final_dataset_size * 0.55)

# Adjust in case the calculation exceeds the available non-hazardous data
non_hazardous_samples <- min(non_hazardous_samples, nrow(non_hazardous_data))

# Sample the non-hazardous data
sampled_non_hazardous <- sample_n(non_hazardous_data, non_hazardous_samples)

# Combine the samples (all hazardous data and sampled non-hazardous data)
final_dataset <- rbind(hazardous_data, sampled_non_hazardous)

# Shuffle the final dataset
set.seed(123)
final_dataset <- final_dataset[sample(nrow(final_dataset)),]

# Save the final dataset
write.csv(final_dataset, "balanced_dataset.csv", row.names = FALSE)
