function O = object(V,H)

if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
end
E = hex2edge(H); 
F = hex2face(H);
nF = size(F, 1);
%list of hex with edges and faces
HE = [H;F;E];
%list of face with edges
Fe = fece2edge(F);


%list of vertices one vertex is adjacent to
O = [HE;Fe];