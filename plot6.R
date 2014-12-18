# Question : Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

library(ggplot2)
library(data.table)

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEI_Compare <- subset(NEI,NEI$fips %in% c("24510","06037"))

## Filtering on coal combustion-related sources
SCC_T <- as.data.table(SCC)
SCC_Vehicles <- SCC_T[EI.Sector %like% "Vehicles"]$SCC
NEI_Compare_Vehicles <- subset(NEI_Compare, SCC %in% SCC_Vehicles)

p6 <- merge(x=NEI_Compare_Vehicles, y=SCC, by="SCC")

p6_sum <- aggregate(p6$Emissions, by=list(p6$year,p6$EI.Sector,p6$fips), FUN = sum)
names(p6_sum) <- c("Year","EI.Sector","fips","Emissions")
p6_sum$County <- sapply(p6_sum$fips,switch,"06037" = "Los Angeles County", "24510" = "Baltimore City")


# Histogram drawing
png("plot6.png",width= 480, height = 480,  units= "px")
q <- qplot(x=Year,y=Emissions,data=p6_sum,color=EI.Sector,xlab="",ylab="") + geom_line() + facet_wrap(~County, ncol=2)
q <- q + ggtitle("Comparison: Tons of PM2.5 Emissions related to Vehicles per Year")
q <- q + theme(legend.position="bottom") + guides(col = guide_legend(nrow = 4))
require(scales)
q + scale_y_continuous(labels = comma, breaks=pretty(seq(min(p6_sum$Emissions), max(p6_sum$Emissions), by = 100)))
dev.off()
