# Function ----
  rm(list=ls(all.names=T))
  library(runjags)
  source("function_simdata_ver4.R")

# MCMC setting ----
  n.ad <- 100
  n.iter <- 1E+4
  n.thin <- max(3, ceiling(n.iter/500))
  burn <- ceiling(max(10, n.iter/2))
  Sample <- ceiling(n.iter/n.thin)

# Parameter set ----
  N <- c(100, 500, 1000)
  LEN <- c(500, 1000)
  PHI <- c(0.4, 0.8)
  PARA <- as.matrix(expand.grid(N, LEN, PHI))
  colnames(PARA) <- c("N", "LEN", "PHI")

# Bayesian Inference ----  
  output <- NULL
  Nrep <- 100
  
  # Different sampling designs and model parameters
  for(i in 1:nrow(PARA) ){
    RE <- NULL
    
    # Generate dispersal parameters
    repeat{
      # to cover a wide range of values
      DELTA <- runif(Nrep, 10, 300)
      if(min(DELTA) < 20 & max(DELTA) > 290) break
    }#repeat
    
    # Replicates under the same sampling designs and model parameters
    for(j in 1:Nrep){
      print(c(i,j))
      delta <- DELTA[j]

      # Simulated Data
      D <- fun_disp(N = PARA[i,"N"], sec_len = PARA[i,"LEN"], delta = delta, phi = PARA[i,"PHI"])
      
      # Data for JAGS
      X <- D$X
      X0 <- D$X0
      Y <- 1 - is.na(D$X)
      L <- PARA[i,"LEN"]
      
      # Run JAGS
      Djags <- list( X = X, X0 = X0, Nsample = length(X) )
      para <- c("delta")
      inits <- replicate(3, list(log.delta = log(delta), .RNG.name = "base::Mersenne-Twister", .RNG.seed = NA ), simplify = F )
      for(k in 1:3) inits[[k]]$.RNG.seed <- k
      
      m <- read.jagsfile("BayesModel/model_simple_laplace_v1.R")
      
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
      
      # Output
      MCMCiter <- (post$sample/Sample)*n.iter + burn
      re <- summary(post)
      RE <- rbind(RE, c(PARA[i,],
                        delta, mean(is.na(X)==0), mean(is.na(D$x_stay)==0),
                        re["delta", 1:3],
                        re["delta", "psrf"],
                        MCMCiter, burn, n.thin, post$sample) )
      View(RE)
    }#j
    
    # Compile final output
    output <- rbind(output, RE)
  }#i
  
# Save results ----
  colnames(output) <- c("N", "LEN", "PHI",
                        "delta", "Pcap", "Pstay",
                        "delta_lower", "delta_med", "delta_upper",
                        "R_hat_delta",
                        "MCMCiter", "Burn_in", "N_thin", "N_sample")
  filename <- paste0("result/sim_model_simple", Sys.Date(), ".csv")
  write.csv(output, filename)