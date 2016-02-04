library(gapminder)

dat <- gapminder %>%
  group_by(continent, year) %>%
  filter(continent != "Oceania") %>% # why do I remove Oceania?
  select(continent, year, gdpPercap, lifeExp)


require(rCharts)
d1 <- dPlot(
  SalesValue~Price,
  groups = c("SKU", "Channel", "Owner"),
  data = subset(data, Date == "01/12/2012"),
  type = "bubble",
  height = 380,
  width = 590,
  bounds = list(x=60, y=30, width=420, height=310),
  xlab = "I am a changed x", #example of a custom x label
  ylab = "I am a changed y"
)
d1$xAxis( type = "addMeasureAxis" )
d1$yAxis( type = "addMeasureAxis" )
d1$legend(
  x = 530,
  y = 100,
  width = 60,
  height = 300,
  horizontalAlign = "right"
)
d1$setTemplate(
  afterScript = 
    '<script>
  myChart.axes.filter(function(ax){return ax.position == "x"})[0].titleShape.text(opts.xlab)
  myChart.axes.filter(function(ax){return ax.position == "y"})[0].titleShape.text(opts.ylab)
  // This is a critical step.  By doing this we orphan the legend. This
  // means it will not respond to graph updates.  Without this the legend
  // will redraw when the chart refreshes removing the unchecked item and
  // also dropping the events we define below.
  myChart.legends = [];
  // This block simply adds the legend title. I put it into a d3 data
  // object to split it onto 2 lines.  This technique works with any
  // number of lines, it isn\'t dimple specific.
  svg.selectAll("title_text")
  .data(["Click legend to","show/hide owners:"])
  .enter()
  .append("text")
  .attr("x", 499)
  .attr("y", function (d, i) { return 90 + i * 14; })
  .style("font-family", "sans-serif")
  .style("font-size", "10px")
  .style("color", "Black")
  .text(function (d) { return d; });
  // Get a unique list of Owner values to use when filtering
  var filterValues = dimple.getUniqueValues(data, "Owner");
  // Get all the rectangles from our now orphaned legend
  l.shapes.selectAll("rect")
  // Add a click event to each rectangle
  .on("click", function (e) {
  // This indicates whether the item is already visible or not
  var hide = false;
  var newFilters = [];
  // If the filters contain the clicked shape hide it
  filterValues.forEach(function (f) {
  if (f === e.aggField.slice(-1)[0]) {
  hide = true;
  } else {
  newFilters.push(f);
  }
  });
  // Hide the shape or show it
  if (hide) {
  d3.select(this).style("opacity", 0.2);
  } else {
  newFilters.push(e.aggField.slice(-1)[0]);
  d3.select(this).style("opacity", 0.8);
  }
  // Update the filters
  filterValues = newFilters;
  // Filter the data
  myChart.data = dimple.filterData(data, "Owner", filterValues);
  // Passing a duration parameter makes the chart animate. Without
  // it there is no transition
  myChart.draw(800);
  myChart.axes.filter(function(ax){return ax.position == "x"})[0].titleShape.text(opts.xlab)
  myChart.axes.filter(function(ax){return ax.position == "y"})[0].titleShape.text(opts.ylab)
  });
  </script>'
)
d1