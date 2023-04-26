timbow <- function(start.color = "#FF0000",
                   hue.direction = c("increasing", "decreasing"),
                   colorfulness = 100,
                   luminosity.limits = c(15, 85),
                   n.colors = 6, 
                   n.cycles = 5/6,
                   plot.continuous = TRUE,
                   plot.discrete = TRUE) {

  require(RcppColors)
  
  # calculate HUE
  start.hue <- round(rgb2hsv(col2rgb(start.color))*360)
  hue <- switch(hue.direction[1],
    `increasing` = (seq(0,360*n.cycles, length.out=n.colors) + start.hue[1]) %% 360,
    `decreasing` = (seq(0,-360*n.cycles, length.out=n.colors) + start.hue[1]) %% 360)
  
  # calculate saturation
  if (length(colorfulness) == 1) {
    saturation <- rep(colorfulness, n.colors)
  } else {
    saturation <- colorfulness
  }
  
  # calculate luminosity gradient
  if (length(luminosity.limits) == 1) {
    luminosity <- rep(luminosity.limits, n.colors)
  } else {
    luminosity <- seq(luminosity.limits[1], luminosity.limits[2], length.out=n.colors)
  }
  
  # generate HEX colors
  color.ls <- character(n.colors)
  for (i in 1:n.colors) {
    color.ls[i] <- RcppColors::hsluv(h=hue[i], s=saturation[i], l=luminosity[i])
  }
  
  if (plot.discrete) {
    require(ggplot2)
    pf <- data.frame(x=1:n.colors, y=1, values=1:n.colors)
    print(ggplot(pf, aes(x=x, y=y, fill=values)) +
      theme_void() +
      coord_equal() +
      scale_fill_gradientn(colors=color.ls) +
      geom_raster() +
      theme(legend.position="None"))
  }
  if (plot.continuous) {
    require(ggplot2)
    cpal <- colorRampPalette(color.ls)(200)
    pf <- data.frame(x=1:200, y=1, values=1:200)
    print(ggplot(pf, aes(x=x, y=y, fill=values)) +
      theme_void() +
      coord_equal(ratio=20) +
      scale_fill_gradientn(colors=color.ls) +
      geom_raster() +
      theme(legend.position="None"))
  }
  
  return(color.ls)
}
