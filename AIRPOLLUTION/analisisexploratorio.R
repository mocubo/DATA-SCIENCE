#Carga de paquetes
library (ggplot2)
library(dplyr)
library (tidyr)


#Carga de datos
codigos <- readRDS("Source_Classification_Code.rds")
datosemisiones <- readRDS("summarySCC_PM25.rds")

#Plot1
anuales<- tapply (datosemisiones$Emissions,as.factor( datosemisiones$year), sum, simplify = FALSE)
years <- as.numeric(names(anuales))
toneladas<- as.numeric(anuales)/1000000
resultados<- data.frame(years, toneladas)
plot1 <- ggplot(resultados, aes(years, toneladas))
plot1 + geom_point(col= 'red', size = 4)+ geom_line()+ labs (title = 'Evolucion de la contaminacion total')

#Plot2
datosemisionesbaltimore <- subset (datosemisiones, datosemisiones$fips == '24510')
anuales<- tapply (datosemisionesbaltimore$Emissions,as.factor( datosemisionesbaltimore$year), sum, simplify = FALSE)
years <- as.numeric(names(anuales))
kilogramos<- as.numeric(anuales)/1000
resultados<- data.frame(years, kilogramos)
plot2 <- ggplot(resultados, aes(years, kilogramos))
plot2 + geom_point(col= 'red', size = 4)+ geom_line()+ 
        labs (title = 'Evolucion de la contaminacion total en Baltimore')+ 
        geom_smooth( method = 'lm', se = FALSE, col = 'red', lwd = 2)

#Plot3
datbalt <- subset (datosemisiones, datosemisiones$fips == '24510')
datbaltres<- datbalt %>%
        select(c(Emissions, type,year)) %>%
        group_by(type, year) %>%
        summarise('emisiones totales'=sum(Emissions))
plot3<- ggplot(data= datbaltres,aes (year,`emisiones totales` ))
plot3 + geom_point(aes(color = type), size = 3)+
        labs (title = 'Evolucion de la contaminacion total en Baltimore por tipo de foco')+
        geom_smooth(aes(color = type), method = 'lm', se = FALSE, lwd = 1)

#Plot4
coal <- subset(codigos$SCC, grepl ('*Coal*', codigos$EI.Sector))
datcoal <- subset(datosemisiones, SCC %in% coal)
datcoalres<- datcoal %>%
        select(c(Emissions,year)) %>%
        group_by(year) %>%
        summarise('emisiones totales'=sum(Emissions))
plot4<- ggplot(data= datcoalres,aes (year,`emisiones totales` ))
plot4 + geom_point(col= 'red', size = 4)+ geom_line()+ 
        labs (title = 'Evolucion de la contaminacion por carbon')+ 
        geom_smooth( method = 'lm', se = TRUE, col = 'red', lwd = 1)

#Plot5
codmob <- subset(codigos, SCC.Level.One == 'Mobile Sources' & Data.Category == 'Onroad')
datmob <- subset (datosemisiones, SCC %in% codmob$SCC & datosemisiones$fips == '24510')
datmobres<- datmob %>%
        select(c(Emissions,year)) %>%
        group_by(year) %>%
        summarise('emisiones totales'=sum(Emissions))
plot5<- ggplot(data= datmobres,aes (year,`emisiones totales` ))
plot5 + geom_point(col= 'red', size = 4)+ geom_line()+ 
        labs (title = 'Evolucion de la contaminacion por vehiculos baltimor')+ 
        geom_smooth( method = 'lm', se = FALSE, col = 'red', lwd = 1)

#Plot6
codmob <- subset(codigos, SCC.Level.One == 'Mobile Sources' & Data.Category == 'Onroad')
datmob <- subset (datosemisiones, SCC %in% codmob$SCC & (fips == '24510'|fips == '06037'))
datmobres<- 
        datmob %>%
        select(c(Emissions,year, fips)) %>%
        group_by(year,fips) %>%
        summarise('emisiones totales'=sum(Emissions))
plot6<- ggplot(data= datmobres,aes (year,`emisiones totales` ))
plot6 + geom_point(aes(color = fips), size = 3)+
        labs (title = 'Evolucion de la contaminacion total en Baltimore y los angeles por tipo de foco')+
        geom_smooth(aes(color = fips), method = 'lm', se = FALSE, lwd = 1)
        
#Plot6, opcion de en dos graficos, escalas libres
plot6 + facet_wrap(vars (fips), scales = 'free')+
        geom_point(aes(color = fips), size = 3)+
        labs (title = 'Evolucion de la contaminacion total en Baltimore y los angeles por tipo de foco')+
        geom_smooth(aes(color = fips), method = 'lm', se = FALSE, lwd = 1) 
