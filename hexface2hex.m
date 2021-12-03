function [H2] = hexface2hex(H1, F12, H,V)
    if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    H1 = H(1,:); %setup
    [~,~,F,H,~,~,nF,nH] = datastructure(V,H);
    F12 = F(1,:); %setup
    end
    [V,E,F,H] = datastructure(V,H);
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows'); %to find the index of the one to exclude
    %ismember stops after finding one valid choice? 
    %should output 1 and 8 here but only output 1
    Fi = [];
    for i = 1:nF
       if sort(F12, 2)-sort(F(i,:), 2)==0
           Fi = [Fi; i];
       end
    end
    Fi = Fi';
    Hj = rem(Fi,nH); 
    H2 = setdiff(Hj,Hi); %output is 0 needs to add nH
end