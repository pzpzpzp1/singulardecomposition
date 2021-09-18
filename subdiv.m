function [Vsd,Hsd]= subdiv(V,H) 
% input singular certex  output singular curves
%V: m*3; H: n*8 helper fcn 1; Hsd: 8*n*8
%turns one unit to two units


E = hex2edge(H); %sth*2
% - Record sizes of mesh
nV = size(V, 1);
nH = size(H, 1);
nE = size(E, 1);
div %division length 1 to 0.5

%m*3 -> 8*n*3 vertex resize it
%loop through it 
%given V1, V2, find their middle point
newV = [];
for i= 1:nE
  newV =[newV; (V(E(i,1),:)+V(E(i,2),:))/2]; %find the endge added vertex
  %find the middle vertex for a plane (4 added)
  %find the middle vertex of a hex (1 added)
  unique();
end
