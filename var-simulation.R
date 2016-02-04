#Add a combination of tech and  commodity stocks

library(quantmod) # to load stock data
library(MASS) # for a multivariate random normal generator
library(reshape2) # to melt dframes into long form
library(ggplot2)
library(GGally) # some nice plots not available in ggplot
library(dplyr)

tickers <- c("AAPL", "F", "YHOO", "XOM", "CVX", "MSFT")
quantmod::getSymbols(tickers, from = "2013-01-01")

stockPrices <- lapply(tickers, function(x) eval(parse(text=x))[,6]) %>%
  as.data.frame() %>% setNames(tickers)

# plot stock prices
plot.stocks <- stockPrices %>%
  melt(variable.name="tickers", value.name="close.price") %>%
  data.frame(index = rep(1:nrow(stockPrices), length(tickers))) %>%
  ggplot(aes(x=index, y=close.price, colour = tickers, group=tickers)) +
  geom_line() +
  facet_wrap(~tickers, scale="free") +
  theme_bw()
print(plot.stocks)

# compute matrix of returns
returnsMatrix <- stockPrices %>%
  apply(2, function(x) diff(log(x)))

# plot differenced returns
data.frame(index = 1:nrow(returnsMatrix), returnsMatrix) %>% 
  melt(id.vars = "index", variable.name = "ticker", value.name = "return") %>%
  ggplot(aes(x=index, y=return, colour=ticker, group=ticker)) +
  geom_line() + facet_wrap(~ticker) + theme_bw()