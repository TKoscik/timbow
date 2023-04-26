timbow <- function(n.colors = 6,
                   start.hue = "#FF0000",
                   hue.direction = c("increasing", "decreasing"),
                   colorfulness = 100,
                   luminosity.limits = c(15, 85),
                   n.cycles = 5/6,
                   show.plot = TRUE) {

  require(RcppColors)
  
  # calculate HUE ------------------------------------------------------------------
  if (is.numeric(start.hue)) {
    start.hue <- start.hue %% 360
  } else {
    start.hue <- round(rgb2hsv(col2rgb(start.hue))*360)
  }
  hue <- switch(hue.direction[1],
    `increasing` = (seq(0,360*n.cycles, length.out=n.colors) + start.hue[1]) %% 360,
    `decreasing` = (seq(0,-360*n.cycles, length.out=n.colors) + start.hue[1]) %% 360)
  
  # calculate saturation -----------------------------------------------------------
  if (length(colorfulness) == 1) {
    saturation <- rep(colorfulness, n.colors)
  } else {
    saturation <- colorfulness
  }
  
  # calculate luminosity gradient -------------------------------------------------
  if (length(luminosity.limits) == 1) {
    luminosity <- rep(luminosity.limits, n.colors)
  } else {
    luminosity <- seq(luminosity.limits[1], luminosity.limits[2], length.out=n.colors)
  }
  
  # generate HEX colors -----------------------------------------------------------
  color.ls <- character(n.colors)
  for (i in 1:n.colors) {
    color.ls[i] <- RcppColors::hsluv(h=hue[i], s=saturation[i], l=luminosity[i])
  }
  
  ##why is the commit not working, this line should be here
  if (show.plot) {
    require(ggplot2)
    pf <- data.frame(
      x=rep(seq(1,n.colors, length.out=200),2),
      y=rep(1,200*2),
      values=c(ceiling(seq(1/200,n.colors, length.out=200)),
               seq(1,n.colors, length.out=200)),
      type=c(rep("Discrete",200),rep("Continuous",200)))
    print(ggplot(pf, aes(x=x, y=y, fill=values)) +
      theme_void() +
      scale_fill_gradientn(colors=color.ls) +
      facet_grid(type ~., scales = "free") +
      geom_raster() +
      theme(legend.position="None"))
  }
  return(color.ls)
}
