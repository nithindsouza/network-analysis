import pandas as pd

c_routes = pd.read_csv("C:/Users/hp/Desktop/network assi/connecting_routes.csv")
c_routes.drop(c_routes.columns[6] , axis =1, inplace=True)
c_routes.columns = ["flights", "ID", "main Airport", "main Airport ID", "Destination","Destination  ID","haults","machinary"]

f_hault = pd.read_csv("C:/Users/hp/Desktop/network assi/flight_hault.csv")
f_hault.columns = ["ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time"]

import networkx as nx
graph = nx.from_pandas_edgelist(c_routes, source = 'main Airport', target = 'Destination')

#printing the graph
pos = nx.spring_layout(graph, k = 0.15)
nx.draw_networkx(graph, pos, node_size = 15, node_color = 'red')

degree = nx.degree_centrality(graph)  # Degree Centrality
print(degree)
#finding most central airport (airport having max in_out)
max_degree = max(degree)
max_degree_index = f_hault.index[f_hault['IATA_FAA'] == max_degree]
f_hault.iloc[max_degree_index]

# closeness centrality
closeness = nx.closeness_centrality(graph)
print(closeness)
# Which airport is close to most of the airports (in terms of number of flights)
max_closeness = max(closeness)
max_closeness_index = f_hault.index[f_hault['IATA_FAA'] == max_closeness]
f_hault.iloc[max_closeness_index]

## Betweeness Centrality 
betweeness = nx.betweenness_centrality(graph) # Betweeness_Centrality
print(betweeness)
# Which airport comes in between most of the routes and hence is an important 
#international hub?
max_betweeness = max(betweeness)
max_betweeness_index = f_hault.index[f_hault['IATA_FAA'] == max_betweeness]
f_hault.iloc[max_betweeness_index]

## Eigen-Vector Centrality
eigen_centrality = nx.eigenvector_centrality(graph) # Eigen vector centrality
print(eigen_centrality)
#which airport is most potential and have more in and outs
max_eigen_centrality = max(eigen_centrality)
max_eigen_centrality_index = f_hault.index[f_hault['IATA_FAA'] == max_eigen_centrality]
f_hault.iloc[max_eigen_centrality_index]

##############################################END####################################
