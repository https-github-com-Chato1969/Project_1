---
  title: "exercise5"
author: "Wesley Newcomb"
date: "2023-03-16"
output:
  html_document:
  df_print: paged
---

  ### Objective 3
  
  origin_df<-arrange(confirmed_df, -X1.22.20)[1,]
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

# Compute distances from origin
distances<-distm(select(recent_df, Long, Lat), select(origin_df, Long, Lat))

# Convert from m to miles
distances<-distances * 0.00062137

# Add distance from origin to dataframe and sort by distance
recent_df$distance<-distances[,1]
recent_df<-arrange(recent_df, distance)

head(select(recent_df, Province.State, Country.Region, Lat, Long, distance))

# Vector is small enough that loop is reasonable
for (i in 1:nrow(recent_df)) {
  city<-recent_df[i, "Province.State"]
  
  # If there is no city use country
  if (city == "") {
    city<-recent_df[i, "Country.Region"]
  }
  
  cat(city, "is", recent_df[i, "distance"], 
      "miles away from the virus origin in", 
      paste0(origin_df[1, "Province.State"], ","), 
      paste0(origin_df[1, "Country.Region"], "."), "\n")
}
