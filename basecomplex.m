function [Vbc, Hbc] = basecomplex(V,H)
%consider the face list
E = hex2edge(H); %sth*2
F = hex2face(H);
% - Record sizes of mesh
nV = size(V, 1);
nH = size(H, 1);
nE = size(E, 1);
nF = size(F,1);

%Approach: if the face is an interior face, delete all points, then
%we're done.
%If the faces are adjacent to 1 hex, boundary
%if they are adjacent to 2 hexes, interior. 
Fb =[];  %boundary
Fi =[];  %interior
for i=1:nH
    for j=1:nH
        [a,(i,j)] = ismember([F(i,:),F(i,:)], [sort(H(i,:),8),'rows',sort(H(j,:),8),'rows']); 
        if a == 1
            Fb = [Fb; F(i,:)];
        else
            Fi = [Fi; F(i,:)];
        end
    end
end

        
end


end