function [struct] = builddatastruct(H,V)
if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
end
    struct.V = V;     struct.H = H;
    [struct.E, struct.Eh] = hex2edge(H); %unique E, E wrt H  
    [struct.F, struct.Fh] = hex2face(H); %unique F, F wrt H 
    struct.nH = size(H,1);
    struct.nE = size(struct.Eh, 1);
    struct.nF = size(struct.Fh, 1);
end
   