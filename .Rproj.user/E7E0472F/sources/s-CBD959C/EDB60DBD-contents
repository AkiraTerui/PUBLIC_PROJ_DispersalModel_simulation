
fun_disp <- function(N = 100, sec_len = 500, delta = 100, phi = 0.8){
  ## NOTE ##
  # N: number of individuals marked
  # sec_len: section length
  # resolution: length of subsection
  # delta: mean dispersal distance
  # phi: composite of undetection and mortality (probability)
  
  library(nimble)
  # Define center at down- and upstream end sections
  mu <- runif(N, 0, sec_len) # randomly assign capture sections to individuals
  
  # Define center at down- and upstream end sections
  x <- x_stay <- x_true <- rdexp(N, location = mu, scale = delta) # true locations after dispersal
  
  z <- rbinom(N, 1, phi) # phi is the product of survival/detectability
  
  x_stay[x_true < 0|x_true > sec_len] <- NA # insert NAs for those leaving the study stretch
  x[x_true < 0|x_true > sec_len|z == 0] <- NA # insert NAs for those leaving the study stretch AND/or dead/undetected
  
  return(list(x_stay = round(x_stay), X = round(x), X0 = round(mu), phi = phi) )
}  
