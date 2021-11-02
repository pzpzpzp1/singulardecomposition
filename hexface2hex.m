function [Hdata] = hexface2hex(H1, F12, H)
    Hdata(1)=H1;
    for j =1:nH %need to know how to stop/identify boundary
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    H(Hi,:) = [];
    [~,H2] = ismember(sort(F12(:),2), sort(H,2), 'rows');
    F = hex2face(H2);
    for i=1:6
    [Y,F2] = ismember(sort(F(i,:),2),sort(F12,2), 'rows');
    if Y==zeros(4)
        F12=F2;
    end
    end
    Hdata(j+1) = Hdata;
    end
end