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
    struct.nFu = size(struct.F, 1); 

    for i=1:struct.nFu
        [Ha1, Ha2] = face2hex(F(i,:),struct,0);
        Hadj = [Hadj;[Ha1,Ha2]];
    end
    %struct.adjH = face2hex(struct.F,H,0);   %given F, find the 2 adj.H

end
   