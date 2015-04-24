setwd("/Users/WanRong/ExploratoryDA2/ExploratoryDA2")

## Read RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Coal combustion related sources
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge NEI and SCC datasets
mergeBoth <- merge(x=NEI, y=SCC.coal, by='SCC')
agg_merge <- aggregate(merge[, 'Emissions'], by=list(mergeBoth$year), sum)
colnames(agg_merge) <- c('Year', 'Emissions')

# Plot 4
png("plot4.png",width=480,height=480,units="px",bg="transparent")

ggplot(data=agg_merge, aes(x=Year, y=Emissions/1000)) + 
    geom_line(aes(group=1, col=Emissions)) + 
    geom_point(aes(size=2, col=Emissions)) + 
    ggtitle(expression('Total Emissions of PM'[2.5])) + 
    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
    geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
    theme(legend.position='none') + 
    scale_colour_gradient(low='black', high='red')

dev.off()