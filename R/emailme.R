#' Email Me
#'
#' @param out: R output
#' @param who: who is sending / receiving
#' @param outgoing_server: specify smtp
#' @note print the current environment. package is meant to be used or database.
#'   Uses pretty print to get an idea of how crowded is the memory on the system.
#' @return NULL
#' @examples nothing for now
#' @export
emailme <- function(out = NULL,
                    who = "erikl@mit.edu",
                    outgoing_server = "outgoing.mit.edu"
){

  if ( is.null(out) ){
    out <- .Last.value
  }

  if ( sum(grep("gg", class(out))) > 0 ){
    out <- list( mime_part(out, "plot") )
  } else {
      out <- capture.output(print(out))
  }

  message( paste0("Outgoing server set to: ", outgoing_server) )
  sendmail_options(smtpServer=outgoing_server)

  subject <- paste0("R output from ", tolower(System$getHostname()),
                    " on ", format(Sys.time(), "%A %B %d"), " at ",  format(Sys.time(), "%X") )
  sendmail(who, who, subject, out)

  return()

} # end of emailme()

