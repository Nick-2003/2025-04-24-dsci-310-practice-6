"Test the usage of packages in the report

Usage: src/05_package.R --output_path=<output_path> 

Options:
--output_path=<output_path>

" -> doc

library(docopt)
library(readr)
library(package20250424)

opt <- docopt::docopt(doc)

# Explicit namespace use
calls <- c("package20250424::is_leap(2000)",
           "package20250424::temp_conv(5, 'C', 'K')",
           "package20250424::str_split_one('a,b,c', ',')")

# Evaluate each safely
outputs <- sapply(calls, function(call) {
  tryCatch({
    eval(parse(text = call))
  }, error = function(e) {
    paste("Error:", e$message)
  })
})

# Create dataframe
func_outputs <- data.frame(
  Function = calls,
  Output = outputs,
  stringsAsFactors = FALSE
)
func_outputs

readr::write_csv(func_outputs, opt$output_path)