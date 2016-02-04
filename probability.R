set.seed(123)
sequenceOfCoinTosses <- sample(c(0,1),1000,replace=TRUE)
plot(cumsum(sequenceOfCoinTosses)/
       seq_along(sequenceOfCoinTosses), type = 'l')
hist(sequenceOfCoinTosses/seq_along(sequenceOfCoinTosses),
     breaks = 1000, xlim=c(-0.01,0.01), main="Cum Meanof tosses")

gauss_sample <- rnorm(10000000, mean=0, sd=1)
hist(gauss_sample, probability = TRUE)