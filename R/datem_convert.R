#' datem_conv: convert date_ym and datem formats
#'
#' @param date: a monthly date either in yyyymm format or in monthly statar format
#' @param fulldate: boolean
#' @note Ueful to juggle with date types in monthly panel
#' @return A date
#' @examples
#'   datem_conv(199901)
#' @export
datem_conv <- function(
  date,
  fulldate = F
){

  if (date <= 10000 & fulldate == F){     # check if it is a date monthly a la Gomez

    res_date <- year(date)*100 + month(date)

  } else if (date <= 10000 & fulldate == T){

    res_date <- as.Date( ISOdate( year(date), month(date), 1) )

  } else if (date > 10000 & fulldate == F){  # check if date is of format yyyymm

    # res_date <- as.monthly( as.Date( ISOdate( floor(date/100), date%%100, 1) ) )
    res_date <- as.monthly( ISOdate( floor(date/100), date%%100, 1) )

  } else if (date > 10000 & fulldate == T){

    res_date <- as.Date( ISOdate( floor(date/100), date%%100, 1) )

  }

  return( res_date )

} # end of dateym_to_monthly function
