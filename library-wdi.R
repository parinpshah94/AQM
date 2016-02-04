library(WDI)
library(dplyr)
library(ggplot2)

co2 <- WDI(country="all", indicator = "EN.ATM.CO2E.PC") %>% na.omit()
colnames(co2) <- c("iso2c", "country", "CO2", "year")

mean.logco2 <- mean(log(co2$CO2))
sd.logco2 <- sd(log(co2$CO2))

ggplot(co2, geom = "density", aes(CO2)) + 
  geom_histogram(stat = "bin", binwidth=0.5, aes(y=..density..)) +
  geom_density(colour="red", size = 1) +
  stat_function(fun = dlnorm, colour = "blue", 
                args = list(mean.logco2, sd.logco2), size = 1) +
  #stat_function(fun = rlnorm, colour = "blue",
                #args = list(mean.logco2, sd.logco2), size=1) +
  xlim(c(0, 25)) + ylim(c(0,0.5)) +
  theme_bw()

#Red is the observed distribution and Blue is observed distribution