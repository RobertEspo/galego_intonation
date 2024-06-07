# Tidy prompt sentences -------------------------------------------------------
#
# - Get prompt sentences from galego questionnaire
# - Tidy and add conditions for each prompt
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "R","00_libs.R"))

# -----------------------------------------------------------------------------

# Read the contents of the .qmd file
file_path <- here("exp", "stim", "questionnaire_galego.qmd")
content <- readLines(file_path)

# Extract strings after numbers (ie the prompt sentenceS)
# This includes the commented-out prompts in Spanish
prompt <- stringr::str_extract(content, "\\d+\\.\\s*(\\S.*)")

# Make into a df
# Remove Spanish prompts
sentences <- as.data.frame(prompt) %>%
  filter(!is.na(prompt)) %>%
  slice(seq(2, n(), by = 2)) %>%
  mutate(
    prompt = sub("^\\d+\\.\\s*", "", prompt)
  )

# Read .csv for modality and type of each prompt's expected response
modality_type <- read_csv(here("exp","stim","modality_type.csv"))

# Combine dfs
questionnaire_galego <- cbind(sentences, modality_type)

# Add condition col to name .wav files
questionnaire_galego <- questionnaire_galego %>%
  mutate(
    condition = paste(modality, type, sep = "_")
  )

# Save df
write.csv(questionnaire_galego, here("exp", "stim", "questionnaire_galego.csv"), row.names = FALSE)

# Load df
questionnaire_galego <- read_csv(here("exp","stim","questionnaire_galego.csv"))
