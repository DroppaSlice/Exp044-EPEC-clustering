library(factoextra)
library(dplyr)
library(NbClust)
library(ggplot2)

#-----Reading in the two presence absence matrices that we made for the Pas genes and EPEC virulence genes-----#
#The two tables are then combined into a single data frame 'pa' that serves as the basis of our clustering analysis
vf_pa <- read.csv(file = "outputs/Exp044_presenceAbsence.csv") %>%
  rename(accession.no = X)
pas_pa <- read.csv(file = "doc/pas_presenceAbsence.csv")

#-----Reshaping the 'pa' dataframe-----#
#After reshaping, the pa dataframe should have only numerical values and the identifying accession number is stored as rownames
pa <- dplyr::left_join(pas_pa, vf_pa, by = "accession.no") %>%
  tibble::column_to_rownames("accession.no") %>%
  select(where(is.numeric))

#-----Scaling the dataframe into a numerical matrix-----#
scaled_df <- as.data.frame(na.omit(scale(t(pa))))
write.csv(x = scaled_df, file = "outputs/scaled_pa_table.csv")

#-----Plotting PCA to inspect clustering tendency-----#
fviz_pca_ind(prcomp(scaled_df), ggtheme = theme_bw()) 

#-----Running several clustering number optimization methods-----#
#Gap statistic
fviz_nbclust(scaled_df, kmeans, method="gap_stat")

#Silhouette method
fviz_nbclust(scaled_df, kmeans, method="silhouette")

#Calculating the Hopkins statistic
hopkins.res <- get_clust_tendency(data = scaled_df, n = 20)
hopkins.res$hopkins_stat