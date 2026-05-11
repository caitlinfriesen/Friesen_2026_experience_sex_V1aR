# ============================================================
# all_figures.R
# Friesen et al. 2026 - V1aR social experience
#
# Purpose: Generate all manuscript figures
# Run all_analysis.R first
# ============================================================

library(tidyverse)
library(ggplot2)
library(corrplot)
library(patchwork)

source("code_functions/functions.R")

dat      <- readRDS("data_raw/dat_wide.rds")
dat_long <- readRDS("data_raw/dat_long.rds")

brain_regions <- c("VDB", "HDB", "LS_anterior", "LS_posterior",
                   "VP", "LHA", "LHb", "SUM")

# Shared theme
theme_paper <- theme_classic(base_size = 12) +
  theme(
    strip.background = element_blank(),
    strip.text       = element_text(face = "bold"),
    legend.position  = "bottom"
  )

sex_colors <- c("male" = "#4C8BB5", "female" = "#C9534F")


# ============================================================
# FIGURE 1: V1aR Binding Density by Region, Sex, and Condition
# ============================================================

fig1 <- ggplot(dat_long,
               aes(x = condition, y = binding_density,
                   color = sex, fill = sex)) +
  geom_boxplot(alpha = 0.3, outlier.shape = NA, width = 0.5,
               position = position_dodge(0.6)) +
  geom_jitter(position = position_jitterdodge(jitter.width = 0.1,
                                              dodge.width = 0.6),
              size = 1.5, alpha = 0.7) +
  facet_wrap(~ region, scales = "free_y", ncol = 4) +
  scale_color_manual(values = sex_colors, name = "Sex") +
  scale_fill_manual(values = sex_colors, name = "Sex") +
  labs(
    x = "Condition",
    y = "V1aR Binding Density (fmol/mg)",
    title = "V1aR Binding Density by Brain Region, Sex, and Condition"
  ) +
  theme_paper

ggsave("figures/fig1_binding_density.pdf", fig1,
       width = 12, height = 7, useDingbats = FALSE)
ggsave("figures/fig1_binding_density.png", fig1,
       width = 12, height = 7, dpi = 300)


# ============================================================
# FIGURE 2: Correlation Matrices (heatmaps)
#           2x2 grid: Male/Female x Baseline/Experienced
# ============================================================

cor_male_baseline   <- region_cor_matrix(dat, "male",   "baseline")
cor_male_exp        <- region_cor_matrix(dat, "male",   "experienced")
cor_female_baseline <- region_cor_matrix(dat, "female", "baseline")
cor_female_exp      <- region_cor_matrix(dat, "female", "experienced")

plot_cor <- function(mat, title) {
  corrplot(mat,
           method   = "color",
           type     = "upper",
           col      = colorRampPalette(c("#4C8BB5", "white", "#C9534F"))(200),
           tl.col   = "black",
           tl.srt   = 45,
           addCoef.col = "black",
           number.cex  = 0.7,
           title    = title,
           mar      = c(0, 0, 2, 0))
}

pdf("figures/fig2_correlation_matrices.pdf", width = 12, height = 11)
par(mfrow = c(2, 2))
plot_cor(cor_male_baseline,   "Males – Baseline")
plot_cor(cor_male_exp,        "Males – Experienced")
plot_cor(cor_female_baseline, "Females – Baseline")
plot_cor(cor_female_exp,      "Females – Experienced")
dev.off()


# ============================================================
# FIGURE 3: Mean binding density summary (bar + SE)
#           Useful for reporting key region effects
# ============================================================

summary_dat <- dat_long %>%
  group_by(sex, condition, region) %>%
  summarise(
    mean_bd = mean(binding_density, na.rm = TRUE),
    se_bd   = sd(binding_density, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  )

fig3 <- ggplot(summary_dat,
               aes(x = region, y = mean_bd,
                   fill = sex, group = sex)) +
  geom_col(position = position_dodge(0.7), width = 0.6, alpha = 0.85) +
  geom_errorbar(aes(ymin = mean_bd - se_bd, ymax = mean_bd + se_bd),
                position = position_dodge(0.7), width = 0.2) +
  facet_wrap(~ condition) +
  scale_fill_manual(values = sex_colors, name = "Sex") +
  labs(
    x = "Brain Region",
    y = "Mean V1aR Binding Density ± SE (fmol/mg)",
    title = "Mean V1aR Binding Density by Sex and Condition"
  ) +
  theme_paper +
  theme(axis.text.x = element_text(angle = 35, hjust = 1))

ggsave("figures/fig3_mean_binding.pdf", fig3,
       width = 10, height = 5, useDingbats = FALSE)
ggsave("figures/fig3_mean_binding.png", fig3,
       width = 10, height = 5, dpi = 300)

message("Figures saved to figures/")
