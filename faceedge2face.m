function [F2] = faceedge2face(F1, E12, H,V)
    if nargin==0
    file_name = 'meshes\bunny.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    [~,~,F,H,~,nE,nF,nH] = datastructure(V,H);
    F1 = F(1,:); %setup
    Ef = face2edge(F); %we want Ef for the argument
    E12 = Ef(1,:); %setup
    end
    %since an edge is adjacent to 4 faces, need to check F2 and F1 dont
    %share any hex
    [V,Eh,F,H] = datastructure(V,H);
    %E = face2edge(F);
    [~,Fi] = ismember(sort(F1,2), sort(F,2), 'rows'); %to find the index of the one to exclude
    Ei = find(all((sort(E12, 2)- sort(Eh, 2))==0, 2));
    Ei = Ei'; %missing value
    %if the dimension is not 4, then return -1  -singularities
    Fj = rem(Ei,nF); 
    F2 = setdiff(Fj,Fi); %output is 0 needs to add nF
    
    %add another condition on F2 to make sure these faces do not share the
    %same hex as the other. 
    %1. given F1, find the H1 and H2 that includes F1
    %2. if F2, F3, F4 in H1, exclude; if in H2, exclude; 
    % o.w. keep it and return F2 
    %step 1
    Fi = find(all((sort(F1, 2)- sort(F, 2))==0, 2)); 
    Fi = Fi';
    Hj = rem(Fi,nH); %Hj are the H1 and H2

%this doesn't work---need to be fixed
    %step 2
    for i=1:3
        if (sort(F2(i), 2)-sort(hex2face(H(Hj(1),:)),2))==0
            F2 = setdiff(F2, F2(i))
        elseif (sort(F2(i), 2)-sort(hex2face(H(Hj(2),:)),2))==0
            F2 = setdiff(F2, F2(i))
        end
    end
end