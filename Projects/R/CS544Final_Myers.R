library(prob)
library(stats)
library(stringr)
library(plotly)
library(RColorBrewer)
library(tidyverse)
library(sampling)

# Set working directory
setwd(dir="C:/Users/kakar/OneDrive/Desktop/CS 544 R/Final Project")
dir()

# Read in 'discipline_details.csv' dataset.
olympics <- read.csv(
  "discipline_details.csv", 
  header = TRUE)

# Extract genders of participants and create new category.
olympics$gender = word(olympics$category, -1, sep=', ')

# Fix encoding format issues with replacement text.
olympics$category = str_replace_all(olympics$category, 'Ã—', 'x')
olympics$date = str_replace_all(olympics$date, 'â€“ ', '-')

# Plot #1 - Comparing participation in each Olympic year (tibble).

tibble(olympics) %>%
  select(event_year, discipline, category, n_participants, 
         n_country_participants) %>%
  group_by(event_year) %>%
  summarize(participants_year = sum(n_participants), 
            countries_year = sum(n_country_participants),
            event_num = length(unique(category))) -> years; years

# create a plotly barchart.
plot_ly(years) %>%
  layout(title='Increases Across Winter Olympic Years',
         xaxis=list(title="Olympic Years", tickvals=~event_year),
         margin=list(l=50, r=50, pad=0),
         yaxis=list(title="Number of Participants"),
         yaxis2=list(title=list(text="Number of Events"), 
                     range=c(5,100), dtick=5,
                     overlaying='y', side='right'),
         yaxis3=list(title=list(text="Number of Countries"),
                     range=c(75,2000), dtick=200,
                     overlaying='y', side='right', anchor='free', position=1.3),
         showlegend=T, legend=list(x=0.1,y=0.9 )
  ) %>%
  add_trace(x = ~event_year,
            y = ~participants_year,
            type="bar",
            color=I('light blue'),
            name="# of Athletes",
            hovertemplate='Year: %{x}, Participants: %{y}',
            width=1.75
  )%>%
  add_trace(x = ~event_year, 
            y = ~countries_year, 
            type='scatter', 
            mode='lines+markers',
            yaxis='y3',
            name="# of Countries", 
            hovertemplate='Year: %{x}, Countries: %{y}', 
            color=I('orange')
  )%>%
  add_trace(x = ~event_year, 
          y = ~event_num, 
          type='scatter', 
          mode='lines+markers',
          yaxis='y2',
          name="# of Events", 
          hovertemplate='Year: %{x}, Events: %{y}', 
          color=I('red')
)

# Plot 1B - Scatterplots of Correlation

select(years, py=participants_year, cy=countries_year, en=event_num) -> years2

c1 = plotly_empty(years2, x=0, y=0, type='scatter', mode='markers', visible=F)
              
c2 = plot_ly(years2, x=~py, y=~cy, type='scatter', mode='markers',
             name="# Participants vs. # Countries")
c3 = plot_ly(years2, x=~py, y=~en, type='scatter', mode='markers',
             name="# Participants vs. # Events")
c4 = plot_ly(years2, x=~cy, y=~py, type='scatter', mode='markers',
             name="# Countries vs. # Participants")
c5 = plotly_empty(years2, x=NULL, y=NULL, type='scatter', mode='markers') %>%
  add_annotations(x=0,y=0, showarrow=F, textposition='center',
      text = "<b>Correlation Plot\nParticipants vs.\nCountries vs.\nEvents<b>")
             
c6 = plot_ly(years2, x=~cy, y=~en, type='scatter', mode='markers',
             name="# Countries vs. # Events")
c7 = plot_ly(years2, x=~en, y=~py, type='scatter', mode='markers',
             name="# Events vs. # Participants")
c8 = plot_ly(years2, x=~en, y=~cy, type='scatter', mode='markers',
             name="# Events vs. # Countries")
c9 = plotly_empty(years2, x=0, y=0, type='scatter', mode='markers', visible=F)

subplot(c1,c2,c3,c4,c5,c6,c7,c8,c9, nrows=3) %>%
  layout(legend=list(orientation='h'))


# Correlation Between Event Participants & Country Participants

round(cor(years[2:4]), 5) -> corrVals

# Plot 1C - Gender Disparity in Events Across Years

tibble(olympics) %>%
  select(event_year, gender, n_participants, category) -> baseSet

baseSet %>%
  filter(event_year==1924) -> gen1924
