function F = hex2face(H)
F = [H(:,1),H(:,2),H(:,3),H(:,4); H(:,5),H(:,6),H(:,2),H(:,1);...
        H(:,6),H(:,5),H(:,8),H(:,7); H(:,3),H(:,7),H(:,8),H(:,4);...
        H(:,6),H(:,7),H(:,3),H(:,2); H(:,5),H(:,1),H(:,4),H(:,8)];
end