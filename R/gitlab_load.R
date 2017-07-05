#' Load from gitlab
#'
#' @param package: gitlab package
#' @param repo: gitlab package address
#' @param package_dir: dir of where to load the gitlab R package
#' @note print the current environment. package is meant to be used or database.
#'   Uses pretty print to get an idea of how crowded is the memory on the system.
#' @return NULL
#' @export
gitlab_load <- function(
  package     = "wrdsr",
  repo        = "gitlab.com",
  username    = "Loualiche",
  package_dir = "~/.R/tmp_dir/"
){

  ## tmp_dir = "/Users/loulou/Dropbox/other_projects/data_packages"
  orig_dir <- getwd()
  setwd(tmp_dir)
    
  # download the package (and the data from annex)
  repo_url = paste0(repo, ":", username, "/", package, ".git")
  system(paste0("git clone git@", repo_url))
  setwd(paste0("./", package))
  system("git annex get ./")

  devtools:::load_all("./")
  
  setwd(orig_dir)


  
  
  return()

} # end of emailme()

