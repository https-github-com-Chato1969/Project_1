library(ggplot2)

starwars <- as.data.frame(dplyr::starwars)

### Single variable plots
#   Histograms
ggplot(starwars) + 
  geom_histogram(mapping = aes(x = birth_year), 
                 na.rm = TRUE, binwidth = 10, fill = blue, color = lightblue3) + 
  labs(title = "Histogram of age distributions for starwars characters", 
       x = "Age (years)",
       y = "Counts")

#   Box plots
ggplot(starwars[starwars$gender != "none" & !is.na(starwars$gender),]) +
  geom_boxplot(aes(x = gender, y = height), 
               color = blue,
               na.rm = TRUE) + 
  labs(title = "Boxplot of height distributions for different gendered starwars characters",
       x = "Gender", 
       y = "Height")

#   Violin plots
ggplot(starwars[starwars$gender != "none" & !is.na(starwars$gender),]) +
  geom_violin(aes(x = gender, y = height), 
              fill = blue, 
              na.rm = TRUE) + 
  labs(title = "Violin plot of height distributions for different gendered starwars characters",
       x = "Gender", 
       y = "Height")

### Multiple variables
##  Proportional representations
# Pie chart
ggplot(starwars) +
  geom_bar(aes(x = "", y = gender, color = gender, fill = gender), 
           na.rm = TRUE, 
           stat = "identity", 
           width = 1) +
  coord_polar("y", start=0) + 
  labs(title = "Pie chart of different starwars genders",
       x = "", 
       y = "Gender")


## Scatter plot
ggplot(starwars) +
  geom_point(mapping = aes(x = height, y = mass), 
             na.rm = TRUE) + 
  labs(title = "Scatter plot of height vs mass", 
       x = "Height", 
       y = "Mass")

## Filtered scatter plot
ggplot(starwars[-which.max(starwars$mass),]) +
  geom_point(mapping = aes(x = height, y = mass), 
             na.rm = TRUE) +
  labs(title = "Scatter plot of height vs mass", 
       x = "Height", 
       y = "Mass")

