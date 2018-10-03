library('ggplot2')
library('forecast')
library('tseries')
library('lubridate')
library('tidyquant')

verkkis = read.csv("VERK.HE.csv", header = TRUE)
freq=365.25
bollinger.close = ts(verkkis$Adj.Close, frequency=(freq), start=c(2013,41))
bollinger.High = ts(verkkis$High, frequency=(freq), start=c(2013,41))
bollinger.Low = ts(verkkis$Low, frequency=(freq), start=c(2013,41))

bollinger.union = ts.union(bollinger.close, bollinger.High, bollinger.Low)
verkkis$Date = as.Date(verkkis$Date)
#bollinger=data.matrix(bollinger.union) 
#band = BBands(bollinger, n = 20, sd = 2)

verkkis

verkkis%>%
ggplot(aes(x = Date, y = Close)) +
  geom_line() +           # Plot stock price
  geom_bbands(aes(high = High, low = Low, close = Close), ma_fun = SMA, n = 50) +
  coord_x_date(expand=TRUE)

