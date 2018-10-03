library('ggplot2')
library('forecast')
library('tseries')
library('lubridate')

x = read.csv('ulkoisilla.csv', header=TRUE)
nx = read.csv("ulkoisitta.csv", header=TRUE)
x$X <- format(date_decimal(x$X), "%Y-%m-%d")
colnames(x)[colnames(x) == 'X'] <- 'Date'
nx$X <- format(date_decimal(nx$X), "%Y-%m-%d")
colnames(nx)[colnames(nx) == 'X'] <- 'Date'


x$Date = as.Date(x$Date)
nx$Date = as.Date(nx$Date)
str(x)

ggplot() +
geom_line(data = x, aes(x = Date, y = Point.Forecast, colour = "With External Regressors")) +
geom_line(data = nx, aes(x = Date, y = Point.Forecast,   colour = "Without External Regressors")) +
ylab("Forecasted Stock Price €") + ggtitle("Nordea Stock Price Forecast")

ggplot() +
  geom_line(data = x, aes(x = Date, y = Point.Forecast, colour = "Average")) +
  geom_line(data = x, aes(x = Date, y = Lo.80,   colour = "Low 80%")) +
  geom_line(data = x, aes(x = Date, y = Hi.80,   colour = "High 80%")) +
  geom_point(data = x, aes(x = Date, y = Point.Forecast, colour = "Average")) +
  geom_point(data = x, aes(x = Date, y = Lo.80,   colour = "Low 80%")) +
  geom_point(data = x, aes(x = Date, y = Hi.80,   colour = "High 80%")) +
  ylab("Forecasted Stock Price €") + ggtitle("Nordea Stock Price Forecast")