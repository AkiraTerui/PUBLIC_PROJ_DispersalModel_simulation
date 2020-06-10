# General setup ----
  ## Function
  rm(list=ls(all.names=T))
  library(runjags)
  source("function_simdata_ver5.R")
  
  ## MCMC setting
  n.ad <- 100
  n.iter <- 1E+4
  n.thin <- max(3, ceiling(n.iter/500))
  burn <- ceiling(max(10, n.iter/2))
  Sample <- ceiling(n.iter/n.thin)
  
  ## Parameter set
  N <- c(100, 500, 1000)
  LEN <- c(500, 1000)
  DELTA <- seq(50, 300, length = 6)
  PHI <- c(0.4, 0.8)
  SIGMA.PHI <- 1
  PARA <- as.matrix(expand.grid(N, LEN, DELTA, PHI, SIGMA.PHI))
  Kernel <- "Laplace"
  colnames(PARA) <- c("N", "LEN", "DELTA", "PHI", "SIGMA.PHI")
  
  ## N replicate and N parameter combinations
  Nrep <- 50
  Npara <- nrow(PARA)

# Bayesian Inference ----  
  output <- NULL

  ## Different sampling designs and model parameters
  for(i in 1:Npara){
    RE <- NULL
    
    ## Replicates under the same sampling designs and model parameters
    for(j in 1:Nrep){
      print(c(i,j))
      delta <- PARA[i,"DELTA"]

      ## Simulated Data
      D <- fun_disp(N = PARA[i,"N"], sec_len = PARA[i,"LEN"],
                    delta = delta, family = Kernel,
                    phi = PARA[i,"PHI"], hetero.phi = T, sigma.phi = PARA[i,"SIGMA.PHI"])
      
      ## Data for JAGS
      X <- D$X
      X0 <- D$X0
      Y <- 1 - is.na(D$X)
      L <- PARA[i,"LEN"]
      
      ## Run JAGS
      Djags <- list( X = X, X0 = X0, Nsample = length(X), L = L )
      para <- c("delta")
      inits <- replicate(3, list(log.delta = log(delta), .RNG.name = "base::Mersenne-Twister", .RNG.seed = NA ), simplify = F )
      for(k in 1:3) inits[[k]]$.RNG.seed <- k
      
      m <- read.jagsfile("BayesModel/Laplace/model_truncated_laplace_v1.R")
      
      post <- run.jags(m$model, monitor = para, data = Djags,
                       n.chains = 3, inits = inits, method = "parallel",
                       burnin = burn, sample = Sample, adapt = n.ad, thin = n.thin,
                       n.sims = 3, modules = "glm")
      print(post$psrf$psrf[,1])
      
      while(any(post$psrf$psrf[,1] >= 1.1)){
        post <- extend.jags(post, burnin = 0, sample = Sample, adapt = n.ad, thin = n.thin,
                            n.sims = 3, combine = T)
        print(post$psrf$psrf[,1])
      }
      
      ## Output
      MCMCiter <- (post$sample/Sample)*n.iter + burn
      re <- summary(post)
      RE <- rbind(RE, c(PARA[i,],
                        mean(is.na(X)==0),
                        mean(is.na(D$x_stay)==0),
                        re["delta", 1:3],
                        re["delta", "psrf"],
                        MCMCiter, burn, n.thin, post$sample) )
      View(RE)
    }#j
    
    ## Compile final output
    output <- rbind(output, RE)
  }#i
  
# Save results ----
  colnames(output) <- c("N", "LEN", "DELTA", "PHI", "SIGMA.PHI",
                        "Pcap", "Pstay",
                        "delta_lower", "delta_med", "delta_upper",
                        "R_hat_delta",
                        "MCMCiter", "Burn_in", "N_thin", "N_sample")
  filename <- paste0("result/sim_model_truncated_hetero_", Kernel, Sys.Date(), ".csv")
  write.csv(output, filename)