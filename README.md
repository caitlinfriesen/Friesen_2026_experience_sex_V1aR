# V1aR_social_experience

Data and Code for Friesen et al. 2026

"Social experience affects patterns of vasopressin receptor 1a expression in a way that differs by sex"

Caitlin N. Friesen, Alexandra Selke, Geert J. de Vries, Aras Petrulis

Neuroscience Institute & Center for Behavioral Neuroscience, Georgia State University

*Hormones and Behavior* (2026) | doi: https://doi.org/10.1016/j.yhbeh.2026.105931

---

## Abstract

Social animals navigate aggressive and affiliative interactions in their pursuit to find a mate and reproduce. Vasopressin (AVP) and the vasopressin 1a receptor (V1aR) can modulate these interactions, often in sex-specific ways. Here we test whether social experience affects the expression of V1aR in male and female mice exposed to two conditions – one in which they interacted aggressively and sexually with unrelated conspecifics (experienced) and one in which they did not (baseline). We measured V1aR binding density across seven brain regions – the vertical and horizontal diagonal band (VDB, HDB), lateral septum (LS), ventral pallidum (VP), lateral hypothalamic area (LHA), lateral habenula (LHb), supramamillary nucleus (SUM). Using region-specific and multivariate analysis, we found that in the baseline condition, females had higher V1aR binding density in the HDB and anterior LS than males. No sex differences were found in the experienced condition. Patterns of correlations of V1aR binding across these seven brain regions also differed between baseline and experienced conditions for each sex. Importantly, changes in correlated patterns of V1aR binding density associated with experience also differed by sex. We identified focal brain regions associated with these changes that were male-specific (LS), female-specific (LHA, SUM), and shared between the sexes (VP, HDB). These findings highlight the presence of sex differences in, and potential plasticity of, V1aR expression in response to social experience.

---

## Repository Structure

```
V1aR_social_experience/
├── README.md
├── data_raw/               # Raw V1aR binding density data and subject metadata
├── code_carpentry/         # Data cleaning and preparation scripts
├── code_functions/         # Custom functions used across analyses
└── code_analysis/          # Statistical analysis and figure generation scripts
```

---

## Data Description

**`data_raw/`** contains:
- `V1aR_binding_density.csv` — V1aR binding density (fmol/mg) measurements per subject across seven brain regions: VDB, HDB, LS (anterior and posterior), VP, LHA, LHb, and SUM
- `subject_metadata.csv` — Subject-level data including sex (male/female), condition (baseline/experienced), and any relevant biological measures

---

## Analysis Overview

Analyses were conducted in R. The main steps are:

1. **Data carpentry** (`code_carpentry/`) — loading raw data, quality checks, reshaping to long/wide formats for analysis
2. **Region-specific analyses** (`code_analysis/`) — linear models testing effects of sex, condition, and their interaction on V1aR binding density in each of the seven brain regions
3. **Multivariate analyses** (`code_analysis/`) — correlation matrix analyses examining co-expression patterns of V1aR binding across brain regions, compared between sexes and conditions
4. **Figures** (`code_analysis/`) — all plots used in the manuscript

---

## Requirements

- R (≥ 4.2.0)
- Packages: `tidyverse`, `ggplot2`, `lme4`, `emmeans`, `corrplot`, `psych`

---

## Citation

If you use these data or code, please cite:

> Friesen CN, Selke A, de Vries GJ, Petrulis A (2026). Social experience affects patterns of vasopressin receptor 1a expression in a way that differs by sex. *Hormones and Behavior*. doi: https://doi.org/10.1016/j.yhbeh.2026.105931
