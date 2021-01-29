function newxyYimage = dfn_luminance_chroma ( xyYimage, ...
				photopicscotopic, blueshift, darkening )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfnlicense.m
%%
%% input:
%%
%%   xyYimage:		Input CIE xyY image
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
%% output:
%%
%%   new_xyYimage:	Filtered image.
%%
%% Photopic to scotopic conversion from G.W. Larson, H. Rushmeier, and
%% C. Piatko, "A visibility matching tone reproduction operator for high
%% dynamic range scenes," IEEE Transactions on Visualization and Computer
%% Graphics 3(4), 1997.
%%

    if ( ndims ( xyYimage ) ~= 3 ) | ( ~ isa ( xyYimage, 'float' ) )
        error ( 'dfn_luminance_chroma: input not an xyY image!' )
    end % if

    if ( blueshift < 0.0 ) | ( blueshift > 1.0 )
	error ( 'dfn_luminance_chroma: blueshift out of range!' )
    end

    if darkening > 0.0
	error ( 'dfn_luminance_chroma: darkening value specifies lightening!' )
    end

    %%
    %% Photopic-scotopic luminance adjustment (Purkinje shift).
    %%

    XYZimage = xyY2XYZ ( xyYimage );

    V = XYZimage(:,:,2) .* ...
	( 1.33 * ( 1.0 + ...
	    ( ( XYZimage(:,:,2) + XYZimage(:,:,3) ) ./ ...
		max ( XYZimage(:,:,1), 0.001 ) ) ) - 1.68 );

    V_adjust = mean ( xyYimage(:,3) ) / mean ( V(:) );
    V_scaled =  V_adjust .* V;

    newxyYimage = xyYimage;
    newxyYimage(:,:,3) = ( ( 1.0 - photopicscotopic ) * xyYimage(:,:,3) ) + ...
				( photopicscotopic * V_scaled );

    %%
    %% Photopic-scotopic saturation adjustment.
    %%

    newxyYimage(:,:,1) = ( ( 1.0 - photopicscotopic ) * ...
						newxyYimage(:,:,1) ) + ...
    					( photopicscotopic  * 0.3333333 );
    newxyYimage(:,:,2) = ( ( 1.0 - photopicscotopic ) * ...
						newxyYimage(:,:,2) ) + ...
    					( photopicscotopic  * 0.3333333 );

    %%
    %% Blue shift
    %%

    newxyYimage(:,:,1) = ( blueshift * 0.25 ) + ...
    			( ( 1.0 - blueshift ) * newxyYimage(:,:,1) );
    newxyYimage(:,:,2) = ( blueshift * 0.25 ) + ...
    			( ( 1.0 - blueshift ) * newxyYimage(:,:,2) );

    %%
    %% Darkening
    %%

    exposure_adjust = 2.0 ^ darkening;
    newxyYimage(:,:,3) = exposure_adjust * newxyYimage(:,:,3);

end % dfn_luminance_chroma
