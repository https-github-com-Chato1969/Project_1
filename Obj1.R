---
  title: "exercise5"
author: "Wesley Newcomb"
date: "2023-03-16"
output:
  html_document:
  df_print: paged
---

### Objective 1

confirmed_df<-read.csv("data/time_series_covid19_confirmed_global.csv", 
                       header=TRUE, stringsAsFactors=FALSE)
deaths_df<-read.csv("data/time_series_covid19_deaths_global.csv", 
                    header=TRUE, stringsAsFactors=FALSE)
recovered_df<-read.csv("data/time_series_covid19_recovered_global.csv", 
                       header=TRUE, stringsAsFactors=FALSE)

## Confirmed Dataset
confirmed_ordered<-select(arrange(confirmed_df, -X1.22.20), 
                          Province.State, Country.Region, X1.22.20)
cat("Confirmed Dataset ")
head(confirmed_ordered)

## Deaths Dataset
death_ordered<-select(arrange(deaths_df, -X1.22.20), 
                      Province.State, Country.Region, X1.22.20)
cat("Deaths Dataset ")
head(death_ordered)

## Recovered Dataset
recovered_ordered<-select(arrange(recovered_df, -X1.22.20), 
                          Province.State, Country.Region, X1.22.20)
cat("Recovered Dataset \n")
head(recovered_ordered)

cat(confirmed_ordered[1,1], ", ", confirmed_ordered[1,2], 
    " has the most confirmed cases on the first day. \n", 
    death_ordered[1,1], ", ", death_ordered[1,2], 
    " has the most deaths from the virus on the first day. \n",
    recovered_ordered[1,1], ", ", recovered_ordered[1,2], 
    " has the most recovered cases from the virus on the first day. \n", 
    sep="")


if (confirmed_ordered[1,1] == death_ordered[1,1] && 
    confirmed_ordered[1,1] == recovered_ordered[1,1] && 
    death_ordered[1,1] == recovered_ordered[1,1])
{
  cat(confirmed_ordered[1,1], ", ", confirmed_ordered[1,2], 
      " is the most likely origin of the virus. \n", sep="")
}


