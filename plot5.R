# Question : How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

library(ggplot2)
library(data.table)

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

NEI_Baltimore <- subset(NEI,NEI$fips == "24510") 

## Filtering on coal combustion-related sources
SCC_T <- as.data.table(SCC)
SCC_Vehicles <- SCC_T[EI.Sector %like% "Vehicles"]$SCC
NEI_Baltimore_Vehicles <- subset(NEI_Baltimore, SCC %in% SCC_Vehicles)

p5 <- merge(x=NEI_Baltimore_Vehicles, y=SCC, by="SCC")

p5_sum <- aggregate(p5$Emissions, by=list(p5$year,p5$EI.Sector), FUN = sum)
names(p5_sum) <- c("Year","EI.Sector","Emissions")


# Histogram drawing
png("plot5.png",width= 480, height = 480,  units= "px")
q <- qplot(x=Year,y=Emissions,data=p5_sum,color=EI.Sector,xlab="",ylab="") + geom_line()
q <- q + ggtitle("Baltimore: Tons of PM2.5 Emissions related to Vehicles per Year")
q <- q + theme(legend.position="bottom") + guides(col = guide_legend(nrow = 4))
require(scales)
q + scale_y_continuous(labels = comma, breaks=pretty(seq(min(p5_sum$Emissions), max(p5_sum$Emissions), by = 10)))
dev.off()


