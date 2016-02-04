library(dplyr)

#Reading in the data

setwd("~/Google Drive/AQM/Assignments/1")
data <- read.csv("Investment.csv")

#Looking at the market categorization of the highest investment each year

detailInv <- select(data, company_name, company_market, investor_name, funded_year, raised_amount_usd)
detailInv <- mutate(detailInv, amount = as.numeric(gsub(",", "", raised_amount_usd)))
detailInv <- arrange(detailInv, desc(funded_year), desc(amount))

detailInv2 <- aggregate(amount ~ funded_year, detailInv, max)
detailInv3 <- merge(detailInv2, detailInv)
detailInv3$amount <- as.numeric(gsub(",", "", detailInv3$raised_amount_usd))
detailInv3$raised_amount_usd <- NULL
detailInv3$log_amount <- log(detailInv3$amount)

library(ggplot2)
qplot(funded_year, log_amount, data=detailInv3, geom=c("point","smooth"))
qplot(funded_year, log_amount, data=detailInv3, geom=c("point","smooth"), colour=company_market, size=log_amount)
