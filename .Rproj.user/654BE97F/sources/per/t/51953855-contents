library('ggplot2')
library('forecast')
library('tseries')
library('lubridate')

frq=365.25/7


carbon = read.csv('carbon.csv', header=FALSE, stringsAsFactors = F)
colnames(carbon)[2] <- "Date"
colnames(carbon)[3] <- "Price"
colnames(carbon)[4] <- "Volume"
str(carbon)
carbon
datec=carbon$Date
date1=strptime(datec, format= "%m/%d/%Y")
str(carbon)

carbon_date = as.Date(date1, format = "%Y/%m/%d")
carbon$Date <- carbon_date

tail(carbon$Date, n=1)
carbon = carbon[seq(5, nrow(carbon), 5), ]
carbon_list <- list()
for (i in 3:12){

carbon_list[[i]] <- carbon[c(2,i,i+1)]
names(carbon_list[[i]]) <- c("Date", "Price", "Volume")
carbon_list[[i]]
x <- carbon_list[[i]]
x[2][x[2] >= 25] <- NA
x[2][x[2] <= 11] <- NA
x <- x[!is.na(x[2]), ]
carbon_list[[i]]<-x

}
carbon.df <- carbon_list[[3]]

for (i in 4:12){
  carbon.df = merge(carbon.df, carbon_list[i], sort=FALSE, all=TRUE)
}



carbon.ts = ts(carbon.df$Price, frequency=(frq), start=c(2011,43))
clean.carbon=tsclean(carbon.ts)
plot(clean.carbon)



autoplot(clean.carbon)
aa=auto.arima(clean.carbon)
aa
fc=forecast(aa, h=8)
autoplot(fc)
write.csv(fc, "fc_carbon.csv")
fcc = read.csv('fc_carbon.csv', header=TRUE)
fcc$X <- format(date_decimal(fcc$X), "%Y-%m-%d")
colnames(fcc)[colnames(fcc) == 'X'] <- 'Date'
fcc
ggplot() +
  geom_line(data = fcc, aes(x = Date, y = Point.Forecast, colour = "With External Regressors", group=1))
