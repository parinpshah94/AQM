library(quantmod)
library(MASS)
getSymbols("YHOO")
getSymbols("^GSPC")

'get the adjusted close prices of each index'
yahoo.closepriceadj <- as.vector(YHOO$YHOO.Adjusted)
snp.closepriceadj <- as.vector(GSPC$GSPC.Adjusted)

'get the return of the close prices of each (1st difference)'
yahooreturns.vector <- diff(yahoo.closepriceadj)
snpreturns.vector <-diff(snp.closepriceadj)


'a date sequence of each return'
dates.vector <- sequence(length(snpreturns.vector)) 

'construct design matrix'
X = matrix( c(t(rep(1, length(snpreturns.vector))) , t(snpreturns.vector)), 
            + length(snpreturns.vector),
            + 2, 
            + FALSE)

a = solve(t(X)%*%X)%*%t(X)%*%yahooreturns.vector
df <- data.frame(snp = snpreturns.vector, yahoo = yahooreturns.vector)

'plot yahoo returns vs. snp returns and linear regression model'
plot(snpreturns.vector, yahooreturns.vector,col="red")
abline(a[1:2])
hist(snpreturns.vector)
hist(yahooreturns.vector)


'use built in LM function'
lmfit <- lm(yahooreturns.vector ~ snpreturns.vector)
summary(lmfit)
abline(lmfit, col = 'blue')

plot(lmfit)

'use robust LM'
lmfit <- rlm(yahooreturns.vector ~ snpreturns.vector)
summary(lmfit)
abline(lmfit, col = 'green')

' useful diagnostic functions http://www.statmethods.net/stats/regression.html'

'now lets take a look at the world 3 dataset'
w3 <- read.csv('world3_subset.csv')
head(w3)

explanatory <- w3;
explanatory$X <- NULL;
explanatory$HDI <- NULL;

'build multivariable linear model'
lmfit2 = lm(w3$HDI ~., explanatory)
summary((lmfit2))
plot(lmfit2)

'Question: how many regression coefficients are significant? Can we remove nonsignificant
variables from the model? Could this affect the significance of other coefficients?'
