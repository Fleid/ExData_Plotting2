# Question : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Calculate the sum of emissions per year
p1 <- aggregate(NEI$Emissions, by=list(NEI$year), FUN = sum)
names(p1) <- c("Year","Emissions")

# Alteration of the set so that it fits the hist function correctly
p2 <- t(as.matrix(p1))

# Histogram drawing
png("plot1.png",width= 500, height = 480,  units= "px")
barplot(p2,beside=FALSE,col="#223856",yaxt="n",main="Total Tons of PM2.5 Emissions per Year",names=p2[1,])
pts <- seq(0,8)
axis(2, at = pts*1000000, labels = paste(pts, "MM", sep = ""),las=2)
dev.off()

