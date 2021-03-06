
data<-read_csv('data/utah_lake.csv')
data_orig<-data
#quitar fraccion al parametro si solo tiene Total
data$char<-data$Characteristic=="Turbidity"
data$Fraction = ifelse(data$char==TRUE, NA, data$Fraction)
data = select (data,-c(char))
data$char<-data$Characteristic=="pH"
data$Fraction = ifelse(data$char==TRUE, NA, data$Fraction)
data = select (data,-c(char))
#juntar los distitos tipos de clorofila-a
data$chla<-data$Characteristic=="Chlorophyll a, corrected for pheophytin"
data$Characteristic = ifelse(data$chla==TRUE,"Chlorophyll a",data$Characteristic)
data = select (data,-c(chla))
data$chla<-data$Characteristic=="Chlorophyll a, uncorrected for pheophytin"
data$Characteristic = ifelse(data$chla==TRUE,"Chlorophyll a",data$Characteristic)
data = select (data,-c(chla))
data$chla<-data$Characteristic=="Chlorophyll a, free of pheophytin"
data$Characteristic = ifelse(data$chla==TRUE,"Chlorophyll a",data$Characteristic)
data = select (data,-c(chla))
#agregar fraccion al parametro
data$frac1<-data$Fraction==''
data$frac1 = ifelse(is.na(data$frac1), TRUE, FALSE)
data$frac2<-paste(data$Characteristic, data$Fraction)
data$Characteristic = ifelse(data$frac1==TRUE, data$Characteristic, data$frac2)
data = select (data,-c(frac1, frac2))
data<-data
#tomar las fechas como tales
data$Date = as.Date(data$Date, "%m-%d-%Y")
#contar la cantidad de parametros
param<-data[!duplicated(data$Characteristic), ]
total_param<-nrow(param)