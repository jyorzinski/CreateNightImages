%% Convert CIE xyY to CIE XYZ.
%%
function XYZimage = xyY2XYZ ( xyYimage )

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfn_license.m
%%

    xyYimageClipped ( :,:,1 ) = xyYimage ( :,:,1 );
    xyYimageClipped ( :,:,2 ) = xyYimage ( :,:,2 );
    xyYimageClipped ( :,:,3) = min ( max ( xyYimage ( :,:,3), 0.0 ), 1.0 );
			% clip luminance ot [0.0 - 1.0]

    if xyYimage ( :,:,3 ) <= 0.0

	XYZimage ( :,:,1 ) = 0.0;
	XYZimage ( :,:,2 ) = 0.0;
	XYZimage ( :,:,3 ) = 0.0;

    else

        XYZimage ( :,:,1 ) = ( xyYimage ( :,:,1 ) .* xyYimage ( :,:,3 ) ) ./ ...
		xyYimage ( :,:,2 );
	XYZimage ( :,:,2 ) = xyYimage ( :,:,3 );
        XYZimage ( :,:,3 ) = ( ( 1.0 - xyYimage ( :,:,1 ) - ...
			xyYimage ( :,:,2 ) ) .* xyYimage ( :,:,3 ) ) ./ ...
				xyYimage ( :,:,2 );

    end % if

end % xyY2XYZ
