
#' data_to_pca: From tidy data.table estimate PCAs for well-defined groups
#'
#' @param dt_tmp: Tidy dataset
#' @param id1: vector of y (vertical) coordinates for the first line
#' @param id2: vector of x (horizontal) coordinates for the second line
#' @param value: vector of y (vertical) coordinates for the second line
#' @param n_pca: Number of PCAs to output
#' @param scale: Scaling option for the PCA analysis
#' @param plot: plot "time series" of PCA
#' @param verbose: non binding for now
#' @note Useful for some time series representations
#' @return list of datasets (and plot) of loadings and time series
#' @examples
#'   data_to_pca(dt_ind, date_y, ind, n_pca = 5)
#' @export
data_to_pca <- function(dt_to_pca,
                        id1,
                        id2,
                        value,
                        n_pca   = 2,
                        ...,
                        scale   = T,
                        plot    = F,
                        verbose = T
){

  message("\n# Start PCA on ", enquo(id1)[2])
  quo_id1   <- enquo(id1)
  quo_id2   <- enquo(id2)
  quo_value <- enquo(value)

  dt_pca  <- dt_to_pca %>% select(!!quo_id1, !!quo_id2, !!quo_value, ...) %>% data.table
  setnames(dt_pca, c("id1_var", "id2_var", "value"))

  # remove constants
  message("# Removing constant categories")
  dt_pca[, sd_val := sd(value), by = .(id1_var) ]
  dt_pca <- dt_pca[ !(sd_val == 0) ][, sd_val := NULL ]
  n_id1 <- nrow(unique(dt_pca[, .(id1_var) ]))

  # data from long to wide:
  message("# Transform the data from long to wide")
  # check that we have unique ids
  if (nrow(dt_pca[, .N, by = .(id1_var, id2_var) ][ N > 1 ]) > 0){
    error("# NON UNIQUE IDENTIFIERS")
  }
  dt_pca_wide <- dt_pca %>% data.frame %>% spread(id1_var, value) %>% data.table
  id2_list    <- dt_pca_wide$id2_var
  dt_pca_wide <- dt_pca_wide[, id2_var := NULL ]
  id1_list    <- colnames(dt_pca_wide)

  # PCA OPERATION
  message("# Running the Principal Component Analysis: ", n_id1, " different ids in dataset")
  res_pca <- prcomp((as.matrix(dt_pca_wide)), center = T, scale. = scale)

  dt_importance <- data.frame(summary(res_pca)$importance)[1:3, 1:(n_pca)]

  n_pca <- min(n_pca, n_id1)
  message("# Extracting PCs up to ... ", n_pca)
  dt_pca_out <- data.table(res_pca$x)[, paste0("PC", seq(1, n_pca)), with = F]
  dt_pca_out <- cbind(id2_var = id2_list, dt_pca_out)

  message("# Extracting loadings ... ")
  dt_loadings <- res_pca$rotation %>% data.table
  dt_loadings <- dt_loadings[, paste0("PC", seq(1, n_pca)), with = F]
  dt_loadings <- cbind(id1_var = id1_list, dt_loadings)

  if (plot == F){

    setnames(dt_pca_out, "id2_var", paste0(enquo(id2))[2])
    setnames(dt_loadings, "id1_var", paste0(enquo(id1))[2])
    return(list(dt_pca_out, dt_loadings))

  } else if (plot == T){

    dt_plot <- merge(dt_pca[, .(value = mean(value, na.rm = T) / sd(value, na.rm = T)), by = .(id2_var) ],
                     dt_pca_out, all.x = T, by = c("id2_var") )

    setnames(dt_pca_out, "id2_var", paste0(enquo(id2))[2])
    setnames(dt_loadings, "id1_var", paste0(enquo(id1))[2])

    ## setnames(dt_plot, c("id2_var", "value"), c(paste0(enquo(id2))[2], paste0(enquo(value))[2]) )
    pca_plot <- dt_plot %>%
      gather(type, value, -id2_var) %>% data.table %>%
      ggplot(aes(id2_var, value, colour = type)) +
      geom_line() + theme_bw()

    return(list(dt_pca_out,
                dt_loadings,
                dt_importance,
                pca_plot))

  }

} # end of data to pca
