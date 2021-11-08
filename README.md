# CleanR

I am tired to clean decent size datasets of species occurrences. Here there are some heuristics. 

1) Have a reference list of accepted names: `species_tesaurus`
2) Start by triming whitespaces e.g. `data$Genus <- trimws(data$Genus)` and other heuristics like "sp." etc...
3) Subset only mismatches with the reference list. e.g.
`mis <- data$Genus_species[which(!data$Genus_species %in% Genus_species)]`
`mismatches <- unique(mis)`
4) You can try fuzzy matching too to select mismatches. 
ALWAYS SAVE BOTH THE ORIGINAL NAME AND THE NEW MATCHED NAMES IN DIFFERENT COLUMNS
5) Use taxize for the mismatched species and check for synonyms, etc...
6) Keep original, and fixed names, and do manually the species groups, etc...

# A worked example in vignettes.


