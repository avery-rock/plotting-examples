%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Avery Rock, UC Berkeley Mechanical Engineering, avery_rock@berkeley.edu
% Modified for ME C201 / MATSCI 286, Spring 2020. 

% Sample code to help with plotting deformation modes on a cube. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MODIFY
vertices = [0 0 0; 0.001 0 0; 0.001 0.001 0; 0 0.001 0; 0 0 0.001;...
    0.001 0 0.001; 0.001 0.001 0.001; 0 0.001 0.001]; % locations of corners
% MODIFY

faces = [1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8]; % indices of corners for each face. 

patch('Vertices',vertices,'Faces',faces, 'FaceColor','r'); % plot box with polygon faces

view(-37.5, 30); axis([0 0.0015 0 0.0015 0 0.0015]); % set view angle

grid on; axis equal; % set background grid and uniform scaling. 