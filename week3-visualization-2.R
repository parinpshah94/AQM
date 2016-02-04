library(devtools)
install_github('ramnathv/rCharts')
library(rCharts)
library(RColorBrewer) 

# wrangle with your typical dplyr
dat <- gapminder %>%
  group_by(continent, year) %>%
  filter(continent != "Oceania") %>% # why do I remove Oceania?
  summarise(mean.lifeExp = mean(lifeExp)) %>%
  select(continent, mean.lifeExp, year)

# create the plot
c1 <- nPlot(mean.lifeExp ~ year, 
            group = "continent", 
            data = dat, 
            type = "stackedAreaChart")

# add the so called "aesthetics" or properties
c1$chart(color = brewer.pal(6, "Set2")) # colour from RColorBrewer library
c1$yAxis(tickFormat= "#!d3.format(',.1f')!#")
c1$yAxis(axisLabel = "Life Expectancy", width = 62)
c1$xAxis(axisLabel = "Year")
c1$chart(tooltipContent = "#! function(key, x, y){
        return '<h3>' + key + '</h3>' + 
        '<p>' + y + ' years ' + x + '</p>'
        } !#")