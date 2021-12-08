function F = hex2face(H) %Fh (F for hexes- redundant count)
F = [H(:,1),H(:,2),H(:,3),H(:,4); H(:,5),H(:,6),H(:,2),H(:,1);...
        H(:,6),H(:,5),H(:,8),H(:,7); H(:,3),H(:,7),H(:,8),H(:,4);...
        H(:,6),H(:,7),H(:,3),H(:,2); H(:,5),H(:,1),H(:,4),H(:,8)];
Hf = repmat((1:size(H,1))',6,1); %indexing for F in terms of H
[~,ia,ib] = unique(sort(F,2),'rows'); 
%ia is the index of F in terms of uniqueF; ib is the inverse;
uniqueF = F(ia, :);
HuniqueF = Hf(ia, :); %where uniqueF is in terms of H (one of the face)
%find the other index for uniqueF
end
F = uniqueF(ib,:)
%unique facelist
%output 2 indices