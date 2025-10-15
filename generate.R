################################################################################
# mccoy replication - numerical summaries
################################################################################
# load libraries
##############################
library(tidyverse)
library(xtable)
##############################
HANS_dat <- read.csv("results/hans_result.tsv", sep='\t')
MNLI_dat <- read.csv("results/mnli_bytarget.tsv", sep='\t')
################################################################################
# MNLI summary
MNLI_summary <- MNLI_dat |>
  group_by(model) |>                           # group by model
  summarise(average=mean(accuracy))  |>
  summarise(Mean=mean(average),                # mean
            standard_dev=sd(average),          # standard dev
            Minimum=min(average),              # min
            Maximum=max(average))              # max

################################################################################
# HANS summary
################################################################################
# summary of examples consistent with heuristic
HANS_consistent <- HANS_dat |> 
  filter(target=="entailment") |>              # filter out inconsistent egs.
  group_by(heuristic) |>                       # group by heuristic
  summarise(Mean=mean(accuracy),
            standard_dev=sd(accuracy),
            Minimum=min(accuracy),
            Maximum=max(accuracy))

# summary of examples inconsistent wit heuristic
HANS_inconsistent <- HANS_dat |> 
  filter(target=="non-entailment") |>          # filter out consistent egs.
  group_by(heuristic) |>                       # group by heuristic
  summarise(Mean=mean(accuracy),
            standard_dev=sd(accuracy),
            Minimum=min(accuracy),
            Maximum=max(accuracy))

################################################################################
# latex for table
################################################################################
# \begin{table}[t]
# \centering
# \setlength{\tabcolsep}{10pt}
# \begin{tabular}{l c ccc ccc}
# \toprule
# & \multirow{2}{*}{MNLI}
# & \multicolumn{3}{c}{HANS: Consistent with heuristic}
# & \multicolumn{3}{c}{HANS: Inconsistent with heuristic} \\
# \cmidrule(lr){3-5}\cmidrule(l){6-8}
# & & Lexical & Subseq. & Const. & Lexical & Subseq. & Const. \\
# \midrule
# Minimum             & 0.835 & 0.943 & 0.985 & 0.982 & 0.097 & 0.018 & 0.057 \\
# Maximum             & 0.842 & 0.975 & 0.997 & 0.999 & 0.527 & 0.084 & 0.189 \\
# Mean                & 0.839 & 0.961 & 0.994 & 0.992 & 0.303 & 0.052 & 0.114 \\
# Standard deviation  & 0.002 & 0.010 & 0.003 & 0.014 & 0.126 & 0.021 & 0.038 \\
# \bottomrule
# \end{tabular}
# \end{table}
