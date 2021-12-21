function [H1, H2] = face2hex (F,H,visualize)

%find 2 adjancent hex given a face
if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    [F,~] = hex2face(H);
    F1 = F(1,:);
    visualize =1;
end
H1 = H - F1(1); H2 = H - F1(2);
H3 = H - F1(3); H4 = H - F1(4);
sumprod = prod(H1,2)+prod(H2,2)+prod(H3,2)+prod(H4,2);
I = find(sumprod == 0, 2) %index of the adj. H in H
H1 = H(I(1),:);
H2 = H(I(2),:);

%graph
Vh1 = V(H1,:); Vh2 = V(H2,:);
if visualize == 1
    figure; title('face2hex'); axis equal; hold all; rotate3d on;
    patch('Faces', F, 'Vertices', V, 'facecolor', 'blue', 'facealpha', 0.05);
    scatter3(Vh1(:,1), Vh1(:,2), Vh1(:,3), 'b', 'filled');
    patch('Faces', F1, 'Vertices', V, 'facecolor', 'green', 'facealpha', 0.1);
    scatter3(Vh2(:,1), Vh2(:,2), Vh2(:,3), 'b', 'filled');
end
end