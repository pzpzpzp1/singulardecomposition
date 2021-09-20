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
nF = size(F,1);
div %division length 1 to 0.5

% Approach 1: change the scale of V from m*3 -> 8*n*3, then loop through it 
% Fmat = sparse(repmat(1:nF,1,4),F,F*0+1,nF,nV);
% Fmatselector = sparse(1:(4*nF), F', F*0+1, 4*nF, nV);
% dat.H = H; 
% dat.F = F;
% dat.Fmat = Fmat;
% dat.Fmatselector = Fmatselector;


%Approach 2: generate all the vertex points then reorder them
Vne = []; %the new middle vertex of each edge (12 added)
Vnf = []; %the new middle vertex of each edge (6 added)
Vnh = []; %the new middle vertex of each edge (1 added)
for i= 1:nE
    Vne =[Vne; (V(E(i,1),:)+V(E(i,2),:))/2]
end
for i = 1:nF
    Vnf =[Vnf; (V(F(i,1),:)+V(F(i,2),:)+V(F(i,3),:)+V(F(i,4),:))/4];
end
for i = 1:nH
    Vnh =[Vnh; (V(H(i,1),:)+V(H(i,2),:)+V(H(i,3),:)+V(H(i,4),:)...
            +V(H(i,5),:)+V(H(i,6),:)+V(H(i,7),:)+V(H(i,8),:))/8];
end

%build the V list
Vsd = [V, Vnh, Vnf, Vne];

%build the H list
%index of V(column) NEED TO THINK IF HOW TO REORDER
VI = [1:nV]';
%index of Vnh
Vnh_I = [];
for i=1:nH
    Vnh_I = [Vnh_I; ones(1,8).*(nV+i)];
end
%index of Vnf (*3)
Vnf_I=[];
for i = 1:nH %unsure about indexing
    [~,f1] = ismember(sort([H(i,2), H(i,1)],2), F, 'rows'); 
    [~,f2] = ismember(sort([H(i,3), H(i,1)],2), F, 'rows'); 
    [~,f3] = ismember(sort([H(i,3), H(i,2)],2), F, 'rows');  
    Vnf_I = [Vnf_I; f1 + nV + 1, f2 + nV + 1, f3 + nV + 1];
end
%index of Vne (*3)
Vne_I =[];
for i = 1:nF
    [~,e1] = ismember(sort([F(i,2), F(i,1)],2), E, 'rows'); 
    [~,e2] = ismember(sort([F(i,3), F(i,1)],2), E, 'rows'); 
    [~,e3] = ismember(sort([F(i,3), F(i,2)],2), E, 'rows');  
    Vne_I = [Vne_I; e1 + nV + 1, e2 + nV + 1, e3 + nV + 1];
end

%hex list
H = [VI, Vnh_I, Vnf_I, Vne_I]; %1,1,3,3
%reorder hex list to make it correct
H = [H(:,6), H(:,1), H(:,7), H(:,3), H(:,4), H(:,5), H(:,8), H(:,2)]; 
end

%given V1, V2, find their middle point
newV = [];
for i= 1:nE
  newV =[newV; (V(E(i,1),:)+V(E(i,2),:))/2]; %find the endge added vertex
  %find the middle vertex for a plane (4 added)
  %find the middle vertex of a hex (1 added)
  unique();
end
