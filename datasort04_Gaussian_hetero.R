
# Read data ----
  d1 <- read.csv("result/sim_model_simple_hetero_Gaussian2020-05-19.csv")
  d2 <- read.csv("result/sim_model_truncated_hetero_Gaussian2020-05-23.csv")
  d3 <- read.csv("result/sim_model_disp_obs_hetero_Gaussian2020-05-23.csv")
  d1$model <- "simple"; d1$model_code <- "m1"
  d2$model <- "truncation"; d2$model_code <- "m2"
  d3$model <- "disp_obs"; d3$model_code <- "m3"
  
# Load data ----
  dat <- merge(d1, d2, all = T)
  dat <- merge(dat, d3, all = T)
  dat$bias <- 100*(dat$sigma_med - dat$SIGMA)/dat$SIGMA
  dat$CI <- dat$sigma_upper - dat$sigma_lower
  dat$THETA <- dat$SIGMA