baseSet %>%
  filter(event_year==1976) -> gen1976
baseSet %>%
  filter(event_year==2018) -> gen2018

plot_ly() %>%
  layout(showlegend=T, grid=list(rows=1, columns=3),
         title="Multi-Year Gender Distribution of Winter Olympics") %>%
  add_pie(gen1924, type='pie', labels=gen1924$gender, hole=.4, name="1924",
          values=gen1924$n_participants, textinfo='label+percent',
          marker=list(line=list(color='#FFFFFF', width=2)),
          domain=list(x=c(0.08, 0.32), y=c(0,1)), title="1924") %>%
  
  add_pie(gen1976, type='pie', labels=gen1976$gender, hole=.4, name="1976",
          values=gen1976$n_participants, textinfo='label+percent',
          marker=list(line=list(color='#FFFFFF', width=2)),
          domain=list(x=c(0.38, 0.62), y=c(0,1)), title="1976") %>%
  
  add_pie(gen2018, type='pie', labels=gen2018$gender, hole=.4, name="2018",
          values=gen2018$n_participants, textinfo='label+percent',
          marker=list(line=list(color='#FFFFFF', width=2)),
          domain=list(x=c(0.68, 0.92), y=c(0,1)), title="2018")




# Plot #2 - Distribution of Athletes to Events, Top 15 participated events.

# Represent the top 15 participated events using a tibble
tibble(olympics) %>%
  select(category, n_participants) %>%
  group_by(category) %>%
  summarize(part_category = sum(n_participants)) %>%
  arrange(desc(part_category)) -> events; events
    
topEvents = events$category[1:15]  

# A second tibble sorts the data by event category, then summarizes a new 
# plotting tibble with a top-15 trimmed category, median and participant data.
tibble(olympics) %>%
  select(category, n_participants) %>%
  group_by(category) %>%
  summarize(category = category[category %in% topEvents], 
            median = median(n_participants[category %in% topEvents]),
            n_participants = n_participants[category %in% topEvents]) %>%
  arrange(desc(median)) -> perEvent; perEvent

# Create a medians vector to order the y-axis.
lblMedian = rev(unique(perEvent$category))
  
# A plot_ly boxplot for the data.
plot_ly(perEvent, type="box", y=~category, x=~n_participants, color=~category)%>%
  
  layout(title="Top 15 Event Participation Across All Winter Olympics",
         xaxis=list(title="# of Participants", range=c(0,350), showgrid=T),
         yaxis=list(title=list(text="Event", standoff=1L), showgrid=T,  
            categoryorder = 'array', categoryarray = lblMedian))
  
  
# Plot #3 - Distribution of Countries to Events, Top 15 participated events.

# Represent the top 15 participated events using a tibble
tibble(olympics) %>%
  select(category, n_country_participants) %>%
  group_by(category) %>%
  summarize(country_category = sum(n_country_participants)) %>%
  arrange(desc(country_category)) -> events2; events2

topEvents2 = events2$category[1:15]  

# A second tibble sorts the data by event category, then summarizes a new 
# plotting tibble with a top-15 trimmed category, median and participant data.
tibble(olympics) %>%
  select(category, n_country_participants) %>%
  group_by(category) %>%
  summarize(category = category[category %in% topEvents2], 
            median = median(n_country_participants[category %in% topEvents2]),
            n_country_participants = 
              n_country_participants[category %in% topEvents2]) %>%
  arrange(desc(median)) -> perEvent2; perEvent2

# Create a medians vector to order the y-axis.
lblMedian2 = rev(unique(perEvent2$category))

# A plot_ly boxplot for the data.
plot_ly(perEvent2, type="box", y=~category, x=~n_country_participants, 
        color=~category)%>%
  
  layout(title="Top 15 Event Country Participation Across All Winter Olympics",
         xaxis=list(title="# of Participant Countries", range=c(0,80), showgrid=T),
         yaxis=list(title=list(text="Event", standoff=1L), showgrid=T,  
                    categoryorder = 'array', categoryarray = lblMedian2))

  
# Plot #4 - Most Winning Countries by Medal Count across all Winter Olympics

# Sum all medals earned by each country across all years.

# Create a tibble to sum all medals earned by each country across years
tibble(olympics) %>%
  select(gold_country, silver_country, bronze_country) %>%
  summarize(country = unique(c(gold_country,silver_country,bronze_country)),
            count = (table(c(gold_country, silver_country, bronze_country)))
            [country]) %>%
  mutate(count = as.integer(count)) %>%
  arrange(desc(count)) -> medals; medals 

