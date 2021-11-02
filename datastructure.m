function datastructure(V,H)

if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
end
E = hex2edge(H);
F = hex2face(H);

nH = size(H,1);
nF = size(F,1);
nE = size(E,1);
nV = size(V,1);

hexface2hex(H);
function [H2] = hexface2hex(H1, F12, H)
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    H(Hi,:) = [];
    [~,H2] = ismember(sort(F12(:),2), sort(H,2), 'rows');
end
    
function [F23] = facehex2face(H2,F12)
    F = hex2face(H2);
    for i=1:6
    [Y,F2] = ismember(sort(F(i,:),2),sort(F12,2), 'rows');
    if Y=0
        F23=F2;
    end
    end
end


end