---
  title: "exercise5"
author: "Wesley Newcomb"
date: "2023-03-16"
output:
  html_document:
  df_print: paged
---
  
  ### Objective 4.1 
  
  # Datasets respresent a cumlative sum by date, so last column represents 
  # summation for region
  confirmed_df<-read.csv("data/time_series_covid19_confirmed_global.csv", 
                         header=TRUE, stringsAsFactors=FALSE)
confirmed_df<-select(confirmed_df, Province.State, 
                     Country.Region, ncol(confirmed_df))
names(confirmed_df)[3] <- "confirmed"
deaths_df<-read.csv("data/time_series_covid19_deaths_global.csv", 
                    header=TRUE, stringsAsFactors=FALSE)
deaths_df<-select(deaths_df, Province.State, 
                  Country.Region, ncol(deaths_df))
names(deaths_df)[3] <- "deaths"
recovered_df<-read.csv("data/time_series_covid19_recovered_global.csv", 
                       header=TRUE, stringsAsFactors=FALSE)
recovered_df<-select(recovered_df, Province.State, 
                     Country.Region, ncol(recovered_df))
names(recovered_df)[3] <- "recovered"

# Combine the datasets into one and fill NA with 0
combined_df<-full_join(confirmed_df, recovered_df, 
                       by=c("Province.State", "Country.Region"))
combined_df<-full_join(combined_df, deaths_df, 
                       by=c("Province.State", "Country.Region"))
combined_df[is.na(combined_df)] <- 0

# Assignment is unclear if we are to consider state and region or 
# just region. Based on how data is formatted, I think it is cleaner 
# and makes more sence to use region only.  For instance, in confirmed 
# dataset, Canada is broken up by region, but in recovered dataset it 
# uses Canada as a whole.  There are numerous examples of this in
# the data
grouped_df<-as.data.frame(summarise_each(group_by(
  select(combined_df, -Province.State), Country.Region), sum))

# Compute risk and burden by region
grouped_df$risk<-grouped_df$deaths / grouped_df$recovered
grouped_df$burden<-grouped_df$confirmed * grouped_df$risk

cat("Highest risk scores ")
head(arrange(grouped_df, -risk, -confirmed))
cat("Highest risk scores, that are not infinite ")
head(arrange(grouped_df[grouped_df$risk != Inf,], -risk, -confirmed))
cat("Lowest Risk Scores ")
head(arrange(grouped_df, risk, confirmed))
cat("Lowest risk scores, that are not zero ")
head(arrange(grouped_df[grouped_df$risk != 0,], risk, confirmed))

global_confirmed<-sum(grouped_df$confirmed)
global_deaths<-sum(grouped_df$deaths)
global_recovered<-sum(grouped_df$recovered)
global_risk<-global_deaths / global_recovered
global_burden<-global_confirmed * global_risk

cat("Global Data\n", 
    "Confirmed:", global_confirmed, "\n", 
    "Deaths:   ", global_deaths, "\n",
    "Recovered:", global_recovered, "\n",
    "Risk:     ", global_risk, "\n",
    "Burden:   ", global_burden, "\n")
