### Code for: Modeling dispersal using capture-recapture data: a comparison of dispersal models

Journal: Ecological Research  
Author: Akira Terui  

### Content

#### Supporting Information
* `ecores_support-info.Rmd`: Rmarkdown for Supporting Information  

#### Data management

* `datasort01_laplace.R`: merging the results of Laplace models  
* `datasort02_gaussian.R`: merging the results of Gaussian models  
* `datasort03_laplace_hetero.R`: merging the results of Laplace models (recapture probability varies among individuals)  
* `datasort04_gaussian_hetero.R`: merging the results of Gaussian models (recapture probability varies among individuals)  
* `datasort05_basic-stats.R`: basic statistics (the range of the proportion of stayers/recaptures)  
* `datasort06_table-si.R`: scripts for SI tables  

#### Figures

* `figure01_kernel.R`: script for figure 1  
* `figure02a_pstay_laplace.R`: script for figure 2  
* `figure02b_pstay_gaussian.R`: script for figure 3  
* `figure03a_delta.R`: script for figure 4  
* `figure03b_sigma.R`: script for figure 5  
* `figure04a_phi_laplace.R`: script for figure 6  
* `figure04b_phi_gaussian.R`: script for figure 7  
* `function_simdata_ver5.R`: function for simulated data  

#### Data

* `result` directory: simulation results. Files were named after the following rule `sim_model_MODELTYPE_PHI-SETTING_DISTRIBUTION.csv`  

  ##### Column specification
  * `N`: the number of marked individulas
  * `LEN`: section length
  * `DELTA` or `SIGMA`: true dispersal parameter
  * `Pcap`: proportion of recapture
  * `Pstay`: proportion of stayers
  * `delta_lower` or `sigma_lower`: lower 95% CI of estimated dispersal parameter
  * `med_lower`: median estimate of dispersal parameter
  * `delta_lower` or `sigma_upper`: upper 95% CI of estimated dispersal parameter 
  * `phi_lower`: lower 95% CI of estimated recapture probability
  * `phi_med`: median estimate of recapture probability
  * `phi_upper`: upper 95% CI of estimated recapture probability
  * `R_hat_delta` or `R_hat_sigma`: R hat value of estimated dispersal parameters
  * `R_hat_phi`: R hat value of estimated drecapture probability
  * `MCMCiter`: MCMC iterations
  * `Burn_in`: MCMC burnin
  * `N_thin`: MCMC thinning
  * `N_sample`: MCMC samples

#### Bayesian modeling (`bayes-model` directory)

##### Laplace (`laplace` directory)

* `inits01_simple_laplace.R`: script to run a simple dispersal model  
* `inits02_truncated_laplace.R`: script to run a truncated dispersal model   
* `inits03_disp_obs_laplace.R`: script to run a dispersal observation model  
* `inits04_hetero_simple_laplace.R`: script to run a simple dispersal model (simulated with variation in recapture probability)  
* `inits05_hetero_truncated_laplace.R`: script to run a truncated dispersal model (simulated with variation in recapture probability)  
* `inits06_hetero_disp_obs_laplace.R`: script to run a dispersal observation model (simulated with variation in recapture probability)  
* `model_simple_laplace_v1.R`: JAGS script for a simple dispersal model  
* `model_truncated_laplace_v1.R`: JAGS script for a truncated dispersal model  
* `model_disp_obs_laplace_v1.R`: JAGS script for a dispersal-observation model  

##### Gaussian (`gaussian` directory)

* `inits01_simple_gaussian.R`: script to run a simple dispersal model  
* `inits02_truncated_gaussian.R`: script to run a truncated dispersal model   
* `inits03_disp_obs_gaussian.R`: script to run a dispersal observation model  
* `inits04_hetero_simple_gaussian.R`: script to run a simple dispersal model (simulated with variation in recapture probability)  
* `inits05_hetero_truncated_gaussian.R`: script to run a truncated dispersal model (simulated with variation in recapture probability)  
* `inits06_hetero_disp_obs_gaussian.R`: script to run a dispersal observation model (simulated with variation in recapture probability)  
* `model_simple_gaussian_v1.R`: JAGS script for a simple dispersal model  
* `model_truncated_gaussian_v1.R`: JAGS script for a truncated dispersal model  
* `model_disp_obs_gaussian_v1.R`: JAGS script for a dispersal-observation model  
