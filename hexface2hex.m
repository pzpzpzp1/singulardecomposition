function [H2] = hexface2hex(H1, F12, H,V)
    if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    H1 = H(1,:);
    [~,~,F,H,~,~,~,nH] = datastructure(V,H);
    F12 = F(1,:);
    end
    [V,E,F,H] = datastructure(V,H);
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows');
    %ismember stops after finding one valid choice?
    [l,Fi] = ismember(sort(F12,2), sort(F,2), 'rows');
    Hj = rem(Fi,nH);
    H2 = setdiff(Hj,Hi);
end