# Trim the data to include only top 10 medal winning countries.
medalsTop = medals[1:10, ]
medalsBot = medals[11:length(medals), ]

# Total the remaining countries medal winnings for comparison pie chart.
allMedals = medalsTop
allMedals[11,1] ="Other Countries"
allMedals[11,2] = sum(medalsBot$count, na.rm=T)

# Create a plotly pie chart.
plot_ly(medalsTop, type='pie', labels=~country, values=~count,
            textinfo='label+percent', hoverinfo = 'text',
            text = paste("Country: ", medalsTop$country, ", Medals: ", 
                         medalsTop$count),
            marker=list(line=list(color='#FFFFFF', width=2)), 
            title="Top 10 Winning Countries")%>%
  layout(title="Proportion of Medals Won Across all Winter Olympics",
         showlegend=F, grid=list(rows=1, columns=2))%>%
  add_pie(allMedals, type='pie', labels=allMedals$country, 
            values=allMedals$count, textinfo='label+percent',
            text = paste("Country: ", allMedals$country, ", Medals: ",
                          allMedals$count),
            marker=list(line=list(color='#FFFFFF', width=2)),
            domain=list(row=0, column=1), 
            title="Compared with All other Countries")


# Plot #5 - Bivariate Table - countries each year vs frequency of medals.

# create 3 tibbles to summarize total medal data for the desired years.
tibble(olympics) %>%
  filter(event_year==1924) %>%
  summarize(country = unique(c(gold_country,silver_country,bronze_country)),
            count = (table(c(gold_country, silver_country, bronze_country)))
            [country]) -> med1924
tibble(olympics) %>%
  filter(event_year==1976) %>%
  summarize(country = unique(c(gold_country,silver_country,bronze_country)),
            count = (table(c(gold_country, silver_country, bronze_country)))
            [country]) -> med1976
tibble(olympics) %>%
  filter(event_year==2018) %>%
  summarize(country = unique(c(gold_country,silver_country,bronze_country)),
            count = (table(c(gold_country, silver_country, bronze_country)))
            [country]) -> med2018

# Create a plot_ly and add the three bar charts to the plot in stack mode.
plot_ly()%>%
  layout(title="All Medals Per Country vs.Year", autosize=T, 
         margin=list(b=-20, pad=-2), barmode='stack', 
         xaxis=list(title="Country/Year Grouping", automargin=F),
         yaxis=list(title="# of Medals", dtick=5, range=c(0,40)))%>%
  add_bars(med1924, y=med1924$count, x=med1924$country, name="1924 Medals")%>%
  add_bars(med1976, y=med1976$count, x=med1976$country, name="1976 Medals")%>%
  add_bars(med2018, y=med2018$count, x=med2018$country, name="2018 Medals")


# Plot Series #6 - Central Limit Theorem - Participants per Event

# Frequency comparison between sampling, isolate the top 10 events.

allNum = sum(olympics$n_participants) 

tibble(olympics) %>%
  select(category, n_participants) %>%
  group_by(category) %>%
  summarise(category, allPart = sum(n_participants)) -> topData

rev(sort(unique(topData$allPart)))[1:10] -> topPart
nameVar = unique(topData$category[topData$allPart == topPart])

top10 = subset(olympics, olympics$category %in% nameVar)
top10 = subset(top10, !is.na(top10$n_participants))
allTop10 = sum(top10$n_participants)

# Frequency of top 10, represented in %
tibble(top10) %>%
  select(category, n_participants) %>%
  group_by(category) %>%
  summarise(category = unique(category), 
            Population = sum(n_participants)/allTop10*100) %>%
  #group_by(category, Population=max(Population)) %>%
  mutate(Event = category, category=NULL) %>%
  select(Event, Population) -> startData

# Calculate mean and SD of population data.
meanTib = round(mean(top10$n_participants, na.rm=T), 2)
sdTib = round(sd(top10$n_participants, na.rm=T), 2)

# Create a plot_ly histogram of the population data.
plot_ly(top10, type='histogram', x=~n_participants, 
        name="Participants Per Event") %>%
  layout(title="Histogram of Participants Per Event", bargap=0.1, 
         xaxis=list(title="Participant Count", range=c(0,350)),
         yaxis=list(title="Frequency", range=c(0,180))) %>%
  add_segments(x=meanTib, y=0, xend=meanTib, yend=180, 
               name=paste("Mean = ", meanTib)) %>%
  add_segments(x=c(meanTib+sdTib, meanTib-sdTib), 
               xend=c(meanTib+sdTib, meanTib-sdTib), y=c(0,0), 
               yend=c(180,180), name=paste("S.Dev = ", sdTib))

