function [E2] = edgevert2edge(E1, V12, E)
    [~,Ei] = ismember(sort(E1,2), sort(V12,2), 'rows');
    E(Ei,:) = [];
    [~,E2] = ismember(sort(V12,2), sort(E,2), 'rows');
end

function [V23] = vertedge2vert(E2,V12)
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    H(Hi,:) = [];
    [~,H2] = ismember(sort(F12(:),2), sort(H,2), 'rows');
end
