timbow <- function(n.colors = 6,
                   start.hue = "#FF0000",
                   hue.direction = c("increasing", "decreasing"),
                   colorfulness = 100,
                   luminosity.limits = c(15, 85),
                   n.cycles = 5/6,
                   palette = "custom",
                   show.plot = FALSE,
                   colormap = FALSE) {

  require(RcppColors)
  
  palette.ls <- c("plasma", "hot", "cold", "cubehel-esque", "virid-esque")
  if (palette %in% palette.ls) {
    if (palette == "plasma") {
      start.hue="#0000FF"
      hue.direction = "increasing"
      n.cycles = 1/2
    }    
    if (palette == "virid-esque") {
      start.hue="#0000FF"
      hue.direction = "decreasing"
      n.cycles = 1/2
    }
    if (palette == "hot") {
      start.hue=0
      n.cycles=1/6
      hue.direction = "increasing"
    }
    if (palette == "cold") {
      start.hue="#0000FF"
      n.cycles=1/6
      hue.direction = "decreasing"
    }
    if (palette == "cubehel-esque") {
      if (n.colors < 12) { n.colors=12 }
      start.hue="#0000FF"
      n.cycles=11/6
      luminosity.limits = c(15,100)
    }
  }
  
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

  if (colormap) {
    require(ggplot2)
    pf <- data.frame(x=1, y=seq(1,n.colors+1,1), values=seq(1,n.colors+1,1))
    ggplot(pf, aes(x=x, y=y, fill=values)) +
      theme_void() + 
      scale_fill_gradientn(colors=c("#000000", color.ls)) +
      geom_raster() +
      theme(legend.position="None", plot.margin = margin(t=0, r=0, b=0, l=0))
  }
  return(color.ls)
}
