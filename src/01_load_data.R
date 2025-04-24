"Load data into report

Usage: src/01_load_data.R --output_path=<output_path> 

Options:
--output_path=<output_path>
" -> doc

library(docopt)
library(readr)

opt <- docopt::docopt(doc)

data <- penguins

# Initial cleaning: Remove missing values
data <- data %>% drop_na()

readr::write_csv(data, opt$output_path)