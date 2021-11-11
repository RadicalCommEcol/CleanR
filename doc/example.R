## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(cleanR)
dirty_data <- read.csv("../inst/extdata/dirty_data.csv", stringsAsFactors = FALSE)
example <- read.csv("../inst/extdata/template.csv")  
species_tesaurus <- read.csv("../inst/extdata/species_tesaurus.csv", sep = ";")

## -----------------------------------------------------------------------------
#To refresh the steps (and copy-paste the structure) I usually use:
help_structure()

#create template to check against
check <- define_template(example, species_tesaurus)

#Note: Use factors only for those variables you want to compare categories.
dirty_data$Country <- as.factor(dirty_data$Country)
dirty_data$Locality <- as.factor(dirty_data$Locality)
(comp <- compare_variables(check, dirty_data))

## -----------------------------------------------------------------------------
#Reference doi is misspelled
colnames(dirty_data)[which(colnames(dirty_data) == "Reference..doi.")] <- "Reference.doi"

#There is a O instead of 0
dirty_data$Worker[which(dirty_data$Worker == "O")] <- 0
dirty_data$Worker <- as.numeric(dirty_data$Worker)

#Males can't be -2
dirty_data$Male[which(dirty_data$Male < 0)] <- NA

#Fix misspelled Country and Locality
dirty_data$Country <- as.character(dirty_data$Country) #this is not elegant, fix.
dirty_data$Country <- ifelse(dirty_data$Country %in% as.character(comp$Country$to_fix), 
                             as.character(comp$Country$fixed), dirty_data$Country) #asuming you don't want France to be included.

dirty_data$Locality <- as.character(dirty_data$Locality) #this is not elegant.s
dirty_data$Locality <- ifelse(dirty_data$Locality ==
                                as.character(comp$Locality$to_fix),
                              as.character(comp$Locality$fixed), dirty_data$Locality)


## -----------------------------------------------------------------------------
#add missing variables
dirty_data <- add_missing_variables(check, dirty_data)

#recheck
compare_variables(check, dirty_data)

#drop_variables(check, dirty_data) I am not droping variables yet, as I'll need those.


## -----------------------------------------------------------------------------
#I never remember georeference functions, so I can ask for a tip
help_geo()
dirty_data$Latitude <- parzer::parse_lat(as.character(dirty_data$UTM.N))
dirty_data$Longitude <- parzer::parse_lat(as.character(dirty_data$UTM.S))

alternative <- mgrs::mgrs_to_latlng(as.character(dirty_data$MGRS))
#From here you can extract lat and long easily

#We may also be interested in geolocating some localities 
latlong <- geocode(unique(as.character(dirty_data$Locality)))
latlong ; unique(paste(dirty_data$Latitude, dirty_data$Longitude)) #not bad!
#From here you can extract lat and long easily

#and I also often forget about Date manipulation
help_date()
#When the date format is "easy" I have a wrapper

temp <- extract_date(dirty_data$Date, format = "%d-%m-%Y")
dirty_data$Year <- 2000+temp$year
dirty_data$Month <- temp$month
dirty_data$Day <- temp$day

#Another common task is cleaning or spliting species names with some heuristics:
help_species() #tipical useful functions

temp <- extract_pieces(dirty_data$Species, species = TRUE) #this may fail with more dirty data
#in this case strsplit() may also work.

#One Genus has the Subgenus attached in brackets
temp2 <- extract_pieces(dirty_data$Genus, pattern_ = " (", i = 2, f = 1) 
dirty_data$Subgenus <- temp2$piece2
dirty_data$Genus <- temp$piece2
dirty_data$Species <- temp$piece1

#finally we check again
compare_variables(check, dirty_data) #Note we have a year in 2029 which is not possible
dirty_data$Year[which(dirty_data$Year > 2019)] <- 2019

#Now we can drop variables
clean_data <- drop_variables(check, dirty_data)
#and add a unique id
clean_data <- add_uid(newdat = clean_data, "test")

head(clean_data)

## -----------------------------------------------------------------------------
#create a genus species column
clean_data$Gen_sp <- paste(trimws(clean_data$Genus),
                  trimws(clean_data$Species))
#use the check_sp function to compare with the thesaurus.
to_fix <- check_sp(check, clean_data$Genus, clean_data$Species, k = 2)
#We provide fuzzy matching for misspellings. The tolerance in the number of changes is set by the parameter k. k = 2 means two changes.
to_fix #Here we can accept the proposed fixes, as those makes sense.

#We add this columns, to preserve the original names. 
clean_data <- merge(clean_data, to_fix, by.x = "Gen_sp", by.y = "mismatches", all.x = TRUE)

#we can now create a final used_Gen_sp column and rename the original.
clean_data$used_Gen_sp <- ifelse(is.na(clean_data$fixed), clean_data$Gen_sp,
                                 clean_data$fixed)
clean_data$fixed <- NULL

#Note that columns Genus and Species have not been fixed, so we can do it now:
temp <- extract_pieces(clean_data$used_Gen_sp, species = TRUE) 
clean_data$Genus <- temp$piece2
clean_data$Species <- temp$piece1
colnames(clean_data)[which(colnames(clean_data) == "Gen_sp")] <- "original_Gen_sp"

head(clean_data)

## -----------------------------------------------------------------------------
#library(taxize)
species <- c("Osmia rufa", "Osmia bicornis", "Osmia ruffa",
            "Osmia wikifluqie", "watermelon pie", "Osmia sp.")
#clean_species(species) #This is slow


#You can also check 
#install.packages('traitdataform')
#get_gbif_taxonomy()

