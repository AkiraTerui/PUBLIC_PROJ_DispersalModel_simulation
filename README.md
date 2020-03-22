# PUBLIC_PROJ_DispersalModel_simulation

This repository contains R and JAGS scripts for "Modelling dispersal using single-occassion capture-recapture data"
 
## File descriptions

### R scripts

* `function_simdata_ver4.R` an R function used to produce simulated capture-recapture locations
* `figure_Pstay_v1.R` an R script for figure 1
* `figure_delta_v1.R` an R script for figure 2
* `figure_deltaCI_v1.R` an R script for figure 3
* `figure_phi_v1.R` an R script for figure 4
* `inits_simple_laplace_v1.R` an R script for running the simple dispersal model ('model_simple_laplace_v1.R')
* `inits_truncated_laplace_v1.R` an R script for running the truncated dispersal model ('model_truncated_laplace_v1.R')
* `inits_disp_obs_laplace_v1.R` an R script for running the dispersal-observation model ('model_disp_obs_laplace_v1.R')

### JAGS scripts

* `model_simple_laplace_v1.R` a JAGS script for the simple dispersal model
* `model_truncated_laplace_v1.R` a JAGS script for the truncated dispersal model
* `model_disp_obs_laplace_v1.R` a JAGS script for the dispersal-observation model
