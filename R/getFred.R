

#' Download data from FRED, using quantmod or fredr
#'
#' @param fred_series: a string representing a series from FRED
#' @param date_ym: boolean, if TRUE creates a monthly date variable a la French
#' @param quantmod: if TRUE downloads FRED through the quantmod package
#' @param fredr: if TRUE downloads FRED through the fredr package
#' @note The download method through quantmod (default) or fredr are mutually exlcusive.
#'   For now quantmod is more up to date given FRED move to secure download
#' @return dt: a data.table
#' @examples
#' dt_gdp <- getFred("GDP", T)
#' @export
getFred <- function(fred_series,
                    date_ym = T,
                    quantmod = T,
                    fredr    = F){

  if ((quantmod == T) & (fredr == T)){
    error("Pick a single download API method")
  }

  if (quantmod == T){
    data <- new.env()
    getSymbols(fred_series, src = "FRED",
               env = data, adjust = TRUE )

    dt <- eval(substitute( data$x, list(x=as.name( fred_series ) ) ))
    dt <- data.table::data.table( date = zoo::index(dt), x = zoo::coredata(dt) )
    data.table::setnames(dt, c("date", fred_series ) )

    if (date_ym == T){
      dt$date_ym <- as.integer(year(dt$date) * 100 + month(dt$date))
    }

    rm(data)

    return(dt)
  }

  if (fredr == T){


  }

} # END of fred_download


