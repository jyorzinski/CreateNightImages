%% Convert 8 bit/channel sRGB values to floating point linear CIE XYZ values
%% in the range [0-1].
%%
function XYZimage = sRGB2XYZ ( sRGBimage )

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
%%   XYZ:		Floating point output image with values in the
%%			range [0.0]-[1.0].
%%
%% Algorithms and conversion values taken from
%% <http://en.wikipedia.org/wiki/SRGB>.
%%

    if ( ndims ( sRGBimage ) ~= 3 ) | ( ~ isa ( sRGBimage, 'uint8' ) )
    	error ( 'sRGB2XYZ: input not an 8 bit color image!' )
    end % if

    RGBlinearLookup = zeros ( 1, 256 );	% preallocate

    for PixelValue = 0:1:255

        RGBlinearLookup ( PixelValue + 1 ) = ...
		sRGB2linear ( double ( PixelValue ) );

    end % for

    RGBlinear = RGBlinearLookup ( int32 ( sRGBimage ) + 1 );

    sRGB2XYZ_conversion_matrix_X = [ 0.4124564 0.3575761 0.1804375 ];
    sRGB2XYZ_conversion_matrix_Y = [ 0.2126729 0.7151522 0.0721750 ];
    sRGB2XYZ_conversion_matrix_Z = [ 0.0193339 0.1191920 0.9503041 ];

    XYZimage = zeros ( size ( sRGBimage ) );	% preallocate

    XYZimage(:,:,1) = ( sRGB2XYZ_conversion_matrix_X(1) * ...
    					RGBlinear(:,:,1) ) + ...
		( sRGB2XYZ_conversion_matrix_X(2) * RGBlinear(:,:,2) ) + ...
		( sRGB2XYZ_conversion_matrix_X(3) * RGBlinear(:,:,3) );

    XYZimage(:,:,2) = ( sRGB2XYZ_conversion_matrix_Y(1) * ...
    					RGBlinear(:,:,1) ) + ...
		( sRGB2XYZ_conversion_matrix_Y(2) * RGBlinear(:,:,2) ) + ...
		( sRGB2XYZ_conversion_matrix_Y(3) * RGBlinear(:,:,3) );

    XYZimage(:,:,3) = ( sRGB2XYZ_conversion_matrix_Z(1) * ...
    					RGBlinear(:,:,1) ) + ...
		( sRGB2XYZ_conversion_matrix_Z(2) * RGBlinear(:,:,2) ) + ...
		( sRGB2XYZ_conversion_matrix_Z(3) * RGBlinear(:,:,3) );

end % sRGB2XYZ

%% Convert from non-linear, 8-bit sRGB encoding to linear floating point
%% luminance encoding in range [0.0 - 1.0].
%%
function LinearValue = sRGB2linear ( sRGBvalue )

    CsRGBf = sRGBvalue / 255.0;

    if CsRGBf <= 0.04045
        LinearValue = CsRGBf / 12.92;
    else
        LinearValue =  ( ( CsRGBf + 0.055 ) / ( 1.0 + 0.055 ) ) ^ 2.4;
    end % if

end % sRGB2linear
