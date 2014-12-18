# Question : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

# Calculate the sum of emissions per year
NEI_Baltimore <- subset(NEI,NEI$fips == "24510") 
p1_Baltimore <- aggregate(NEI_Baltimore$Emissions, by=list(NEI_Baltimore$year), FUN = sum)
names(p1_Baltimore) <- c("Year","Emissions")

# Alteration of the set so that it fits the hist function correctly
p2_Baltimore <- t(as.matrix(p1_Baltimore))

# Histogram drawing
png("plot2.png",width= 480, height = 480,  units= "px")
barplot(p2_Baltimore,beside=FALSE,col="#bc5e56",main="Baltimore: Tons of PM2.5 Emissions per Year",names=p2_Baltimore[1,],border=NA)
dev.off()