# Random sampling sizes 20,40,60,80.
samples=500
xbar = numeric(samples)
pop = top10$n_participants
output = paste0('\nPopulation Mean = ', meanTib, "    Population SD = ", sdTib, "\n\n")

# Acquire sample data of different sizes from sample pool of 500.
# Create individual plot_ly histograms of sample data and track mean/SD.
for (i in 1:samples) {
  xbar[i] = mean(sample(pop, 25, replace = T))
}
s1 = plot_ly(x=xbar, type='histogram', name="Participant Sample: 25") %>%
  layout(xaxis=list(range=c(0,350)), yaxis=list(range=c(0,80)),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Sample: 25\nMean: ", round(mean(xbar),2),
                                     "\nSD: ", round(sd(xbar), 2))))
output = c(output, paste0("Sample Size = 25  Mean = ", round(mean(xbar),2)), 
  "\n Actual SD = ", round(sd(xbar), 2), "Expected SD = ", 
  round(sdTib/sqrt(25), 2), "\n\n")
for (i in 1:samples) {
  xbar[i] = mean(sample(pop, 50, replace = T))
}
s2 = plot_ly(x=xbar, type='histogram', name="Participant Sample: 50") %>%
  layout(xaxis=list(range=c(0,350)), yaxis=list(range=c(0,80), title='Frequency'),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Sample: 50\nMean: ", round(mean(xbar),2),
                                     "\nSD: ", round(sd(xbar), 2))))
output = c(output, paste0("Sample Size = 50  Mean = ", round(mean(xbar),2)), 
           "\n Actual SD = ", round(sd(xbar), 2), "Expected SD = ", 
           round(sdTib/sqrt(50), 2), "\n\n")
for (i in 1:samples) {
  xbar[i] = mean(sample(pop, 75, replace = T))
}
s3 = plot_ly(x=xbar, type='histogram', name="Participant Sample: 75") %>%
  layout(xaxis=list(range=c(0,350), title="Participant Count"),
         yaxis=list(range=c(0,80)),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Sample: 75\nMean: ", round(mean(xbar),2),
                                     "\nSD: ", round(sd(xbar), 2))))
output = c(output, paste0("Sample Size = 75  Mean = ", round(mean(xbar),2)), 
           "\n Actual SD = ", round(sd(xbar), 2), "Expected SD = ", 
           round(sdTib/sqrt(75), 2), "\n\n")
for (i in 1:samples) {
  xbar[i] = mean(sample(pop, 100, replace = T))
}
s4 = plot_ly(x=xbar, type='histogram', name="Participant Sample: 100") %>%
  layout(xaxis=list(range=c(0,350), title="Participant Count"), 
         yaxis=list(range=c(0,80), title="Frequency"),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Sample: 100\nMean: ", round(mean(xbar),2),
                                     "\nSD: ", round(sd(xbar), 2))))
output = c(output, paste0("Sample Size = 100  Mean = ", round(mean(xbar),2)), 
           "\n Actual SD = ", round(sd(xbar), 2), "Expected SD = ", 
           round(sdTib/sqrt(100), 2), "\n\n")

# Plot the results in a 2x2 grid using subplot(). 
subplot(s1, s2, s3, s4, nrows=2, shareX=F, shareY=T, titleX=T, titleY=T) %>%
  layout(title="Samples of Participants Per Event", bargap=0.1, showlegend=F)
  

# Display the size/mean/SD output.       
cat(output)


# Plot Series #7 - Multiple Sampling Methods (sample pool = 100)

# Reuse popSet from above as population data set

output2 = paste0('\nPopulation Mean = ', meanTib, "    Population SD = ", sdTib, "\n\n")
size=100
pop = top10$n_participants
# SRSWOR

s <- srswor(size, length(pop))
index = (1:length(pop))[s!=0]
index <- rep(index, s[s != 0])
sample.1 = pop[index]

# Append to the sampling tracker.
count = table(top10$category[index])
startData = mutate(startData, SRSWOR = count)

