function [Hdata] = hexface2hex(H1, F12, H)
    Hdata(1)=H1;
    nH = size(H,1);
    
    for j =1:nH %need to know how to stop/identify boundary
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    H(Hi,:) = [];
    [~,H2] = ismember(sort(F12(:),2), sort(H,2), 'rows');
   
    end
    Hdata(j+1) = Hdata;
    end
end