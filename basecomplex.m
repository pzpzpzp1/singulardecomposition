function [Vbc, Hbc] = basecomplex(V,H)

if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
end
%consider the face list
E = hex2edge(H); %sth*2
F = hex2face(H);
% - Record sizes of mesh
nV = size(V, 1);
nH = size(H, 1);
nE = size(E, 1);
nF = size(F,1);

%Approach: if the face is an interior face, delete all points, then
%we're done.
%If the faces are adjacent to 1 hex, boundary
%if they are adjacent to 2 hexes, interior. 
Fb =[];  %boundary
Fi =[];  %interior
for j=1:nH
    for i=1:nF
        [a,~] = ismember(F(i,:), sort(H(j,:),8),'rows'); 
        [b,~] = ismember(F(i,:), sort(H(j,:),8),'rows'); %want to change this
        if a == 1 && b == 1
            Fb = [Fb; F(i,:)];
        else
            Fi = [Fi; F(i,:)];
            F = [F((1,:):(i-1,:)),F((i,:):(i-1,:))
        end
    end
end

%extract the vertices from Fi


        
end


end