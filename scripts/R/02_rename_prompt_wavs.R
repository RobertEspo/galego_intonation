# Rename prompt wavs ----------------------------------------------------------
#
# - Rename the wavs in questionnaire_galego_wav to match condition
# 
# -----------------------------------------------------------------------------

# Source libs -----------------------------------------------------------------

source(here::here("scripts", "R","00_libs.R"))

# -----------------------------------------------------------------------------

# Load csv with names and select condition col (where the names are stored)
questionnaire_galego_wav_names <- read_csv(here("exp","stim","questionnaire_galego.csv")) %>%
  select(condition) %>%
  transmute(
    new_name = paste(row_number(), sep = "_", condition)
  )

# Load file names from wavs dir in order
directory <- here("exp","stim","questionnaire_galego_wav")

# List all files in directory
all_files <- list.files(directory, full.names = TRUE)

# Sort them by order in the directory
old_names <- all_files[order(nchar(all_files), all_files)]

# Append old names to df with the new names
questionnaire_galego_wav_names$old_name <- old_names

# Rename all files in directory
for (i in 1:nrow(questionnaire_galego_wav_names)) {
  old_name <- old_names[old_names == questionnaire_galego_wav_names$old_name[i]]
  if (length(old_name) > 0) {
    new_name <- file.path(here("exp","stim","questionnaire_galego_wav"),
                               paste(questionnaire_galego_wav_names$new_name[i],".wav", sep = ""))
    file.rename(old_name,new_name)
  }
}
