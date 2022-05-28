#' This function function summaries data from custom columns
#'
#' @param data a dataset provided by R
#' @param col_steptype wich collum you like to select, should be called with the quo function
#' @param col_y The collum that contains the group you want to use, should be called with the quo function
#' @param session_num The amount of sessions you want to look at
#'
#' @return
#' @export
#'
#' @examples
#' ruwe_data <- read_csv(here::here("data/data.csv"))
#' data_var_ruw <- ruwe_data %>% as.tibble() %>%
#' select("genotype", ends_with("Steps%"), contains("Jumps%"), `L - L Backsteps%`, `H - L Long Steps%`, "Session")
#' data_var_ruw$genotype <- as.factor(data_var_ruw$genotype)
#' var_graph(data_var_ruw, col_steptype = quo("H - L"), col_y = quo(genotype), session_num = 10:20)
var_graph <- function(data, col_steptype, col_y, session_num) {
  # Define the columns in question under a new object
  columns <- data %>% select(contains(!!col_steptype)) %>% colnames()
  # Then we grouped the data and save it as a new tibble
  grouped_dat <- data %>% select(columns, !!col_y, Session) %>%
    filter(Session == session_num) %>% # Filter out the sessions called
    pivot_longer(cols = columns, # Pivot the tibble to be tidy
                 names_to = "step_type",
                 values_to = "values") %>%
    group_by(step_type, !!col_y) # And group it to only get the variables we need
  # Now we normaliza the data using the min max methode
  norm_dat <- min_max_norm(x = grouped_dat$values) %>%
    as.data.frame(row.names = NULL, optional = TRUE)
  # Add a name to the new  made column with the normalized data
  colnames(norm_dat) <- c("norm_values")
  # Mutate the norm data with the previous tibble containing all the other variables
  norm_sum_dat <- mutate(norm_dat, grouped_dat) %>% group_by(step_type, !!col_y) %>%
    summarise(mean_col = mean(norm_values, na.rm = T), # Calculate the mean and stdev
              stdv = sd(norm_values, na.rm = T))

  # Now we plot it in a graph using ggplot
  graph_steps <- norm_sum_dat %>% ggplot(aes(x = !!col_y, y = mean_col, fill = step_type)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Average percentage of steps by genotype",
         subtitle = paste("Session selected", paste(session_num, collapse = ", "), "Errorbars depict 1 standard deviation"),
         x = "Genotype",
         y = "Average percentage of steps") +
    ylim(0, 1) +
    geom_errorbar(aes(ymin = mean_col-stdv, ymax = mean_col+stdv),
                  width = .3, position = position_dodge(.9))

  # Only returns the graph
  return(graph_steps)
}
