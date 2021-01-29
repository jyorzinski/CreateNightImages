%% Convert linear CIE xyY values in the range [0-1] to 8 bit/channel
%% non-linearly-encoded sRGB values
%%
function sRGBimage = xyY2sRGB ( xyYimage )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfn_license.m
%%
%% input:
%%
%%   xyY:               Floating point CIE xyY image with values in the
%%                      range [0.0]-[1.0].
%% output:
%%
%%   sRGBimage:         uint8 output image using sRGB encoding.
%%
%%

    sRGBimage = XYZ2sRGB ( xyY2XYZ ( xyYimage ) );

end % xyY2sRGB
