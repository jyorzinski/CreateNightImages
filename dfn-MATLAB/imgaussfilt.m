%% Partial replacement for MATLAB function imgaussfilt.
%% Delete or rename this file if the MATLAB-supplied imgaussfilt is
%% available.
%%
function B = imgaussfilt ( A, sigma )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfnlicense.m

    G = fspecial ( 'gaussian', round ( max ( 7 * sigma, 5 ) ), sigma );
    B = imfilter ( A, G, 'replicate' );

end % imgaussfilt
