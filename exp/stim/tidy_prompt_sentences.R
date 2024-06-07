# Tidy prompt sentences -------------------------------------------------------
#
# - Get prompt sentences from galego questionnaire
# - Tidy and add conditions for each prompt
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "R","00_libs.R"))

# -----------------------------------------------------------------------------

# Read the contents of the .Rmd file
file_path <- here("questionnaire_galego.qmd"
content <- readLines(file_path)

# Filter out commented lines and extract strings after numbers
extracted_strings <- stringr::str_extract(content, "\\d+\\.\\s*(\\S.*)")

# Make into a df
sentences <- as.tibble(extracted_strings) %>%
  filter(!is.na(value)) %>%
  slice(seq(2, n(), by = 2)) %>%
  mutate(
    value = sub("^\\d+\\.\\s*", "", value)
  ) %>%
  rename(
    prompt = value
  )
