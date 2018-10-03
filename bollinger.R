library('ggplot2')
library('forecast')
library('tseries')
library('lubridate')
library('tidyquant')

bollinger.close = ts(nordea$Adj.Close, frequency=(frq), start=c(2013,41))
bollinger.High = ts(nordea$High, frequency=(frq), start=c(2013,41))
bollinger.Low = ts(nordea$Low, frequency=(frq), start=c(2013,41))

bollinger.union = ts.union(bollinger.close, bollinger.High, bollinger.Low)
nordea$Date = as.Date(nordea$Date)
#bollinger=data.matrix(bollinger.union) 
#band = BBands(bollinger, n = 20, sd = 2)

nordea

nordea%>%
ggplot(aes(x = Date, y = Close)) +
  geom_line() +           # Plot stock price
  geom_bbands(aes(high = High, low = Low, close = Close), ma_fun = SMA, n = 50) +
  coord_x_date(expand=TRUE)

