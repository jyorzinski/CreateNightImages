%% Convert linear CIE XYZ values in the range [0-1] to 8 bit/channel
%% non-linearly-encoded sRGB values
%%
function sRGBimage = XYZ2sRGB ( XYZimage )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfn_license.m
%%
%% input:
%%
%%   XYZ:               Floating point input image with values in the
%%                      range [0.0]-[1.0].
%% output:
%%
%%   sRGBimage:         uint8 output image using sRGB encoding.
%%
%%
%% Algorithms and conversion values taken from
%% <http://en.wikipedia.org/wiki/SRGB>.
%%

    XYZ2sRGB_conversion_matrix_R = [  3.2404542 -1.5371385 -0.4985314 ];
    XYZ2sRGB_conversion_matrix_G = [ -0.9692660  1.8760108  0.0415560 ];
    XYZ2sRGB_conversion_matrix_B = [  0.0556434 -0.2040259  1.0572252 ];

    RGBfimage = zeros ( size ( XYZimage ) );	% preallocate

    RGBImage(:,:,1) = ( XYZ2sRGB_conversion_matrix_R(1) * ...
                                        XYZimage(:,:,1) ) + ...
                ( XYZ2sRGB_conversion_matrix_R(2) * XYZimage(:,:,2) ) + ...
                ( XYZ2sRGB_conversion_matrix_R(3) * XYZimage(:,:,3) );
    RGBImage(:,:,2) = ( XYZ2sRGB_conversion_matrix_G(1) * ...
                                        XYZimage(:,:,1) ) + ...
                ( XYZ2sRGB_conversion_matrix_G(2) * XYZimage(:,:,2) ) + ...
                ( XYZ2sRGB_conversion_matrix_G(3) * XYZimage(:,:,3) );
    RGBImage(:,:,3) = ( XYZ2sRGB_conversion_matrix_B(1) * ...
                                        XYZimage(:,:,1) ) + ...
                ( XYZ2sRGB_conversion_matrix_B(2) * XYZimage(:,:,2) ) + ...
                ( XYZ2sRGB_conversion_matrix_B(3) * XYZimage(:,:,3) );

    sRGBfloatImage = real ( ...
	max ( min ( 12.92*RGBImage, .0392768 ), ... % linear part
          ( ( 1.055 * ( RGBImage .^ ( 1.0/2.4) ) ) - 0.055 ) ) ... % gamma part
	);

    sRGBimage = uint8 ( 256 .* sRGBfloatImage );

end % xyY2sRGB
