import pandas as pd
import networkx as nx

connecting_routes = pd.read_csv("C:/Users/usach/Desktop/network analytics/connecting_routes.csv")
connecting_routes.drop(connecting_routes.columns[6] , axis =1, inplace=True)
connecting_routes.columns = ["flights", "ID", "main Airport", "main Airport ID", "Destination","Destination  ID","haults","machinary"]

flight_hault = pd.read_csv("C:/Users/usach/Desktop/network analytics/flight_hault.csv")
flight_hault.columns = ["ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time"]

graph = nx.from_pandas_edgelist(connecting_routes, source = 'main Airport', target = 'Destination')

pos = nx.spring_layout(graph, k = 0.15)
nx.draw_networkx(graph, pos, node_size = 15, node_color = 'red')

 # Degree Centrality
degree = nx.degree_centrality(graph)  
print(degree)
#finding most central airport (airport having max in_out)
max_degree = max(degree)
max_degree_index = flight_hault.index[flight_hault['IATA_FAA'] == max_degree]
flight_hault.iloc[max_degree_index]

# closeness centrality
closeness = nx.closeness_centrality(graph)
print(closeness)
# Which airport is close to most of the airports (in terms of number of flights)
max_closeness = max(closeness)
max_closeness_index = flight_hault.index[flight_hault['IATA_FAA'] == max_closeness]
flight_hault.iloc[max_closeness_index]

## Betweeness Centrality 
betweeness = nx.betweenness_centrality(graph) # Which airport comes in between most of the routes and hence is an important 
#international hub?
max_betweeness = max(betweeness)
max_betweeness_index = flight_hault.index[flight_hault['IATA_FAA'] == max_betweeness]
flight_hault.iloc[max_betweeness_index]

## Eigen-Vector Centrality
eigen_centrality = nx.eigenvector_centrality(graph) 
print(eigen_centrality)
#which airport is most potential and have more in and outs
max_eigen_centrality = max(eigen_centrality)
max_eigen_centrality_index = flight_hault.index[flight_hault['IATA_FAA'] == max_eigen_centrality]
flight_hault.iloc[max_eigen_centrality_index]

