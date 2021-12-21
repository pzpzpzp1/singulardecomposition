function [Hchord] = Hchord (data, visualize)
if nargin==0
    file_name = 'meshes\bunny.vtk';
%   file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    data = builddatastruct(H,V);
    visualize =1;
end
%setup
F = data.Fh; V = data.V; H = data.H; 
H1 = H(1,:); F12 = F(1,:);

%loop with condition
Hchord =[H1]; Fchord = [F12];
F2 = F(2,:); %chose randomly
while prod(sort(F(1,:))==sort(F2))==0 
H2 = hexface2hex(H1, F12, data, 0);
if numel(H2) == 0
    break
end
F2 = facehex2face(F12, H2, data, 0);
Fchord = [Fchord; F2];
Hchord = [Hchord; H2];
%reset
F12=F2; H1=H2;
end

%graph
%Vf = V(Fchord,:);
Vh = V(Hchord,:);
if visualize == 1
    figure; title('Hchord'); axis equal; hold all; rotate3d on;
    patch('Faces', F, 'Vertices', V, 'facecolor', 'blue', 'facealpha', 0.03);
    scatter3(Vh(:,1), Vh(:,2), Vh(:,3), 'red', 'filled');
    patch('Faces', Fchord, 'Vertices', V, 'facecolor', 'red', 'facealpha', 0.5);
end
end