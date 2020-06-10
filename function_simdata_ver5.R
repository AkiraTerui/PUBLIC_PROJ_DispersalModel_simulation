fun_disp <- function(N = 100, sec_len = 500,
                     delta, sigma, family = c("Laplace", "Gaussian"),
                     phi = 0.8, hetero.phi = F, sigma.phi){
  ## Arguments ##
  # N: number of individuals marked
  # sec_len: total section length L
  # delta: mean dispersal distance for a laplace distribution
  # sigma: dispersal variance for a normal distribution
  # phi: composite of detection and survival (probability)
  # sigma.phi: sd of phi among individuals
  
  # Define functions ----
    logit <- function(x) log(x/(1 - x) )
    ilogit <- function(x) exp(x)/(1 + exp(x) )
    library(nimble)
    
  # Dispersal process ----
    ## randomly assign capture locations to individuals
    mu <- runif(N, 0, sec_len) 
    
    ## simulate dispersal process
    if(family == "Laplace"){
      x <- x_stay <- x_true <- rdexp(N, location = mu, scale = delta) # true locations after dispersal
    }
    
    if(family == "Gaussian"){
      x <- x_stay <- x_true <- rnorm(N, mean = mu, sd = sigma) # true locations after dispersal
    }
    
  # Sampling process ----
    if(hetero.phi == F){
      ##  No individual-level heterogeneity in phi
      phi.i <- phi
      z <- rbinom(N, 1, phi)
    }
    
    if(hetero.phi == T){
      ##  Individual-level heterogeneity in phi
      logit.phi <- logit(phi)
      logit.phi.i <- rnorm(N, mean = logit.phi, sd = sigma.phi)
      phi.i <- ilogit(logit.phi.i)
      z <- rbinom(N, 1, phi.i)
    }
    
    x_stay[x_true < 0|x_true > sec_len] <- NA # insert NAs for those leaving the study stretch
    x[x_true < 0|x_true > sec_len|z == 0] <- NA # insert NAs for those leaving the study stretch AND/or dead/undetected
    
    return(list(x_stay = round(x_stay), X = round(x), X0 = round(mu), phi = phi.i) )
} 