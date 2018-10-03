library('ggplot2')
library('forecast')
library('tseries')
library('lubridate')

nordea = read.csv('NDA1v.HE.csv', header=TRUE)
sampo = read.csv("SAMPO.HE.csv", header=TRUE)
nordeatrend = read.csv("multiTimeline.csv", header=TRUE)
nordeatrend
frq=365.25/7 

trend = ts(nordeatrend[2], frequency=(frq), start=c(2013,41))
trend
sampo.ts=ts(sampo$Adj.Close, frequency=(frq), start=c(2013,41))
length(sampo.ts)
sampo.ts
volume = ts(nordea$Volume, frequency=(frq), start=c(2013,41))
union=ts.union(sampo.ts,trend,volume)

xreg=data.matrix(union)          
#External forecast done by repeating last value
#fxreg=data.matrix(ts.union(ts(rep.int(sampo.ts[length(sampo.ts-1)],8)),
                           #ts(rep.int(trend[length(trend-1)],8)),
                           #ts(rep.int(volume[length(trend-1)],8))))

#Actually forecasting external factors
s = forecast(auto.arima(sampo.ts),h=8)
t = forecast(auto.arima(trend),h=8)
v = forecast(auto.arima(volume),h=8)
ts=ts(s$mean)
ts
fxreg=data.matrix(ts.union(ts(s$mean),
                           ts(t$mean),
                           ts(v$mean)))
fxreg

nordea$Date = as.Date(nordea$Date)
nordea.ts = ts(nordea$Adj.Close, frequency=(frq), start=c(2013,41))
nordea.ts = tsclean(nordea.ts)
plot(nordea.ts)
arima.nordea <- auto.arima(nordea.ts, xreg = xreg, D=1)
fc = forecast(arima.nordea, h=8, xreg=fxreg)
#arima.nordea <- auto.arima(nordea.ts, D=1)
#fc = forecast(arima.nordea, h=8)
nordea.ts
autoplot(fc)
fc
write.csv(fc,"ulkoisilla.csv")
xreg