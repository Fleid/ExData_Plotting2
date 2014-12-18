# Question : Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
##Use the ggplot2 plotting system to make a plot answer this question

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

library(ggplot2)

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Calculate the sum of emissions per year
NEI_Baltimore <- subset(NEI,NEI$fips == "24510") 
p1_Baltimore_Type <- aggregate(NEI_Baltimore$Emissions, by=list(NEI_Baltimore$year,NEI_Baltimore$type), FUN = sum)
names(p1_Baltimore_Type) <- c("Year","Type","Emissions")

# Histogram drawing
png("plot3.png",width= 480, height = 480,  units= "px")
qplot(x=Year,y=Emissions,data=p1_Baltimore_Type,color=Type,xlab="",ylab="")+geom_line()+ggtitle("Baltimore : Tons of PM2.5 Emissions per Year and Type")
dev.off()
