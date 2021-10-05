function [Vsd,Hsd]= subdiv(V,H) 
% input hex output a divided hex
%V: m*3; H: n*8 helper fcn 1; Hsd: 8*n*8
%turns one unit to two units

if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
end

%m*3 -> 8*n*3 vertex resize it
%loop through it function [Vsd,Hsd]= subdiv(V,H) 
% input singular certex  output singular curves
%V: m*3; H: n*8 helper fcn 1; Hsd: 8*n*8
%turns one unit to two units


E = hex2edge(H); %sth*2
F = hex2face(H);
% - Record sizes of mesh
nV = size(V, 1);
nH = size(H, 1);
nE = size(E, 1);
nF = size(F, 1);
%div %division length 1 to 0.5

% Approach 1: change the scale of V from m*3 -> 8*n*3, then loop through it 
% Fmat = sparse(repmat(1:nF,1,4),F,F*0+1,nF,nV);
% Fmatselector = sparse(1:(4*nF), F', F*0+1, 4*nF, nV);
% dat.H = H; 
% dat.F = F;
% dat.Fmat = Fmat;
% dat.Fmatselector = Fmatselector;


%Approach 2: generate all the vertex points then reorder them
Vne = []; %the new middle vertex of each edge (12 added)
Vnf = []; %the new middle vertex of each face (6 added)
Vnh = []; %the new middle vertex of each hex (1 added)
for i= 1:nE
    Vne =[Vne; (V(E(i,1),:)+V(E(i,2),:))/2];
end
for i = 1:nF
    Vnf =[Vnf; (V(F(i,1),:)+V(F(i,2),:)+V(F(i,3),:)+V(F(i,4),:))/4];
end
for i = 1:nH
    Vnh =[Vnh; (V(H(i,1),:)+V(H(i,2),:)+V(H(i,3),:)+V(H(i,4),:)...
            +V(H(i,5),:)+V(H(i,6),:)+V(H(i,7),:)+V(H(i,8),:))/8];
end

%build the V list
Vsd = [V; Vnh; Vnf; Vne];
%%% build the H list %%%
%we want to loop through the corner of the hex. note that we only need one
%example because the order is fixed
%V1 is given, V7 is from all the vertex in the hex
%V2, V4, V5 are from the edges
%V3, V6, V8 are from the faces
I = [1,2,4,5,3,8,6,7;
    2,6,3,1,7,4,5,8;
    3,4,2,7,1,6,8,5;
    4,8,1,3,7,5,2,6;
    5,1,8,6,4,7,2,3;
    6,5,7,1,8,4,2,3;
    7,3,6,8,2,5,4,1;
    8,7,5,4,6,1,3,2];

for i=1:8
    [~,V2] = ismember(sort([H(I(i,1)), H(I(i,2))],2), E, 'rows');
    [~,V4] = ismember(sort([H(I(i,1)), H(I(i,3))],2), E, 'rows');
    [~,V5] = ismember(sort([H(I(i,1)), H(I(i,4))],2), E, 'rows');
    [~,V8] = ismember(sort([H(I(i,1)), H(I(i,3)),H(I(i,4)), H(I(i,6))],4), F, 'rows');
    [~,V3] = ismember(sort([H(I(i,1)), H(I(i,2)),H(I(i,3)), H(I(i,5))],4), F, 'rows');
    [~,V6] = ismember(sort([H(I(i,1)), H(I(i,2)),H(I(i,7)), H(I(i,4))],4), F, 'rows');
end
   
V1 = [1:nV]';

%hex list
H = [V1, Vnh_I, vedge, vface]; %1,1,3,3
%reorder hex list to make it correct
Hsd = [H(:,1), H(:,3), H(:,4), H(:,5), H(:,6), H(:,7), H(:,2), H(:,8)]; 
end