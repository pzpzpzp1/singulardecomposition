function [H2] = hexface2hex(H1, F12, H)
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    H(Hi,:) = [];
    [~,H2] = ismember(sort(F12(:),2), sort(H,2), 'rows');
end
    
function [F23] = facehex2face(H2,F12)
    F = hex2face(H2);
    for i=1:6
    [Y,F2] = ismember(sort(F(i,:),2),sort(F12,2), 'rows');
    if Y=0
        F23=F2;
    end
    end
end