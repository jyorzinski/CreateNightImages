function filtered_image = dfn ( original_image, photopicscotopic, blueshift, ...
		darkening, sigma_blur, gamma_edge, sigma_noise )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfnlicense.m
%%
%% Day-for-night filtering including the edge-preserving acuity reduction
%% described in W.B. Thompson, P. Shirley, and J.A. Ferwerda, "A spatial
%% post-processing algorithm for images of night scenes," Journal of
%% Graphics Tools, (7)1 (2002).
%%
%% input:
%%
%%   original_image:	Input image (assumed to be in sRGB color space).
%%
%%   photopicscotopic:	Light level for Purkinje shift, desaturation.
%%			    0.0 ==> pure photopic
%%			    between 0.0 and 1.0 ==> some level of mesopic
%%			    1.0 ==> pure scotopic
%%
%%   blueshift:		Amount of blue shift.
%%			    0.0 ==> no shift
%%			    between 0.0 and 1.0 ==> some level of blue shift
%%			    1.0 ==> pure blue
%%
%%   darkening:		Amount of exposure adjustment specified in f-stops
%%			    -1.0 ==> darken by one stop
%%
%%   sigma_blur:        Standard deviation of primary blur.
%%
%%   gamma_edge:        Gamma of edge sharpening.
%%
%%   sigma_noise:       Standard deviation of uncorrelated Gaussian blur.
%%
%% output:
%%
%%   filtered_image:	Output image.
%%
%% Photopic to scotopic conversion from G.W. Larson, H. Rushmeier, and
%% C. Piatko, "A visibility matching tone reproduction operator for high
%% dynamic range scenes," IEEE Transactions on Visualization and Computer
%% Graphics 3(4), 1997.
%%

    if ( ndims ( original_image ) ~= 3 ) | ( ~ isa ( original_image, 'uint8' ) )
        error ( 'dfn: input not an 8 bit color image!' )
    end % if

    xyY_image = sRGB2xyY ( original_image );

    filtered_xyY = dfn_acuity_noise ( dfn_luminance_chroma ( xyY_image, ...
			photopicscotopic, blueshift, darkening ), ...
			sigma_blur, gamma_edge, sigma_noise );

    filtered_image = xyY2sRGB ( filtered_xyY );

end % dfn
