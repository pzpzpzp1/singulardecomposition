function f2e = buildf2efromFandE(F,E) 
for i = 1:nF
    [~,e_12] = ismember(sort([F(i,1), F(i,2)],2), E, 'rows'); 
    [~,e_23] = ismember(sort([F(i,2), F(i,3)],2), E, 'rows'); 
    [~,e_34] = ismember(sort([F(i,3), F(i,4)],2), E, 'rows'); 
    [~,e_14] = ismember(sort([F(i,4), F(i,1)],2), E, 'rows'); 
    f2e = [f2e; e_12, e_23, e_34, e_14]; %face to edge conversion
end
end