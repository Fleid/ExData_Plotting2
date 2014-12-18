# Question : Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#### My Working Directory
# setwd("~/Documents/GitHub/ExData_Plotting2")

library(ggplot2)
library(data.table)

# Loading the datasets
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")

## Filtering on coal combustion-related sources
SCC_T <- as.data.table(SCC)
SCC_Coal <- SCC_T[EI.Sector %like% "Coal"]$SCC
NEI_Coal <- subset(NEI, SCC %in% SCC_Coal)

p4 <- merge(x=NEI_Coal, y=SCC, by=SCC)

p4_sum <- aggregate(p4$Emissions, by=list(p4$year,p4$EI.Sector), FUN = sum)
names(p4_sum) <- c("Year","EI.Sector","Emissions")


# Histogram drawing
png("plot4.png",width= 480, height = 480,  units= "px")
q <- qplot(x=Year,y=Emissions,data=p4_sum,color=EI.Sector,xlab="",ylab="") + geom_line()
q <- q + ggtitle("Total Tons of PM2.5 Emissions per Year and Sector")
q <- q + theme(legend.position="bottom") + guides(col = guide_legend(nrow = 3))
require(scales)
q + scale_y_continuous(labels = comma, breaks=pretty(seq(min(p4_sum$Emissions), max(p4_sum$Emissions), by = 50000)))
dev.off()


