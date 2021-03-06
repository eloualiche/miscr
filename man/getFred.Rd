% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getFred.R
\name{getFred}
\alias{getFred}
\title{Download data from FRED, using quantmod or fredr}
\usage{
getFred(fred_series, date_ym = T, quantmod = T, fredr = F)
}
\arguments{
\item{fred_series:}{a string representing a series from FRED}

\item{date_ym:}{boolean, if TRUE creates a monthly date variable a la French}

\item{quantmod:}{if TRUE downloads FRED through the quantmod package}

\item{fredr:}{if TRUE downloads FRED through the fredr package}
}
\value{
dt: a data.table
}
\description{
Download data from FRED, using quantmod or fredr
}
\note{
The download method through quantmod (default) or fredr are mutually exlcusive.
  For now quantmod is more up to date given FRED move to secure download
}
\examples{
dt_gdp <- getFred("GDP", date_ym = TRUE, quantmod = TRUE)
}
