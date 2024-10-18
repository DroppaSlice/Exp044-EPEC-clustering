library(factoextra)
library(ggsci)

#-----Reading in scaled pa table from the chunk Exp044-3-----#
scaled_df <- read.csv(file = "outputs/scaled_pa_table.csv", row.names = 1)

#-----Defining function plot.kmeans()-----#
plot.kmeans <- function(data, nclust, title = "K-means clustering"){
  res <- hkmeans(data, k = nclust)
  plot <- fviz_cluster(res,
                       data = data,
                       ggtheme = theme_bw(),
                       ellipse = T,
                       repel = T,
                       shape = 16) +
    scale_color_nejm() +
    scale_fill_nejm() + 
    ggtitle(title)
  
  plot
}

#-----Plotting kmeans clusters based on two separate optimal cluster numbers, i.e. 4 and 7-----#
#Define a vector to iterate over with the cluster number
opt_clusters <- c(4,7)

#Initialize a list and iterator i to store the results
cluster.res <- list()
i <- 1

#Plot multiple cluster numbers using a for loop
for(n in opt_clusters){
  cluster.res[[i]] <- plot.kmeans(data = scaled_df,
                                  nclust = n,
                                  title = paste("K-means clustering with", n, "clusters"))
  cluster.res[[i+1]] <- hkmeans(x = scaled_df, k = n)
  i <- i + 2
}

#-----Returning list of cluster plots and saving clustering results-----#
cluster.res
write.csv(x = cluster.res[[2]]$cluster, file = "outputs/hkmeans_clustering_res_k4.csv")
write.csv(x = cluster.res[[4]]$cluster, file = "outputs/hkmeans_clustering_res_k7.csv")