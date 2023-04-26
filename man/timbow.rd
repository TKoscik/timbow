\name{timbow}
\alias{timbow}
\title{
  HEX Color Rainbows with Perceptual Luminosity Gradients
}
\description{
  It's in the title, baby!
}
\usage{
timbow(n.colors = 6, 
       start.hue = "#FF0000",
       hue.direction = c("increasing", "decreasing"),
       colorfulness = 100,
       luminosity.limits = c(15, 85),
       n.cycles = 5/6,
       plot.continuous = TRUE,
       plot.discrete = TRUE)
}
\arguments{
  \item{start.hue}{HEX color to initialize rainbow}
  \item{hue.direction}{increasing or decreasing (akin to direction of change in wavelength, wraps at edges) }
  \item{colorfulness}{ 0-100, or vector of length n.colors indicating the colorfulness (like saturation)}
  \item{luminosity.limits}{a value or lower and upper bounds in a vector specifiying the luminosity range}
  \item{n.colors}{number of colors to output, 6 per rainbow cycle is recommended, or things might get weird} 
  \item{n.cycles}{number of times to cycle through the rainbow, default is 0.8333, which goes through all of the colors without cycling back to the beginning. Set to 0 for a single color gradient}
  \item{palette}{select from predefined color scales, including, "plasma", "virid-esque", "hot", "cold", and "cubehel-esque"}
  \item{show.plot}{show a plot of a continuous gradient and discrete colors, requires ggplot2}
}
\details{}
\value{A vector of HEX colors}
\author{
Timothy R. Koscik <timkoscik@gmail.com>
}
\examples{
\dontrun{
color.ls <- timbow()
}
}
