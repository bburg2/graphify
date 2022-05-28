#' Make a graph based on data provided by the erasmusladder
#'
#' @param data a dataset, provided by the erasmusladder
#' @param column the name of the collum wich u want to use should be called with quo function
#' @param title how you want to name the graph
#' @param y_as how you want to name the y-axis
#' @import plotly
#' @return a graph
#' @export
#'
#' @examples
#' data_time <- read_csv(here("data", "data.csv"))
#' time_graph(data_time, column = quo(`Trial duration(s)`), "Average trail duration per session per genotype", "Duration (s)")
time_graph <- function(data, column, title, y_as){

  #Make new data set of "ruwe-data"
  duration_data <- data

  #Calculate the average duration per session and genotype
  duration_genotype_session <- duration_data %>% group_by(Session, genotype) %>% summarize(mean_duration=mean(!!column), stdev=sd(!!column))

  #Load a bar_graph
  graph <- duration_genotype_session %>%
    ggplot(aes(x = duration_genotype_session$Session, y = duration_genotype_session$mean_duration, fill = duration_genotype_session$genotype)) +
    geom_bar(stat = "identity", position= "dodge") +
    geom_errorbar(aes(x=Session, ymin=mean_duration-stdev, ymax=mean_duration+stdev), width=.2,position=position_dodge(0.9), size=0.5) +
    theme_minimal() +
    labs(title = title,
         x = "Session",
         y = y_as,
         fill = "Genotype")
  #geom_vline(xintercept = 10, colour = "red")      # Een line waar de bekinjecellen niet meer werken

  ggplotly(graph)
}
