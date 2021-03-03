###############################Problem 1#################################################
# There are two dataset consists of information for the connecting routes and 
# flight hault. Create network analytics model on both the datasets separately 
# and measure degree Centrality, degree of closeness centrality and degree of 
# in-between centrality respectively.
# 
# *important note 
# 
# •	Perform both R and python code for the above problem
# •	Create network using edge list matrix: directed only
# •	Columns to be used in R:
#   
#   Flight_hault=c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
#   
#   connecting routes=c("flights", " ID", "main Airport”, “main Airport ID", "Destination ","Destination  ID","haults","machinary")
#   
#loading the dataset
install.packages("readr")
library(readr)
c_routes <- read.csv("C:\\Users\\hp\\Desktop\\network assi\\connecting_routes.csv" , header = FALSE)
#subsetting the dataset
c_routes <- c_routes[,c(1:6,8,9)]
#renaming column as given in question
colnames(c_routes) <-c("flights", " ID", "main Airport", "main Airport ID", "Destination ","Destination  ID","haults","machinary")

#loading one more DS and renaming its column
f_hault <- read.csv("C:\\Users\\hp\\Desktop\\network assi\\flight_hault.csv" , header = FALSE)
colnames(f_hault) <- c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")

#calling required package
install.packages("igraph")
library(igraph)

#creating a E,V graph data for source and dest. as directed graph
airline <- graph.edgelist(as.matrix(c_routes[, c(3, 5)]), directed = TRUE)

#ploting the graph
plot(airline)

#airport counts
vcount(airline) #3425

#routes count
ecount(airline) #67662

#measure of degree centrality
#finding in-degree of node(airports)
incoming <- degree(airline , mode = "in")

#finding max no. of incoming for a airport
max(incoming)   #911
#finding index of max incoming
air_index <- which(incoming == max(incoming))
#finding airport name of max incoming
incoming[air_index] #ATL 911
#airport details
which(f_hault$IATA_FAA == "ATL")#3584
f_hault[3584, ]

#finding out-degree of node(airports)
outgoing <- degree(airline , mode = "out")

#finding max no. of outgoing for a airport
max(outgoing)   #915
#finding index of max outgoing
air_index2 <- which(outgoing == max(outgoing))
#finding airport name of max outgoing
outgoing[air_index2] #ATL 915
#airport details
which(f_hault$IATA_FAA == "ATL")#3584
f_hault[3584, ]

#degree of closeness centrality
# Which airport is close to most of the airports (in terms of number of flights)
closeness_in <- closeness(airline, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(f_hault$IATA_FAA == "FRA")
f_hault[338, ]

#degree of in-between centrality
# Which airport comes in between most of the routes and hence is an important international hub?
btwn <- betweenness(airline, normalized = TRUE)
max(btwn)
index2 <- which(btwn == max(btwn))
btwn[index2]
which(f_hault$IATA_FAA == "LAX")
f_hault[3386,]

# Degree, closeness, and betweenness centralities together
centralities <- cbind(incoming, outgoing, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)


##########################Problem 2#####################################
# Problem statement
# There are three datasets given such as Facebook, Instagram and LinkedIn. 
# Construct and visualize the following networks:
#   •	circular network for Facebook
# •	star network for Instagram
# •	star network for LinkedIn
# 
# *important note
# 
# Perform R code only for the below Facebook, Instagram and Linked datasets
# create a network using adjacency matrix: undirected only

library(readr)
library(igraph)

instagram <- read.csv("C:\\Users\\hp\\Desktop\\network assi\\instagram.csv" , header = TRUE)
facebook <- read.csv("C:\\Users\\hp\\Desktop\\network assi\\facebook.csv" , header = TRUE)
Linkedin <- read.csv("C:\\Users\\hp\\Desktop\\network assi\\linkedin.csv" , header = TRUE)

# creating newtwork using adjacency matrix and plotting them
instagram_adj <- graph.adjacency(as.matrix(instagram), mode = "undirected")
plot(instagram_adj)

facebook_adj <- graph.adjacency(as.matrix(facebook), mode = "undirected")
plot(facebook_adj)

Linkedin_adj <- graph.adjacency(as.matrix(Linkedin), mode = "undirected")
plot(Linkedin_adj)

# creating circular newtwork for facebook using adjacency matrix and plotting
Circular_FB <- graph.adjacency(as.matrix(facebook), mode="undirected", weighted=TRUE)
plot(Circular_FB)

# creating star newtwork for instagram using adjacency matrix and plotting
Star_IG <- graph.adjacency(as.matrix(instagram), mode="undirected", weighted=TRUE)
plot(Star_IG)

# creating star newtwork for LinkedIn using adjacency matrix and plotting
Star_LI <- graph.adjacency(as.matrix(Linkedin), mode="undirected", weighted=TRUE)
plot(Star_LI)

#########################################END############################################











