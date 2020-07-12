model{
  # Priors
  tau ~ dscaled.gamma(1000, 1)
  sigma <- sqrt(1/tau)
  
  # Likelihood
  for(i in 1:Nsample){
    X[i] ~ dnorm(X0[i], tau)T(0,L)
  }
}
