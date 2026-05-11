# ============================================================
# data_carpentry.R
# Friesen et al. 2026 - V1aR social experience
#
# Purpose: Load, clean, and reshape raw data for analysis
# ============================================================

library(tidyverse)

# --- Load raw data -----------------------------------------------------------

binding <- read_csv("data_raw/V1aR_binding_density.csv")
metadata <- read_csv("data_raw/subject_metadata.csv")

# --- Merge -------------------------------------------------------------------

dat <- left_join(binding, metadata, by = "subject_id")

# --- Factor coding -----------------------------------------------------------

dat <- dat %>%
  mutate(
    sex       = factor(sex,       levels = c("male", "female")),
    condition = factor(condition, levels = c("baseline", "experienced"))
  )

# --- Reshape to long format (for region-level analyses) ----------------------

brain_regions <- c("VDB", "HDB", "LS_anterior", "LS_posterior",
                   "VP", "LHA", "LHb", "SUM")

dat_long <- dat %>%
  pivot_longer(
    cols      = all_of(brain_regions),
    names_to  = "region",
    values_to = "binding_density"
  ) %>%
  mutate(region = factor(region, levels = brain_regions))

# --- Save cleaned data -------------------------------------------------------

saveRDS(dat,      "data_raw/dat_wide.rds")
saveRDS(dat_long, "data_raw/dat_long.rds")

message("Data carpentry complete. Objects saved: dat_wide.rds, dat_long.rds")
