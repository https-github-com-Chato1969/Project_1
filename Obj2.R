---
  title: "exercise5"
author: "Wesley Newcomb"
date: "2023-03-16"
output:
  html_document:
  df_print: paged
---

### Objective 2 

  confirmed_df<-read.csv("data/time_series_covid19_confirmed_global.csv", 
                         header=TRUE, stringsAsFactors=FALSE)
recent_df<-arrange(confirmed_df[confirmed_df[,ncol(confirmed_df)-1] == 0 
                                & confirmed_df[,ncol(confirmed_df)] > 0,])

i<-0
# If there are no new cases today loop back to find most recent region
# to have new cases
if (nrow(recent_df) == 0) {
  while (nrow(recent_df) == 0) {
    i<-i+1
    recent_df<-arrange(confirmed_df[confirmed_df[,ncol(confirmed_df)-1-i] == 0 
                                    & confirmed_df[,ncol(confirmed_df)-i] > 0,])
  }
}

head(select(recent_df, Province.State, Country.Region, ncol(confirmed_df)-1-i, 
            ncol(confirmed_df)-i))

# Vector is small enough that loop is reasonable
for(i in 1:nrow(recent_df))
{
  if (recent_df[i,1] == "") {
    cat(recent_df[i,2], "has recently had their first confirmed case. \n")
  } else {
    if (recent_df[i,2] == "") {
      cat(recent_df[i,1], "has recently had their first confirmed case. \n")
    } else {
      cat(recent_df[i,1], ", ", recent_df[i,2], 
          " has recently had their first confirmed case. \n", sep="")
    }
  }
}
