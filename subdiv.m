function [Vsd,Hsd]= subdiv(V,H) 
% input singular certex  output singular curves
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

%build the H list
%index of V(column) NEED TO THINK IF HOW TO REORDER
V1 = [1:nV]';
vedge = [];
for i = 1:nF
    [~,e_12] = ismember(sort([F(i,1), F(i,2)],2), E, 'rows'); 
    [~,e_23] = ismember(sort([F(i,2), F(i,3)],2), E, 'rows'); 
    [~,e_34] = ismember(sort([F(i,3), F(i,4)],2), E, 'rows'); 
    [~,e_14] = ismember(sort([F(i,4), F(i,1)],2), E, 'rows'); 
    vedge = [vedge; e_12 + nV + 1, e_23 + nV + 1, e_34 + nV + 1, e_14 + nV + 1];
end
vface = [];
for i = 1:nH
    [~,f_1234] = ismember(sort([H(i,1), H(i,2),H(i,3), H(i,4)],4), F, 'rows'); 
    [~,f_8734] = ismember(sort([H(i,3), H(i,4),H(i,7), H(i,8)],4), F, 'rows');
    [~,f_5687] = ismember(sort([H(i,5), H(i,6),H(i,8), H(i,7)],4), F, 'rows');
    [~,f_1548] = ismember(sort([H(i,1), H(i,5),H(i,4), H(i,8)],4), F, 'rows');
    [~,f_1256] = ismember(sort([H(i,1), H(i,2),H(i,5), H(i,6)],4), F, 'rows');
    [~,f_2637] = ismember(sort([H(i,2), H(i,6),H(i,3), H(i,7)],4), F, 'rows');
    vface = [vface; f_1234 + nV + nF+ 1, f_8734 + nV + nF+ 1, f_5687 + nV + nF+ 1, f_1548 + nV + nF+ 1, ...
        f_1256 + nV + nF+ 1, f_2637 + nV + nF+ 1];
end

%V1 is good
%V2: vne bw initial v1 and v2
%V3: vnf bw initial v1,v2,v3, v4 
%V4: vne bw initial v1 and v4
%V5: vne bw initial v1 and v5
%V6: vnf bw initial v1, v5, v6, v2
%V7: vnh
%V8: vnf bw initial v1, v4, v5, v8

% Vgenerate=[];
% for i =1:nH
%     [~,V2] = ismember(sort([H(i,1), H(i,2)],2), E, 'rows');  
%     [~,V3] = ismember(sort([H(i,1), H(i,4), H(i,1), H(i,4),],4), F, 'rows');
%     [~,V4] = ismember(sort([H(i,1), H(i,4)],2), E, 'rows'); 
%     [~,V5] = ismember(sort([H(i,1), H(i,5)],2), E, 'rows'); 
%     [~,V6] = ismember(sort([H(i,1), H(i,5), H(i,6), H(i,2),],4), F, 'rows');
%     [~,V8] = ismember(sort([H(i,1), H(i,4), H(i,5), H(i,8),],4), F, 'rows');
%     Vgenerate =[Vgenerate,  nV+1+V2,  nV+1+V3,  nV+1+V4,  nV+1+V5,  nV+1+V6,  nV+1+V8];
% end

%index of Vnh
Vnh_I = ones(nH);
%hex list
H = [V1, Vnh_I, vedge, vface]; %1,1,3,3
%reorder hex list to make it correct
Hsd = [H(:,1), H(:,3), H(:,4), H(:,5), H(:,6), H(:,7), H(:,2), H(:,8)]; 
end