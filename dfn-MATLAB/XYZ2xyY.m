%% Convert from CIE XYZ to CIE xyY.
%%
function  xyYimage = XYZ2xyY ( XYZimage );

%% University of Utah augmented day-for-night image filtering.
%% William B. Thompson <thompson@cs.utah.edu>
%%
%% Version 1.0.0, October 2, 2017
%% See dfn_license.m

    if ( ndims ( XYZimage ) ~= 3 ) | ( ~ isa ( XYZimage, 'float' ) )
	error ( 'XYZ2xyY: input not an XYZ image!' )
    end % if

    xyYimage = zeros ( size ( XYZimage ) );	% preallocate

    norm = XYZimage ( :,:,1 ) + XYZimage (:,:,2) + XYZimage (:,:,3);

    xyYimage_1 ( :,: ) = XYZimage ( :,:,1 ) ./ norm;	% NaN if norm == 0
    xyYimage_2 ( :,: ) = XYZimage ( :,:,2 ) ./ norm;	% NaN if norm == 0
    xyYimage_3 ( :,: ) = XYZimage ( :,:,2 );

    %% There *MUST* be a better way to do this, but I can't figure out
    %% how to make logical indexing work for vector values (e.g., images)!

    xyYimage_1 ( norm <= 0 ) = 0.33333333;
    xyYimage_2 ( norm <= 0 ) = 0.33333333;
    xyYimage_3 ( norm <= 0 ) = 0.0;

    xyYimage ( :,:,1 ) = xyYimage_1 ( :,: );
    xyYimage ( :,:,2 ) = xyYimage_2 ( :,: );
    xyYimage ( :,:,3 ) = xyYimage_3 ( :,: );

end % XYZ2xyY
