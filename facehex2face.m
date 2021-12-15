function [F2] = facehex2face(F1, H1, data, visualization)
 if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    data = builddatastruct(H,V); F = data.F;
    %setup condition
    H1 = H(1,:);  F1 = F(1,:);
 end
    %setup 
    data = builddatastruct(H,V);
    E = data.Eh; F = data.Fh; H = data.H;
    nH = data.nH;
    %find all faces on H1
    F_h1 = hex2face(H1); %6*4 (6 faces per hex)
    %find all edges on F1
    E1 = face2edge(F1);
    %find all edges on F2- F6
    E_f1 = face2edge(F_h1(1,:));
    E_f2 = face2edge(F_h1(2,:));
    E_f3 = face2edge(F_h1(3,:));
    E_f4 = face2edge(F_h1(4,:));
    E_f5 = face2edge(F_h1(5,:));
    E_f6 = face2edge(F_h1(6,:));%6*(4*2) (4 edges per face)

    [Fi(1),~] = ismember(sort(E1,2), sort(E_f1,2), 'rows');
    [Fi(2),~] = ismember(sort(E1,2), sort(E_f2,2), 'rows');
    [Fi(3),~] = ismember(sort(E1,2), sort(E_f3,2), 'rows');
    [Fi(4),~] = ismember(sort(E1,2), sort(E_f4,2), 'rows');
    [Fi(5),~] = ismember(sort(E1,2), sort(E_f5,2), 'rows');
    [Fi(6),~] = ismember(sort(E1,2), sort(E_f6,2), 'rows');

    for j=1:6
        if Fi(j) == zeros(4,1)
            F2 = Fih(j);
        end
    end

%     F2i = find(all((sort(E_f1, 2)- sort(E_f2, 2))==0, 2));
%     F3i = find(all((sort(E_f1, 2)- sort(E_f3, 2))==0, 2));
%     F4i = find(all((sort(E_f1, 2)- sort(E_f4, 2))==0, 2));
%     F5i = find(all((sort(E_f1, 2)- sort(E_f5, 2))==0, 2));
%     F6i = find(all((sort(E_f1, 2)- sort(E_f6, 2))==0, 2));

   
    
    % check if F2-F6 share edges with F1
%     for 
%         [] = ismember(sort([F12(:,1),F12(:,2)],2),sort(Ef1(i,:),2),"rows");
%         if 1
%         end
%     end
%     [~,Fi] = ismember(sort(F12,2), sort(F,2), 'rows'); %to find the index of the one to exclude
%     F2 = hex2face(H2); %all the faces in the hex
%     % want to find the face that exclude all the vertices in F12
%     [~,El] = ismember(sort([F12(:,1),F12(:,2)],2),sort(Ef(i,:),2),"rows");
%     sort(F12(1,i), 
%     for i=1:nE
%     for i=1:4
%         [~,El] = ismember(sort([F12(:,1),F12(:,2)],2),sort(Ef(i,:),2),"rows");
%         [~,E2] = ismember(sort([F12(:,2),F12(:,3)],2),sort(Ef(i,:),2),"rows");
%         [~,E3] = ismember(sort([F12(:,3),F12(:,4)],2),sort(Ef(i,:),2),"rows");
%         [~,E4] = ismember(sort([F12(:,4),F12(:,1)],2),sort(Ef(i,:),2),"rows");
    %[~,El] = ismember(sort(Ef(i,:),2),sort(F2,2),"rows");
%     end
   % F2 = setdiff(Fj,Fi); %the one that doesn't include any pts in the intial face
end
