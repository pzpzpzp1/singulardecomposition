function [H2] = hexface2hex(H1, F12, H,V, visualize)
%do visualization work
    if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    H1 = H(2,:); %setup
    [~,~,F,H,~,~,nF,nH] = datastructure(V,H);
    F12 = F(2,:); %setup
    end
    [V,E,F,H] = datastructure(V,H);
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows'); %to find the index of the one to exclude
    %ismember stops after finding one valid choice
    Fi = find(all((sort(F12, 2)- sort(F, 2))==0, 2));
%     Fi = [];
%     for i = 1:nF
%        if sort(F12, 2)-sort(F(i,:), 2)==0
%            Fi = [Fi; i];
%        end
%     end
    Fi = Fi';
    Hj = rem(Fi,nH); 
    H2 = setdiff(Hj,Hi); %output is 0 needs to be 4 (add nH?)
    if H2 == 0
        H2 = nH;
    end
    %if 0 and turn to 4
end