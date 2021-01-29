%% Demonstration script for day-for-night simulation.
%% Figures from paper.

%%
%% Where on photopic-mesopic-scotopic range.
%%
% photopicscotopic = 0.0;	% pure photopic
photopicscotopic = 0.6;		% mesopic
% photopicscotopic = 1.0;	% pure scotopic

%%
%% amount of blueshift (subjective)
%%
% blueshift = 0.0;	% none
% blueshift = 0.25;	% near none
blueshift = 0.35;	% partial
% blueshift = 0.5;	% partial
% blueshift = 0.75;	% near full
% blueshift = 1.0;	% full

%%
%% amount of darkening (subjective)
%%
% darkening = 0.0;	% none	
% darkening = -1.0;	% 1 stop	
darkening = -1.5;	% stop	
% darkening = -2.0;	% 2 stops
% darkening = -3.0;	% 3 stops	
% darkening = -4.0;	% 4 stops	

%%
%% Limit fine detail that is visible:
%%
% sigma_blur = 2.0;
% sigma_blur = 2.25;
sigma_blur = 2.5;
% sigma_blur = 3.0;
% sigma_blur = 4.0;

%%
%% Crispen edges of finest remaining detail:
%%
gamma_edge = 1.25;

%%
%% Amount of night noise:
%%
sigma_noise = 0.0075;
% sigma_noise = 0.0125;
% sigma_noise = 0.0175;

close all

I = imread ( 'M023C.jpg' );
% I = imread ( 'F074C.jpg' );


imshow ( I );
I_dfn = dfn ( I, photopicscotopic, blueshift, darkening, sigma_blur, ...
	gamma_edge, sigma_noise );
figure
imshow ( I_dfn )

imwrite ( I_dfn, 'M023C-dfn.jpg' );
% imwrite ( I_dfn, 'F074C-dfn.jpg' );

