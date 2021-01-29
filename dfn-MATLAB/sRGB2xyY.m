%% Convert 8 bit/channel sRGB values to floating point linear CIE xyY values
%% in the range [0-1].
%%
function xyYimage = sRGB2XYZ ( sRGBimage )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfn_license.m
%%
%% input:
%%
%%   sRGBimage:		uint8 image assumed to be sRGB encoded.
%%
%% output:
%%
%%   xyY:		Floating point CIE xyY image with values in the
%%			range [0.0]-[1.0].
%%

    if ( ndims ( sRGBimage ) ~= 3 ) | ( ~ isa ( sRGBimage, 'uint8' ) )
    	error ( 'sRGB2XYZ: input not an 8 bit color image!' )
    end % if

    xyYimage = XYZ2xyY ( sRGB2XYZ ( sRGBimage ) );

end % sRGB2xyY
