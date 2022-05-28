#' Normalise a dataset from erasmusladder
#'
#' @param x The data (should be provided by erasmusladder)
#'
#' @return
#' @export
#'
#' @examples
#' grouped_dat <- data %>% select(columns, !!col_y, Session) %>%
#' filter(Session == session_num) %>% # Filter out the sessions called
#' pivot_longer(cols = columns, # Pivot the tibble to be tidy
#'             names_to = "step_type",
#'                         values_to = "values") %>%
#'                         group_by(step_type, !!col_y) # And group it to only get the variables we need
#' norm_dat <- min_max_norm(x = grouped_dat$values) %>%
#' as.data.frame(row.names = NULL, optional = TRUE)
min_max_norm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
