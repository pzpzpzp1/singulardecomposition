function [F2] = facehex2face[F12, H2, F]
    F = hex2face(H2);
    for i=1:6
    [Y,F] = ismember(sort(F(i,:),2),sort(F12,2), 'rows');
    if Y==zeros(4)
        F2=F;
    end
    end
end
