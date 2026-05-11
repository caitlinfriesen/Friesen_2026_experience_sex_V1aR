# About the project

This is a repository containing data and R code for the paper:

**Social experience affects patterns of vasopressin receptor 1a expression in a way that differs by sex**

Caitlin N. Friesen, Alexandra Selke, Geert J. de Vries, Aras Petrulis

Neuroscience Institute & Center for Behavioral Neuroscience, Georgia State University

*Hormones and Behavior* (2026) | doi: https://doi.org/10.1016/j.yhbeh.2026.105931

---

## Abstract

Social animals navigate aggressive and affiliative interactions in their pursuit to find a mate and reproduce. Vasopressin (AVP) and the vasopressin 1a receptor (V1aR) can modulate these interactions, often in sex-specific ways. Here we test whether social experience affects the expression of V1aR in male and female mice exposed to two conditions – one in which they interacted aggressively and sexually with unrelated conspecifics (experienced) and one in which they did not (baseline). We measured V1aR binding density across seven brain regions – the vertical and horizontal diagonal band (VDB, HDB), lateral septum (LS), ventral pallidum (VP), lateral hypothalamic area (LHA), lateral habenula (LHb), supramamillary nucleus (SUM). Using region-specific and multivariate analysis, we found that in the baseline condition, females had higher V1aR binding density in the HDB and anterior LS than males. No sex differences were found in the experienced condition. Patterns of correlations of V1aR binding across these seven brain regions also differed between baseline and experienced conditions for each sex. Importantly, changes in correlated patterns of V1aR binding density associated with experience also differed by sex. We identified focal brain regions associated with these changes that were male-specific (LS), female-specific (LHA, SUM), and shared between the sexes (VP, HDB). These findings highlight the presence of sex differences in, and potential plasticity of, V1aR expression in response to social experience.

---

## Contents

- 📁 **data_raw/** — Raw V1aR binding density measurements (fmol/mg) per subject across seven brain regions (VDB, HDB, LS anterior, LS posterior, VP, LHA, LHb, SUM), and subject-level metadata (sex, condition, age)

- 📁 **code_carpentry/** — Scripts for loading, cleaning, and reshaping raw data for analysis

- 📁 **code_functions/** — Custom R functions used across analyses, including region-level model fitting, emmeans contrasts, correlation matrix generation, and Fisher z-tests for comparing correlations

- 📁 **code_analysis/** — Statistical analysis scripts (region-specific sex × condition models, multivariate correlation analyses) and figure generation

---

## How to run locally

This project was developed in R. To work with the code you will need [R](https://cloud.r-project.org/) (≥ 4.2.0) and optionally [RStudio Desktop](https://rstudio.com/products/rstudio/download/).

To download the repository, click **Code → Download ZIP** at the top of this page and unzip it, or clone it via the command line:

```bash
git clone https://github.com/caitlinfriesen/Friesen_2026_experience_sex_V1aR.git
```

Open the project in RStudio, then run scripts in this order:

1. `code_carpentry/data_carpentry.R` — prepares data
2. `code_analysis/all_analysis.R` — runs all statistical analyses
3. `code_analysis/all_figures.R` — generates all figures

Required packages: `tidyverse`, `ggplot2`, `lme4`, `emmeans`, `corrplot`, `psych`

---

## How to cite

If you use these data or code, please cite:

> Friesen CN, Selke A, de Vries GJ, Petrulis A (2026). Social experience affects patterns of vasopressin receptor 1a expression in a way that differs by sex. *Hormones and Behavior*. https://doi.org/10.1016/j.yhbeh.2026.105931

---

## License

**Code:** [MIT License](LICENSE)
**Data and figures:** [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)
