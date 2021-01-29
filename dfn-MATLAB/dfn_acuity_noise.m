function newxyYimage = dfn_acuity_noise ( xyYimage, ...
				sigma_blur, gamma_edge, sigma_noise )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfnlicense.m
%%
%% Implementation of the algorithm descrbed in W.B. Thompson,
%% P. Shirley, and J.A. Ferwerda, "A spatial post-processing algorithm
%% for images of night scenes," Journal of Graphics Tools, (7)1 (2002).
%%
%% input:
%%
%%   xyYimage:		Input CIE xyY image
%%
%%   sigma_blur:	Standard deviation of primary blur.
%%
%%   gamma_edge:	Gamma of edge sharpening.
%%
%%   sigma_noise:	Standard deviation of uncorrelated Gaussian blur.
%%
%% output:
%%
%%   newxyYimage:	Filtered image.
%%  
%%
%% Photopic to scotopic conversion from G.W. Larson, H. Rushmeier, and
%% C. Piatko, "A visibility matching tone reproduction operator for high
%% dynamic range scenes," IEEE Transactions on Visualization and Computer
%% Graphics 3(4), 1997.
%%

    if ( ndims ( xyYimage ) ~= 3 ) | ( ~ isa ( xyYimage, 'float' ) )
        error ( 'dfn_acuity_noise: input not an xyY image!' )
    end % if

    if sigma_blur <= 0.0
	error ( 'dfn_acuity_noise: sigma_blur out of range!' )
    end

    if gamma_edge < 1.0
	error ( 'dfn_acuity_noise: gamma_edge out of range!' )
    end

    if sigma_noise <= 0.0
	error ( 'dfn_acuity_noise: sigma_noise out of range!' )
    end

    %%
    %% Sharpness-preserving acuity reduction.
    %%

    I_blur = imgaussfilt ( xyYimage ( :,:,3 ), sigma_blur );
    I_blur2 = imgaussfilt ( xyYimage ( :,:,3 ), 1.6 * sigma_blur );
			% cascaded Gaussian blur would be better!

    I_diff = I_blur - I_blur2;

    I_night = I_blur2 + real ( I_diff .^ ( 1.0 / gamma_edge ) );

    I_night_noise = imnoise ( I_night, 'gaussian', 0.0, ...
					sigma_noise * sigma_noise );
			% imnoise uses variance, not standard deviation

    newxyYimage = xyYimage;
    newxyYimage ( :,:,3 ) = I_night_noise;

end % dfn_acuity_noise