s5 = plot_ly(x=sample.1, type='histogram', name="SRSWOR Sample Method") %>%
  layout(xaxis=list(range=c(0,350)), yaxis=list(range=c(0,100), title="Frequency"),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>SRSWOR Sampling\nMean: : ", 
                                     round(mean(sample.1),2),
                                     "\nSD: ", round(sd(sample.1), 2))));
output2 = c(output2, paste0("SRSWOR  Mean = ", round(mean(sample.1),2)), 
           "  Actual SD = ", round(sd(sample.1),2), "\n\n")
 
# Systematic Sampling
n = size
k = ceiling(length(pop) / n)
r = sample(k, 1)
s <- seq(r, by = k, length = n)

# With systematic sampling, since we used the ceiling function to oversample based
# on the vector size, there is a chance of obtaining NA sample results.  For the
# purposes of this project, we will omit those values and adjust mean and SD
# calculations to the true sample vector size.
sample.2 = pop[s]
sample.2 = na.omit(sample.2)

temp = top10$category[s]
count = table(temp)/sum(table(temp))*100
startData = mutate(startData, Sys.Equal = count)

s6 = plot_ly(x=sample.2, type='histogram', name="Systematic Equal Sample Method") %>%
  layout(xaxis=list(range=c(0,350)), yaxis=list(range=c(0,100)),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Systematic Equal Sampling\nMean: ",
                                     round(mean(sample.2),2),
                                     "\nSD: ", round(sd(sample.2), 2)))); 
output2 = c(output2, paste0("Systematic Equal  Mean = ", round(mean(sample.2),2)), 
            "  Actual SD = ", round(sd(sample.2),2), "\n\n")

# Unequal Systematic Sampling (Inclusion Probability)

pik <- inclusionprobabilities(
  pop, size); 

s <- UPsystematic(pik)
sample.3 = pop[s!= 0]

count = table(top10$category[s!=0])
startData = mutate(startData, Incl.Prob = count)

s7 = plot_ly(x=sample.3, type='histogram', name="Systematic Unequal Sample Method") %>%
  layout(xaxis=list(range=c(0,350), title="Participant Count"),
         yaxis=list(range=c(0,100), title="Frequency"),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Systematic Unequal Sampling\nMean: ",
                                     round(mean(sample.3),2),
                                     "\nSD: ", round(sd(sample.3), 2)))); 
output2 = c(output2, paste0("Systematic Unequal  Mean = ", round(mean(sample.3),2)), 
            "  Actual SD = ", round(sd(sample.3),2), "\n\n")

# Stratified Sampling

tibble(top10) %>%
  select(category, n_participants) -> popSet2

discRank = 1:length(unique(popSet2$category))
discSort = rev(sort(table((popSet2$category))))
names(discRank) = names(discSort)
popSet2$rank = discRank[popSet2$category]
subSet = popSet2[order(popSet2$rank), ]
  
freq <- rev(sort(table((popSet2$category))))

st.sizes <- size * freq / sum(freq)

# The data was organized and ranked by the number of results with the 17
# distinct disciplines of events.  There was great disparity in results per
# discipline, such that some sample strata possessed over 100 entries and others
# had only 1.  To not get an empty strata error, i used the ceiling() function
# to guarantee I had minimum one value in the strata.  

st.2 <- strata(subSet, stratanames = c("category"),
               size = (st.sizes), method = "srswor",
               description = TRUE)

sample.4 <- getdata(subSet, st.2)$n_participants

count = table(getdata(subSet, st.2)$category)
startData = mutate(startData, Stratification = count)

s8 = plot_ly(x=sample.4, type='histogram', name="Stratified Sample Method") %>%
  layout(xaxis=list(range=c(0,350), title="Participant Count"),
         yaxis=list(range=c(0,100)),
         annotations=list(x=200, y=60, xref='x', yref='y', ax=0, ay=0,
                          text=paste("<b>Stratified Sampling\nMean: ", 
                                     round(mean(sample.4),2),
                                     "\nSD: ", round(sd(sample.4), 2)))); s7
output2 = c(output2, paste0("Stratified  Mean = ", round(mean(sample.4),2)), 
            "  Actual SD = ", round(sd(sample.4),2), "\n\n")

# Plot the results in a 2x2 grid using subplot(). 
subplot(s5, s6, s7, s8, nrows=2, shareX=F, shareY=T, titleX=T, titleY=T) %>%
  layout(title="Samples of Participants Per Event, 100 Samples", bargap=0.1,
         showlegend=F) 

# Display the size/mean/SD output.       
cat(output2)




