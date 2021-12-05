function [H2] = hexface2hex(H1, F12, H,V, visualize)
%do visualization work
    if nargin==0
    file_name = 'sing1.vtk';
    mesh = load_vtk(file_name);
    V = mesh.points;
    H = mesh.cells;
    H1 = H(2,:); %setup
    [~,~,F,H,~,~,nF,nH] = datastructure(V,H);
    F12 = F(2,:); %setup
    visualize =1;
    end
    [V,E,F,H] = datastructure(V,H);
    [~,Hi] = ismember(sort(H1,2), sort(H,2), 'rows'); %to find the index of the one to exclude
    %ismember stops after finding one valid choice
    Fi = find(all((sort(F12, 2)- sort(F, 2))==0, 2));
%     Fi = [];
%     for i = 1:nF
%        if sort(F12, 2)-sort(F(i,:), 2)==0
%            Fi = [Fi; i];
%        end
%     end
    Fi = Fi';
    Hj = rem(Fi,nH); 
    H2 = setdiff(Hj,Hi); %output is 0 needs to be 4 (add nH?)
    %if 0 and turn to 4
    if H2 == 0
        H2 = nH;
    end
    Vh1 = V(H1,:);
    Vh2 = V(H(H2,:),:);
    Fh = hex2face(H(H2,:));

    %graph
    if visualize == 1
        figure; title('hexface2hex'); axis equal; hold all; rotate3d on;
        patch('Faces', F, 'Vertices', V, 'facecolor', 'blue', 'facealpha', 0.1);
        scatter3(Vh1(:,1), Vh1(:,2), Vh1(:,3), 'b', 'filled');
        patch('Faces', F12, 'Vertices', V, 'facecolor', 'green', 'facealpha', 0.1);
        patch('Faces', Fh, 'Vertices', V, 'facecolor', 'red', 'facealpha', 0.1);
        scatter3(Vh2(:,1), Vh2(:,2), Vh2(:,3), 'k', 'filled');
    end
end