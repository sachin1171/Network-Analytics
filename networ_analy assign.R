############################ Problem 1 ##############################
#There are two dataset consists of information for the connecting routes and flight
#hault. Create network analytics model on both the datasets separately and measure 
#degree Centrality, degree of closeness centrality and degree of in-between centrality respectively.

install.packages("igraph")
library(igraph)

flight_hault <- read.csv("F:\\assignment\\network analytics\\Datasets_Network Analytics\\flight_hault.csv", header = FALSE)
colnames(flight_hault)<-c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
head(flight_hault)

Connecting_routes <- read.csv("F:\\assignment\\network analytics\\Datasets_Network Analytics\\connecting_routes.csv",header = FALSE)
Connecting_routes <- Connecting_routes[,c(1:6,8,9)]
colnames(Connecting_routes) <- c("flights", " ID", "main Airport", "main Airport ID", "Destination ","Destination  ID","haults","machinary")                              
head(Connecting_routes)

#creating a E,V graph data for source and dest. as directed graph
flight_new <- graph.edgelist(as.matrix(Connecting_routes[,c(3,5)]),directed = TRUE)

#ploting the graph
plot(flight_new)

#airport counts
vcount(flight_new)

#routes count
ecount(flight_new)


#measure of degree centrality
#finding in-degree of node(airports)
incoming <- degree(flight_new, mode = "in")

#finding max no. of incoming for a airport
max(incoming)

#finding index of max incoming
fligth_index <- which(incoming==max(incoming))
#finding airport name of max incoming
incoming[flight_index]
#airport details
which(f_hault$IATA_FAA == "ATL")#3584
f_hault[3584, ]

#finding out-degree of node(airports)
outgoing <- degree(flight_new , mode = "out")

#finding max no. of outgoing for a airport
max(outgoing)   #915
#finding index of max outgoing
flight_index2 <- which(outgoing == max(outgoing))
#finding airport name of max outgoing
outgoing[flight_index2] #ATL 915
#airport details

which(flight_hault$IATA_FAA == "ATL")#3584
flight_hault[3584, ]

#degree of closeness centrality
# Which airport is close to most of the airports (in terms of number of flights)
closeness_in <- closeness(flight_new, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(flight_hault$IATA_FAA == "FRA")
f_hault[338, ]

#degree of in-between centrality
# Which airport comes in between most of the routes and hence is an important international hub?
btwn <- betweenness(flight_new, normalized = TRUE)
max(btwn)
index2 <- which(btwn == max(btwn))
btwn[index2]
which(flight_hault$IATA_FAA == "LAX")
f_hault[3386,]

# Degree, closeness, and betweenness centralities together
centralities <- cbind(incoming, outgoing, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)


################################# Problem 2 ################################
#There are three datasets given such as Facebook, Instagram and LinkedIn. Construct and visualize the following networks:
# .	circular network for Facebook
#.	star network for Instagram
#.	star network for LinkedIn


library(readr)
library(igraph)

instagram <- read.csv("F:\\assignment\\network analytics\\Datasets_Network Analytics\\instagram.csv" , header = TRUE)
facebook <- read.csv("F:\\assignment\\network analytics\\Datasets_Network Analytics\\facebook.csv" , header = TRUE)
Linkedin <- read.csv("F:\\assignment\\network analytics\\Datasets_Network Analytics\\linkedin.csv" , header = TRUE)

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
