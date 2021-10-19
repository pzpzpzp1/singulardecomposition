function Eh = hex2edge(H)
Eh = [];
for i = 1:size(H,1)
Eh = [Eh; ...
    H(i,1),H(i,2);...
    H(i,2),H(i,3); ...
    H(i,3),H(i,4); ...
    H(i,4),H(i,1); ...
    H(i,5),H(i,1); ...
    H(i,8),H(i,5); ...
    H(i,4),H(i,8); ...
    H(i,6),H(i,5); ...
    H(i,7),H(i,6); ...
    H(i,7),H(i,8); ...
    H(i,3),H(i,7); ...
    H(i,2),H(i,6)];
end
end
