

tweet_date <- function(x) {
  
  stopifnot(is.data.frame(x))
  plot_day <- ggplot(data = x, aes(x = wday(date, label = TRUE))) +
  geom_histogram(stat = 'count', aes(fill = ..count..)) +
  theme_bw() +
  theme(legend.position = "none") +
  xlab("Day of the Week") + ylab("Number of tweets") + 
  scale_fill_gradient(low = "midnightblue", high = "aquamarine4")
  
  x$date <- month.abb[month(x$date)]
  x$date <- as.factor(x$date)
  x$date <- ordered(x$date, month.abb)
  
  plot_month <- ggplot(data = x, aes(x = date)) +
  geom_histogram(stat = 'count', aes(fill = ..count..)) +
  theme_bw() +
  theme(legend.position = "none") +
  xlab("Month of the Year") + ylab("Number of tweets") + 
  scale_fill_gradient(low = "midnightblue", high = "aquamarine4")  
  
  result <- list(plot_day, plot_month)
  return(result)
}










