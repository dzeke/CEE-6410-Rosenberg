###  Build Interative Parallel Coordinate Plot for Lake Maggorrie Management Objectives and Decision Variables (HW 7)
# Follow Plotly instructions (https://plot.ly/r/getting-started/) and provide credientials on lines 35 & 36.
#
# David Rosenberg
# Utah State University
# david.rosenberg@usu.edu
# January 21, 2019

# Load the relevant packages
install.packages("plotly")
install.packages("crosstalk")
install.packages("dplyr")
library(plotly)
library(dplyr)

# Read CSV into R dataframe
dfMaggorieAlts <- read.csv(file="HW7_alts.csv", 
                               header=TRUE, 
                                
                               stringsAsFactors=FALSE,
                               sep=",")

# Reader the header names from the dataframe
MaggorieVars <- names(dfMaggorieAlts)

# Define column headers to include on the plot
MaggorieVarsAbrev <- c('Flood Intensity (m)','Unmet Irrigation Demand (m3/d)','Unmet Hydropower Demand (m3/d)', 'Recreation Storage Deficit (m3)',
                       'Shortage Slope (x1; radians)', ' Spill Trigger (x2; m3)', 'Spill Slope (x3; radians)')


### Load Using Plotly
# https://plot.ly/r/getting-started/

# Provide Plotly API credentials
# Find API credentials at https://chart-studio.plotly.com/settings/api#/
Sys.setenv("plotly_username"="XXXXXXX")
Sys.setenv("plotly_api_key"="YYYYYYYYY")

# Follow these instructions
# https://plot.ly/r/parallel-coordinates-plot/

packageVersion('plotly')

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="parcoords-dimensions")
chart_link

#df <- read.csv("https://raw.githubusercontent.com/bcdunbar/datasets/master/iris.csv")

#Calculate mins and maxes
mins <- floor(apply(dfMaggorieAlts,2,min))
maxes <- ceiling(apply(dfMaggorieAlts,2,max))

p <- dfMaggorieAlts %>%
  plot_ly(type = 'parcoords',
          line = list(color='blue'),
          dimensions = list(
            list(range = c(mins[1],maxes[1]),
                 label = MaggorieVarsAbrev[1], values =  ~FloodIntensity,
                 tickvals= c(mins[1],maxes[1])),
            list(range = c(mins[2],maxes[2]),
                 label = MaggorieVarsAbrev[2], values = ~UnmetIrrDemand,
                 tickvals= c(mins[2],maxes[2])),
            list(range = c(mins[3],maxes[3]),
                 label = MaggorieVarsAbrev[3], values =  ~UnmetHydroDemand,
                 tickvals= c(mins[3],maxes[3])),
            list(range = c(mins[4],maxes[4]),
                 label = MaggorieVarsAbrev[4], values = ~UnmetRecreationDemand,
                 tickvals= c(mins[4],maxes[4])),
            list(range = c(mins[5],maxes[5]),
                 tickvals = c(mins[5],maxes[5]),
                 label = MaggorieVarsAbrev[5], values = ~x1),
            list(range = c(mins[6],maxes[6]),
                 tickvals = c(mins[6],maxes[6]),
                 label = MaggorieVarsAbrev[6], values = ~x2),
            list(range = c(mins[7],maxes[7]),
                 tickvals = c(mins[7],maxes[7]),
                 label = MaggorieVarsAbrev[7], values = ~x3)
 
            )
         )


print (p)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="parcoords-basic")
chart_link

# Show another matrix correlation plot (18 x 18)
# Calculate correlation matrix for variables
# Approach #1 from https://www.r-bloggers.com/scatter-plot-matrices-in-r/
corMatrix <- cor(dfMaggorieAlts[,1:7])

# Approach #2 from https://www.r-bloggers.com/scatter-plot-matrices-in-r/
pairs(dfMaggorieAlts[,1:7])


