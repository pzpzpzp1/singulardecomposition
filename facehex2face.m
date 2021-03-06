function [F2] = facehex2face(F1, H2, data, visualize)
 if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    data = builddatastruct(H,V); F = data.Fh; V=data.V;
    %setup condition
    H2 = H(4,:);  F1 = F(1,:);
    visualize =1;
 end
    %setup 
    V=data.V; F = data.Fh; H = data.H;
    %get F2
    F2 = setdiff(H2, F1); %ordering might be wrong
    [~,IF2] = ismember(sort(F2,2), sort(F,2), 'rows');
    F2 = F(IF2,:); % output the 4 vertex of F2

    %graph
    Vh2 = V(H2,:);
    if visualize == 1
        figure; title('facehex2face'); axis equal; hold all; rotate3d on;
        patch('Faces', F, 'Vertices', V, 'facecolor', 'blue', 'facealpha', 0.1);
        scatter3(Vh2(:,1), Vh2(:,2), Vh2(:,3), 'b', 'filled');
        patch('Faces', F2, 'Vertices', V, 'facecolor', 'green', 'facealpha', 0.1);
        patch('Faces', F1, 'Vertices', V, 'facecolor', 'red', 'facealpha', 0.1);
    end
end
