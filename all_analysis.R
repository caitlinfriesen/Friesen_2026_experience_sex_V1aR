# ============================================================
# all_analysis.R
# Friesen et al. 2026 - V1aR social experience
#
# Purpose: All statistical analyses reported in the manuscript
# Run code_carpentry/data_carpentry.R first to generate .rds files
# ============================================================

library(tidyverse)
library(lme4)
library(emmeans)
library(psych)

source("code_functions/functions.R")

# --- Load cleaned data -------------------------------------------------------

dat      <- readRDS("data_raw/dat_wide.rds")
dat_long <- readRDS("data_raw/dat_long.rds")

brain_regions <- c("VDB", "HDB", "LS_anterior", "LS_posterior",
                   "VP", "LHA", "LHb", "SUM")


# ============================================================
# 1. REGION-SPECIFIC ANALYSES
#    Sex * Condition linear model per brain region
# ============================================================

region_models <- map(brain_regions, ~ fit_region_model(dat_long, .x))
names(region_models) <- brain_regions

# ANOVA tables
region_anova <- map(region_models, anova)

# Pairwise contrasts
region_contrasts <- map(region_models, get_contrasts)

# Print summaries
walk2(brain_regions, region_models, ~ {
  cat("\n====", .x, "====\n")
  print(summary(.y))
})


# ============================================================
# 2. BASELINE CONDITION: SEX DIFFERENCES
#    Reported: females > males in HDB and anterior LS
# ============================================================

baseline_dat <- dat_long %>% filter(condition == "baseline")

baseline_sex_models <- map(brain_regions, function(r) {
  d <- baseline_dat %>% filter(region == r)
  lm(binding_density ~ sex, data = d)
})
names(baseline_sex_models) <- brain_regions

walk2(brain_regions, baseline_sex_models, ~ {
  cat("\n[Baseline] Sex effect in", .x, "\n")
  print(summary(.y))
})


# ============================================================
# 3. EXPERIENCED CONDITION: SEX DIFFERENCES
#    Reported: no significant sex differences
# ============================================================

experienced_dat <- dat_long %>% filter(condition == "experienced")

experienced_sex_models <- map(brain_regions, function(r) {
  d <- experienced_dat %>% filter(region == r)
  lm(binding_density ~ sex, data = d)
})
names(experienced_sex_models) <- brain_regions


# ============================================================
# 4. MULTIVARIATE: CORRELATION MATRICES
#    V1aR co-expression patterns across regions by sex x condition
# ============================================================

cor_male_baseline    <- region_cor_matrix(dat, "male",   "baseline")
cor_male_exp         <- region_cor_matrix(dat, "male",   "experienced")
cor_female_baseline  <- region_cor_matrix(dat, "female", "baseline")
cor_female_exp       <- region_cor_matrix(dat, "female", "experienced")

# Sample sizes per group (needed for Fisher z tests)
n_per_group <- dat %>%
  count(sex, condition)
print(n_per_group)

# Example Fisher z test: male LS correlation, baseline vs. experienced
# (replace r values and n with actual values from your data)
# fisher_z_test(r1 = cor_male_baseline["LS_anterior","LS_posterior"],
#               r2 = cor_male_exp["LS_anterior","LS_posterior"],
#               n1 = n_male_baseline,
#               n2 = n_male_exp)


# ============================================================
# 5. SAVE RESULTS
# ============================================================

saveRDS(region_models,     "data_raw/region_models.rds")
saveRDS(region_contrasts,  "data_raw/region_contrasts.rds")

results_table <- map_dfr(brain_regions, function(r) {
  region_contrasts[[r]] %>% mutate(region = r)
})
write_csv(results_table, "data_raw/pairwise_contrasts.csv")

message("Analysis complete.")
