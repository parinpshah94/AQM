library(gapminder)
library(plyr)
library(dplyr)


data <- read.csv("gapminder.tsv", sep="\t")

gapminder <- gapminder

#head(gapminder)
#dim(gapminder)

x <- tapply(gapminder$lifeExp, gapminder$continent, FUN = mean)
y <- ddply(gapminder,~continent,summarise,mean=mean(lifeExp))

canada<- filter(gapminder, country=="Canada" & lifeExp > 68)

a <- select(gapminder, lifeExp, continent)

groupedMean <- summarise(group_by(gapminder, continent), mean(lifeExp))

df<- filter(gapminder, continent=="Oceania")
num_countries <- length(unique(df$country))

gap <- gapminder %>%
  select(country, gdpPercap, year) %>%
  group_by(country) %>%
  mutate(change=((gdpPercap-lag(gdpPercap))/gdpPercap)*100)

gap[which.max(gap$change),]
