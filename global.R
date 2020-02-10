# convert matrix to dataframe
library(dplyr)

ted_df_original <- read.csv('ted2.csv', stringsAsFactors = T, header=T)
ted_df_original$Views_In_Millions= round(ted_df_original$views/1000000,2) #convert views to millions

ted_df = ted_df_original %>% 
  select(name, views, Views_In_Millions, num_ratings, ratings_per_view)

ted_df_bar= ted_df_original %>% 
  select(Views_In_Millions, views, num_ratings, ratings_per_view, event)

ted_theme <-read.csv('pop_theme.csv', stringsAsFactors = T, header=T)

#test code for bar chart reactive works with givis
temp <- ted_df_bar %>% select(event,Views_In_Millions) 
temp<-  temp %>% arrange(desc(Views_In_Millions))%>% 
head(10) %>% 
as.data.frame()

ted_df2= ted_df_original %>% 
  select(name, Funny, Courageous, Jaw.dropping, Longwinded, Unconvincing, Obnoxious, event, film_year) 

ted_df_display= ted_df_original %>% 
  select(name, views, num_ratings, ratings_per_view, Funny, Courageous, Jaw.dropping, Longwinded, Unconvincing, Obnoxious, event, film_year, speaker_occupation)

# remove row names
#rownames(ted_df) <- NULL

# create variable with colnames as choice
choice <- colnames(ted_df)[2:5]
choice2 <- colnames(ted_df2)[2:6]



#Bar <- gvisBarChart(temp)
#plot(Bar)


