#' Violion plotting for time graphs
#'
#' @param data a dataset provided by the erasmusladder
#' @param column wich collum you like to select, should be called with the quo function
#' @param title the title of your graph
#' @param y_as the name of the y-axis
#' @param session_num the amount of sessions you want to use
#'
#' @return
#' @export
#'
#' @examples
#' ruwe_data <- read_csv(here::here("data/data.csv"))
#' time_violin(dat_time, column = quo(`Trial duration(s)`), "Average trial duration per genotype", "Duration (s)", session_num = 1:20)
time_violin <- function(data, column, title, y_as, session_num){

  #Make new data set of "ruwe-data"
  duration_data <- data
  #Calculate the average duration per genotype
  duration_genotype_session <- duration_data %>%
    filter(Session == session_num) %>%
    group_by(Session, genotype) %>%
    summarize(mean_duration=mean(!!column))
  #Load a violin_graph
  graph <- duration_genotype_session %>%
    ggplot(aes(x = genotype, y = mean_duration, fill = genotype)) +
    geom_violin(trim = FALSE) +
    geom_boxplot(width = 0.1) +
    theme_minimal() +
    labs(title = title,
         subtitle = paste("Session selected", paste(session_num, collapse = ", ")),
         x = "Genotype",
         y = y_as,
         fill = "Genotype")

  # ggplotly(graph)
  return(graph)
}
