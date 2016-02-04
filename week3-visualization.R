library(dplyr)
library(ggplot2)
library(gapminder)
library(gridExtra)

gapminder = gapminder

# wrangle that data with dplyr and group
# settings will extend to the plot!
gdp.delta.new <- gapminder %>% 
  select(year, continent, country, gdpPercap) %>%
  mutate(change = 100*((gdpPercap - lag(gdpPercap)))/gdpPercap)  %>% 
  filter(year > 1952)  %>% 
  group_by(continent, year) %>%
  summarise(mean.growth = mean(change))

# construct the plot frame
plot.frame <- ggplot(gdp.delta.new, aes(x = year, y = mean.growth))

# add a point layer
plot2 <- plot.frame + geom_line(aes(colour = continent))

# add axis labels and a title
plot3 <- plot2 + 
  ggtitle("Mean growth of GDP per Capita by Continent \n ~ 1992 - 2007 ~") +
  xlab("Year") + ylab("Mean growth")

plot4 <- plot3 + theme_bw()

# print the plot
print(plot4)

########################################################################

gDat <- gapminder %>%
  select(continent, year, lifeExp) %>%
  filter(year == 2007) %>%
  filter(continent != "Oceania") %>% # what am I doing here? Why?
  group_by(lifeExp) # Why group by population?

p1 <- ggplot(gDat, aes(log(lifeExp), fill = continent)) + 
  geom_density(alpha = 0.7) + # what does alpha do?
  facet_wrap(~continent) + 
  ggtitle("Distribution of LifeExpectency by Continent in 2007")
print(p1)

# Challenge #2: Analyse the life expectancy over the years of 1952 to 2007 according to each continent. Do you notice any patterns or interesting behaviour?

hDat <- gapminder %>%
  select(continent, year, lifeExp) %>%
  filter(year %in% seq(1992, 2007, 5)) %>% # what does %in% do?
  filter(continent != "Oceania") %>% # why do I use "!="?
  group_by(lifeExp)

p2 <- ggplot(hDat, aes(year, lifeExp, colour = continent)) + 
  geom_jitter() + # what does jitter do? Check it out!
  ggtitle("Life expectancy of each Continent from 1990 to 2005") +
  stat_smooth(method="lm",se=FALSE)
print(p2)

# Challenge #3: Extract data pertaining to Rwanda and examine the time-series of life expectancy, population and GDP per Capita. Do you notice any dramatic behaviour? If so, how do the three time-series interralate? Are they correlated in any way? Why or why not?

jDat <- gapminder %>%
  filter(country == "Rwanda") %>%
  mutate(change.pop = 100*((pop - lag(pop)))/pop) %>%
  mutate(change.lifeExp = 100*((lifeExp - lag(lifeExp)))/lifeExp) %>%
  mutate(change.gdpPercap = 100*((gdpPercap - lag(gdpPercap)))/gdpPercap) %>%
  select(country, year, change.pop, change.lifeExp, change.gdpPercap) %>%
  filter(year > 1952) %>%
  group_by(year)

p3 <- ggplot(jDat, aes(y = change.pop, x = year)) + 
  geom_line(colour = "magenta") +
  ggtitle("Population Growth of Rwanda \n ~ 1957 - 2007 ~") +
  ylab("Population Differential")
p4 <- ggplot(jDat, aes(y = change.lifeExp, x = year)) +
  geom_line(colour = "blue") +
  ggtitle("Life Expectancy Differential of Rwanda \n ~ 1957 - 2007 ~") +
  ylab("Life Expectancy Differential")
p5 <- ggplot(jDat, aes(y = change.gdpPercap, x = year)) +
  geom_line(colour = "orange") +
  ggtitle("GDP per Capita Growth Rate of Rwanda \n ~ 1957 - 2007 ~") +
  ylab("GDP Differential")

# Use the gridExtra package
grid.arrange(p4, arrangeGrob(p3, p5, ncol=2), ncol=1) # what does this do?
