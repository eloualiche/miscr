#' A package for miscellaneous stuff in R
#'
#' @docType package
#' @name miscr
#'
#' @import ggplot2
#'
#' @importFrom dplyr "%>%"
#'
#' @importFrom data.table is.data.table
#' @importFrom data.table data.table
#' @importFrom data.table key
#' @importFrom data.table setnames
#' @importFrom data.table setattr
#' @importFrom data.table setkeyv
#' @importFrom data.table setDF
#' @importFrom data.table setDT
#' @importFrom data.table setnames
#' @importFrom data.table dcast.data.table
#' @importFrom data.table :=
#'
#' @importFrom lazyeval as.lazy
#' @importFrom lazyeval lazy_dots
#' @importFrom lazyeval lazy_eval
#' @importFrom lazyeval all_dots
#' @importFrom lazyeval common_env
#' @importFrom lazyeval interp
#' @importFrom lazyeval lazy
#'
#' @importFrom lubridate year
#' @importFrom lubridate month
#'
#' @importFrom matrixStats weightedMean
#' @importFrom matrixStats colWeightedMeans
#' @importFrom matrixStats colRanges
#'
#' @importFrom methods is
#'
#' @importFrom parallel mclapply
#'
#' @importFrom quantmod getSymbols
#'
#' @importFrom stargazer stargazer
#'
#' @importFrom statar as.monthly
#'
#' @importFrom sendmailR sendmail_options
#' @importFrom sendmailR sendmail
#' @importFrom sendmailR mime_part
#'
#' @importFrom stringr str_replace
#' @importFrom stringr str_match
#' @importFrom stringr str_detect
#' @importFrom stringr str_split
#' @importFrom stringr fixed
#'
#' @importFrom stats as.formula
#' @importFrom stats complete.cases
#' @importFrom stats na.omit
#' @importFrom stats quantile
#' @importFrom stats sd
#' @importFrom stats setNames
#'
#'@importFrom R.utils System
#'
#' @importFrom tidyr gather_
#' @importFrom tidyr spread
#' @importFrom tidyr spread_
#'
#' @importFrom utils head
#' @importFrom utils tail
#' @importFrom utils type.convert
#'
#' @importFrom zoo index
#' @importFrom zoo coredata
#'
NULL

globalVariables(".SD")
globalVariables("Statbinmean")

