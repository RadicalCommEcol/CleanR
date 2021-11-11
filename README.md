# CleanR

*Hell is other people data*

As I need to unify and compile large datasets coming from different people, I want to share the lessons learned, and some self-made code to help on the process. Here there are some heuristics.   

- Start by creating a template on how your data should look like. Define accepted categories for factors and possible values for numeric variables. Next, compare if your dirty dataset fulfill the categories accepted, and values are within the expected range.   
- Continue by harmonizing column names, order and units. R has several convenient functions to transform Latitudes and longitudes, as well as dates.  

- Finally, check species names for errors and misspellings. The fastest way for me is to:

1) Have a reference list of accepted names: `species_tesaurus`  
2) Start by triming whitespaces e.g. `data$Genus <- trimws(data$Genus)` and other heuristics like "sp." etc...  
3) Subset only mismatches with the reference list. e.g.  
`mis <- data$Genus_species[which(!data$Genus_species %in% species_tesaurus$Genus_species)]`
`mismatches <- unique(mis)`  
4) You can try fuzzy matching to fix mismatches.     
5) Always save both the original and the new fixed names in different columns.  
5) Use taxize for the mismatched species and check for synonyms, etc...  

# A worked example in the vignette:

I coded a bunch of functions to make this process efficient. Those are in most cases wrappers to existing functions that help my workflows. I use base R (no tydiverse here) because this is what I am more familiar with. I know there are better functions out there to work with e.g. dates, but I would need to re-learn those. 

A guided example in https://github.com/RadicalCommEcol/CleanR/blob/main/vignettes/example.Rmd (the help files are not developed yet, as this is work in progress)

Package can be installed at 

`devtools::install_github("RadicalCommEcol/CleanR")`



