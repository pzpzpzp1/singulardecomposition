function [F2] = facehex2face(F12, H2, H,V)
 if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    H2 = H(2,:);
    [~,E,F,H,~,~,~,nH] = datastructure(V,H);
    F12 = F(1,:);
 end
    [~,E,F,H,~,~,~,nH] = datastructure(V,H);
    [~,Fi] = ismember(sort(F12,2), sort(F,2), 'rows'); %to find the index of the one to exclude
    F2 = hex2face(H2); %all the faces in the hex
    % want to find the face that exclude all the vertices in F12
    [~,El] = ismember(sort([F12(:,1),F12(:,2)],2),sort(Ef(i,:),2),"rows");
    sort(F12(1,i), 
    for i=1:nE
    for i=1:4
        [~,El] = ismember(sort([F12(:,1),F12(:,2)],2),sort(Ef(i,:),2),"rows");
        [~,E2] = ismember(sort([F12(:,2),F12(:,3)],2),sort(Ef(i,:),2),"rows");
        [~,E3] = ismember(sort([F12(:,3),F12(:,4)],2),sort(Ef(i,:),2),"rows");
        [~,E4] = ismember(sort([F12(:,4),F12(:,1)],2),sort(Ef(i,:),2),"rows");
    %[~,El] = ismember(sort(Ef(i,:),2),sort(F2,2),"rows");
    end
    F2 = setdiff(Fj,Fi); %the one that doesn't include any pts in the intial face
    
    
end
