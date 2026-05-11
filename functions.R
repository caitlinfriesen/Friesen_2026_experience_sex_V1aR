# ============================================================
# functions.R
# Friesen et al. 2026 - V1aR social experience
#
# Purpose: Custom helper functions used across analyses
# ============================================================

library(tidyverse)
library(emmeans)


# --- Region-level linear model -----------------------------------------------
# Fits sex * condition model for a single brain region
# Returns model object

fit_region_model <- function(data, region_name) {
  d <- data %>% filter(region == region_name)
  lm(binding_density ~ sex * condition, data = d)
}


# --- Extract emmeans contrasts -----------------------------------------------
# Returns tidy table of pairwise contrasts from a model

get_contrasts <- function(model, specs = ~ sex * condition) {
  emmeans(model, specs) %>%
    pairs(adjust = "tukey") %>%
    as.data.frame()
}


# --- Correlation matrix per group --------------------------------------------
# Computes Pearson correlation matrix of V1aR binding across brain regions
# for a given sex x condition subset

region_cor_matrix <- function(data, sex_val, condition_val,
                              regions = c("VDB", "HDB", "LS_anterior",
                                          "LS_posterior", "VP", "LHA",
                                          "LHb", "SUM")) {
  data %>%
    filter(sex == sex_val, condition == condition_val) %>%
    select(all_of(regions)) %>%
    cor(use = "pairwise.complete.obs", method = "pearson")
}


# --- Correlation difference test (Fisher z) ----------------------------------
# Tests whether two correlations differ significantly
# Returns z-statistic and two-tailed p-value

fisher_z_test <- function(r1, r2, n1, n2) {
  z1 <- atanh(r1)
  z2 <- atanh(r2)
  se <- sqrt(1 / (n1 - 3) + 1 / (n2 - 3))
  z  <- (z1 - z2) / se
  p  <- 2 * pnorm(abs(z), lower.tail = FALSE)
  data.frame(z_stat = z, p_value = p)
}
