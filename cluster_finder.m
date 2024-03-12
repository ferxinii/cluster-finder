
function [clusters_total, cluster_id] = cluster_finder(points, threshold)
% Finds clusters given a set of 3D points and a threshold distance
    len = length(points); 
    
    cluster_id = (-1) * ones(len, 1);  
    % where each point belongs, -1 not identified
    
    clusters_total = {}; 
    kk = 1;  % cluster counter 
    for ii = 1:len
    % If point not identified, start new cluster 
    if cluster_id(ii) == -1 
        cluster_id(ii) = kk;
        
        cluster = ii;  % array containing the indexes of the points of cluster 
        neighbors = cluster; 
        while ~isempty(neighbors) 
            [neighbors, cluster_id] = find_unidentified_neighbors(points, cluster_id, cluster, kk, threshold);
            cluster = [cluster, neighbors]; 
        end
        
        clusters_total{kk} = cluster; 
        kk = kk+1; 
    end
    disp(ii/len*100 + " %"); 
    end
    
    clusters_total = clusters_total' ; 
end


% AUXILIARY FUNCTION TO IDENTIFY NEIGHBORS
function [neighbors, cluster_id] = find_unidentified_neighbors(points, ...
                                    cluster_id, cluster, kk, threshold)
% AUXILIARY, Finds neighbors of a set of points that have not been identified
    neighbors = [];
    for ii = 1:length(cluster) 
        % Distance of point in cluster to all other points:
        distance = sqrt(sum((points - points(cluster(ii), :)).^2, 2)); 
        
        % Determine index of neighbor points:
        neighbors_id = find( distance <= threshold & distance ~= 0 );
        
        % Remove points already identified:
        neighbors_id = neighbors_id(cluster_id(neighbors_id) == -1);
        
        % Save neighbors and mark in cluster_id
        cluster_id(neighbors_id) = kk;
        neighbors = [neighbors, neighbors_id'];
    end
end
