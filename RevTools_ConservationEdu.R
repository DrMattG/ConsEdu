library(revtools)
data <- read_bibliography("scopus.bib") #bib file from a scopus search 
#TITLE-ABS-KEY ( terrestrial  OR  large  AND carnivores  OR  human  AND wildlife  AND conflict  AND  education )  
# 53 documents


#we can merge different searches together (save them to .bib format or to .ris format)
#data_all <- rbind(data1, data2)

#here we look for duplicates (there should be none as this is a single search....)
matches <- find_duplicates(
  data = data,
  match_variable = "title",
  group_variable = NULL,
  match_function = "fuzzdist",
  method = "fuzz_partial_ratio",
  threshold = 0
)
matches # but strangly there are some! 
data_unique <- extract_unique_references(data, matches)# this is a quick way of removing duplicates but we should really check them
dim(data_unique) # from 53 we go down to 40 articles

screen_duplicates(data) # this file is screened in a shinyapp and the data saved as a csv called final_set.
###########################################################################################################
######screening abstracts (we can do this once we get the full search from GS or other database)###########
###########################################################################################################

final_data<-read.csv("final_set.csv")

#Topic model
screen_topics(final_data) #LDA with 5 Topics 

