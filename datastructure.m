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

H1 = H(1,:);
F12 = F(1,:);
data= hexface2hex(H1, F12, H)

end