include <bearing_dims.scad>;

base_t = 4;

nut_3mm = 5.25;

clearance = 0.7;

/*
 * Rod sizes
 */

x_axis_rod = 10;
y_axis_rod = 10;
z_axis_rod = 12;

x_axis_bearing_dims = get_dims_for_shaft_size(x_axis_rod, linear_bearing_dims);
x_axis_bearing_dia = x_axis_bearing_dims[1];
x_axis_bearing_len = x_axis_bearing_dims[2];

y_axis_bearing_dims = get_dims_for_shaft_size(y_axis_rod, linear_bearing_block_dims);
y_axis_bearing_len = y_axis_bearing_dims[4];
y_axis_bearing_wid = y_axis_bearing_dims[3];
y_axis_bearing_mid_hgt = y_axis_bearing_dims[1];
y_axis_bearing_rod_clr = y_axis_bearing_mid_hgt - (y_axis_rod / 2);

x_axis_rod_separation = y_axis_bearing_len + (2 * (base_t + nut_3mm) + x_axis_rod);

echo(x_axis_rod_separation);

ex_hole_l = 46.785;
ex_hole_w = 24;
ex_hole_space = 6;


bb_support_t = 3.5;

function get_bb_dims(b_dia, b_len) = 
	[
		(b_len + 2 * bb_support_t) / 5,	// Individual bearing block width
		b_dia + (2 * bb_support_t),		// ... depth
		0.75 * b_dia,							// ... height
		(b_len + 2 * bb_support_t) / 5,	// ... and gap spacing between blocks
		(b_len + 2 * bb_support_t)			// Total bearing block length
	];


