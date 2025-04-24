"Fit a classification model using `tidymodels` to predict the species of a penguin based on its physical characteristics

Usage: src/03_model.R --input_path=<input_path> --output_path_train=<output_path_train> --output_path_test=<output_path_test> --output_path_model=<output_path_model>

Options:
--input_path=<input_path>
--output_path_train=<output_path_train>
--output_path_test=<output_path_test>
--output_path_model=<output_path_model>
" -> doc

library(docopt)
library(readr)

opt <- docopt::docopt(doc)

data <- readr::read_csv(opt$input_path)

# Split data
set.seed(123)
data_split <- initial_split(data, strata = species)
train_data <- training(data_split)
test_data <- testing(data_split)

# Define model
penguin_model <- nearest_neighbor(mode = "classification", neighbors = 5) %>%
  set_engine("kknn")

# Create workflow
penguin_workflow <- workflow() %>%
  add_model(penguin_model) %>%
  add_formula(species ~ .)

# Fit model
penguin_fit <- penguin_workflow %>%
  fit(data = train_data)

# Save train and test data  
readr::write_csv(train_data, opt$output_path_train)
readr::write_csv(test_data, opt$output_path_test)

# Save model
readr::write_rds(penguin_fit, opt$output_path_model)
