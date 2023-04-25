\name{timbow}
\alias{timbow}
\title{
  HEX Color Rainbows with Perceptual Luminosity Gradients
}
\description{
  It's in the title, baby!
}
\usage{
timbow(start.color = "#FF0000",
       hue.direction = c("increasing", "decreasing"),
       colorfulness = 100,
       luminosity.limits = c(15, 85),
       n.colors = 6, 
       n.cycles = 5/6,
       plot.continuous = TRUE,
       plot.discrete = TRUE)
\arguments{
  \item{start.color}{HEX color to initialize rainbow}
  \item{hue.direction}{increasing or decreasing (akin to direction of change in wavelength, wraps at edges) }
  \item{colorfulness}{ 0-100, or vector of length n.colors indicating the colorfulness (like saturation)}
  \item{luminosity.limits}{a value or lower and upper bounds in a vector specifiying the luminosity range}
  \item{n.colors}{number of colors to output, 6 per rainbow cycle is recommended, or things might get weird} 
  \item{n.cycles}{number of times to cycle through the rainbow, default is 0.8333, which goes through all of the colors without cycling back to the beginning}
  \item{plot.continuous}{show plot of continuous colors, requires ggplot2}
  \item{plot.discrete}{show a plot of a continuous color gradient, requires ggplot2}
}
