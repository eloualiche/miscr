#' Mostly Black and White theme
#'
#' @param base_size: position
#' @note print the current environment. package is meant to be used or database.
#'   Uses pretty print to get an idea of how crowded is the memory on the system.
#' @return A theme for ggplot2
#' @examples p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
#' p + gg_bw()
#' @export
gg_bw <- function(base_size = 10
){

  res <- theme_bw()

    res <- res +
    theme(
      strip.background  = element_rect(colour = NA, fill = NA, size = 3) ,
      plot.background   = element_rect(fill = NA),
      panel.border      = element_blank(),
      panel.background  = element_blank(),

      axis.line         = element_blank(),
      axis.text         = element_text(colour = "grey",size=8),
      axis.ticks        = element_line(size = 0.05, colour="grey"),

      axis.title.y      = element_text(size = base_size),
      axis.text.y       = element_text(angle=0),
      axis.title.y      = element_text(angle=90, size = base_size),

      axis.text.x       = element_text(angle=0),
      axis.title.x      = element_text(size = base_size),

      plot.title        = element_text(size = base_size+2, face="bold"),
      strip.text.x      = element_text(size = base_size, colour="grey",face="bold"),
      legend.background = element_rect(), legend.justification=c(0,0), legend.position = "right", legend.key = element_blank()
    )

    return(res)

} # end of gg_bw()
