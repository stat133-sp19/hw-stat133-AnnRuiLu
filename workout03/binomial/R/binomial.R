# private function to check if an input prob is a valid probability value
check_prob <- function(prob){
  if (prob >= 0 & prob <=1){
    return (TRUE)
  }else{
  stop('invalid prob value')
  }
}

# private function to check if an input trials is a valid value for number of trials
check_trials <- function(trials){
  if (trials == floor(trials) & trials >= 0){
    return (TRUE)
  }else{
    stop('invalid trials value')
  }
}

# private function to check if an input success is a valid value for number of successes
check_success <- function(success, trials){
  for (suc in success){
    if ((check_trials(suc) & suc <= trials) != TRUE){
      stop('invalid success value')
    }
  }
  return (TRUE)
}

# private function to calculate the mean
aux_mean <- function(trials, prob){
  return (trials * prob)
}

# private function to calculate the variance
aux_variance <- function(trials, prob){
  return (trials * prob * (1-prob))
}

# private function to calculate the mode
aux_mode <- function(trials, prob){
  m <- trials * prob + prob
  if (m == floor(m)){
    return (c(m, (m - 1)))
  }else{
    return(floor(m))
  }
}

# private function to calculate the skewness
aux_skewness <- function(trials, prob){
  return((1 - 2 * prob) / sqrt(trials * prob * (1 - prob)))
}

# private function to calculate the kurtosis
aux_kurtosis <- function(trials, prob){
  return((1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob)))
}

#' @title Binomial Choose
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials
#' @param k number of success
#' @return number of combinations in which k successes can occur in n trials
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)
bin_choose <- function(n, k){
  temp <- c()
   for (i in 1:length(k)){
    if (max(k) > n){
       stop("k cannot be greater than n")
      }else{
   temp[i] = (factorial(n)/(factorial(k[i]) * factorial(n - k[i])))
   }
  }
  return(temp)
}

#' @title Binomial Probability
#' @description calculate probabilities about the number of successes in a fixed number of random trials performed under identical conditions
#' @param success number of success
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return probabilities about the number of successes in a fixed number of random trials performed under identical conditions
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)
bin_probability <- function(success, trials, prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  temp1 <- c()
  for (i in 1:length(success)){
    temp1[i] = bin_choose(trials, success[i]) *(prob^success[i]) * ((1 - prob)^(trials - success[i]))
  }
  return(temp1)
}

#' @title Binomial Distribution
#' @description create a data frame with the probability distribution: sucesses in the first column, probability in the second column
#' @param success number of success
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return a data frame with the probability distribution: sucesses in the first column, probability in the second column
#' @example bin_distribution(trials = 5, prob = 0.5)
bin_distribution <- function(trials, prob){
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  df <- data.frame(success, probability)
  class(df) <- c("bindis", "data.frame")
  return(df)
}

#' @export
#' @example
#' dis1 <- bin_distribution(trials = 5, prob = 0.5)
#' plot(dis1)
library(ggplot2)
plot.bindis <- function(bin) {
  ggplot(data=bin, aes(x=success, y=probability)) +
    xlab("successes") +
    geom_col(fill="gray") +
    theme_classic() +
    scale_x_continuous(breaks=seq(0, nrow(bin), 1))
}

#' @title Binomial Cumulative Function
#' @description create a data frame with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return a data frame with both the probability distribution and the cumulative probabilities: sucesses in the first column, probability in the second column, and cumulative in the third column
#' @example bin_cumulative(trials = 5, prob = 0.5)
bin_cumulative <- function(trials, prob){
  df <- bin_distribution(trials, prob)
  cum <- c()
  for (i in 1:(trials+1)){
    cum[i] = sum(df$probability[1:i])
  }
    df$cumulative <- cum
    class(df) <- c("bincum", "data.frame")
    return(df)
}

#' @export
#' @example
#' dis2 <- bin_cumulative(trials = 5, prob = 0.5)
#' plot(dis2)
plot.bincum <- function(bincum){
  ggplot(data=bincum, aes(x=success, y=cumulative)) +
    geom_point()+
    geom_line()+
    xlab("successes") +
    ylab("probability")+
    theme_classic() +
    scale_x_continuous(breaks=seq(0, nrow(bincum), 1))
}

#' @title Binomial Variable Function
#' @description create a binomial random variable object
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return a binomial random variable object
bin_variable <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  variable <- list(trials = trials, prob = prob)
  class(variable) <- "binvar"
  return(variable)
}

#' @export
print.binvar <- function(variable){
  cat('"Binomial variable"\n\n')
  cat('Parameters')
  cat(paste0('- number of trials: ', variable[1], '\n'))
  cat(paste0('- prob of success : ', variable[2], '\n'))
}

#' @export
summary.binvar <- function(binvar){
  variable <- list(trials = binvar$trials,
                  prob = binvar$prob,
                  mean = aux_mean(binvar$trials, binvar$prob),
                  variance = aux_variance(binvar$trials, binvar$prob),
                  mode = aux_mode(binvar$trials, binvar$prob),
                  skewness = aux_skewness(binvar$trials, binvar$prob),
                  kurtosis = aux_kurtosis(binvar$trials, binvar$prob))
  class(variable) <- "summary.binvar"
  return(variable)
}

#' @export
print.summary.binvar <- function(variable){
  cat('"Summary Binomial"\n\n')
  cat(paste0('Paramaters', '\n'))
  cat(paste0('- number of trials: ', variable[1], '\n'))
  cat(paste0('- prob of success : ', variable[2], '\n', '\n'))
  cat(paste0('Measures', '\n'))
  cat(paste0('- mean    :'), variable$mean, '\n')
  cat(paste0('- variance:'), variable$variance, '\n')
  cat(paste0('- mode    :'), variable$mode, '\n')
  cat(paste0('- skewness:'), variable$skewness, '\n')
  cat(paste0('- kurtosis:'), variable$kurtosis, '\n')
}

#' @title Binomial Mean
#' @description calculate the mean of binomial distribution
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return mean of binomial distribution
#' @example bin_mean(10, 0.3)
bin_mean <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}

#' @title Binomial Variance
#' @description calculate the variance of binomial distribution
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return variance of binomial distribution
#' @example bin_variance(10, 0.3)
bin_variance <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}

#' @title Binomial Mode
#' @description calculate the mode of binomial distribution
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return mode of binomial distribution
#' @example bin_mode(10, 0.3)
bin_mode <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}

#' @title Binomial Skewness
#' @description calculate the skewness of binomial distribution
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return skewness of binomial distribution
#' @example bin_skewness(10, 0.3)
bin_skewness <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}

#' @title Binomial Kurtosis
#' @description calculate the kurtosis of binomial distribution
#' @param trials number of trials
#' @param prob probability of achieving success
#' @return kurtosis of binomial distribution
#' @example bin_kurtosis(10, 0.3)
bin_kurtosis <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}
