# Cluster finder
A cluster is defined as a subset of points where the distance between two neighboring points is less than a given threshold.

** INPUT: ** 
- Set of N points in 3D space. NX3 array
- 
** OUTPUT: **
- *clusters*: Cell with each cluster, each cluster being an array with the index of the points that make it up.
- *cluster_id*: An NX1 array mapping each point to the cluster index it belongs to.

## Example:
[clusters, cluster_id] = cluster_finder(points, threshold);
