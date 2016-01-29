#' List objects loaded in current environment
#'
#' @param pos: position
#' @param order.by: ordering
#' @param pattern: which objects to print
#' @param decreasing: order of print
#' @param head: how to print it
#' @param n: number of objects to print
#' @param database: only print database objects (data.table and data.frame)
#' @note print the current environment. package is meant to be used or database.
#'   Uses pretty print to get an idea of how crowded is the memory on the system.
#' @return A string.
#' @examples
#' ls_objects()
#' @export
ls_objects <- function (pos = 1,
                        order.by="Size",
                        pattern="",
                        decreasing=TRUE,
                        head=FALSE,
                        n=5,
                        database = TRUE
){

  napply <- function(names, fn) sapply(names, function(x)
    fn(get(x, pos = pos)))

  oneKB <- 1024
  oneMB <- 1048576
  oneGB <- 1073741824

  if ( missing(pattern)) {
    names <- ls(pos = pos)
  } else {
    names <- ls(pos = pos, pattern = pattern)
  }
  memoryUse <- sapply(names, function(x) as.numeric(object.size(eval(parse(text=x)))))
  memListing <- sapply(memoryUse, function(size) {
    if (size >= oneGB) return(paste(round(size/oneGB,2), "GB"))
    else if (size >= oneMB) return(paste(round(size/oneMB,2), "MB"))
    else if (size >= oneKB) return(paste(round(size/oneKB,2), "kB"))
    else return(paste(size, "bytes"))
  })

  obj.class <- napply(names, function(x) as.character(class(x))[1])
  obj.mode <- napply(names, mode)
  obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
  obj.size <- napply(names, object.size)
  obj.prettysize <- sapply(obj.size, function(r) prettyNum(r, big.mark = ",") )
  obj.dim <- t(napply(names, function(x)
    as.numeric(dim(x))[1:2]))

  if ( length(is.na(obj.dim)) > 0 ){
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
  } else {
    warning("No data of type selected in memory.")
    return(NULL)
  }

  if ( database){
    out <- data.frame(obj.type, obj.size, memListing, obj.dim) %>%
      subset(.,obj.type == "data.table" | obj.type == "data.frame" |
               obj.type == "grouped_dt" | obj.type == "tbl_dt" | obj.type == "tbl_df") %>%
      data.frame

  } else {
    out <- data.frame(obj.type, obj.size, memListing, obj.dim)

  }

  names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
  ## if (!missing(order.by))
  out <- out[order(out[[order.by]], decreasing=decreasing), ]
  out <- out[c("Type", "PrettySize", "Rows", "Columns")]
  names(out) <- c("Type", "Size", "Rows", "Columns")

  if (head)
    out <- head(out, n)

  # print(out)

  return(out)
}



