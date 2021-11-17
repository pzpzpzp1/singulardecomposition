function [F2] = facehex2face[F12, H2, F]
    E2 = hex2edge(H2);
    F2 = hex2face(H2);
    Ef = face2edge(F2);
    for i=1:6
    [Y,F] = ismember(sort(E2,2),sort(Ef,2), 'rows');
    if Y==zeros(4)
        F2=F;
    H2 = setdiff(Hj,Hi);
end
