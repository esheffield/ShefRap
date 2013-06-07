include <bearing_dims.scad>;

base_t = 4;

screw_3mm = 3.05;
nut_3mm = 5.25;

clearance = 0.7;

/*
 * Colors
 */
rod_color = [0.6, 0.6, 0.6];
frame_color = [0.5, 0.5, 0.5];
pla_color = [0, 0, 1];
pulley_color = [0.9, 0.9, 0.9];
bracket_color = [0.9, 0.9, 0.9];

/*
 * Rod sizes
 */

x_axis_rod = 10;
y_axis_rod = 10;
z_axis_rod = 12;

x_axis_bearing_dims = get_dims_for_shaft_size(x_axis_rod, linear_bearing_dims);
x_axis_bearing_dia = x_axis_bearing_dims[1];
x_axis_bearing_len = x_axis_bearing_dims[2];

y_axis_bearing_dims = get_dims_for_shaft_size(y_axis_rod, linear_bearing_long_block_dims);
y_axis_bearing_len = y_axis_bearing_dims[4];
y_axis_bearing_wid = y_axis_bearing_dims[3];
y_axis_bearing_mid_hgt = y_axis_bearing_dims[1];
y_axis_bearing_rod_clr = y_axis_bearing_mid_hgt - (y_axis_rod / 2);
y_axis_bearing_hole_len = y_axis_bearing_dims[8];
y_axis_bearing_hole_wid = y_axis_bearing_wid - (2 * y_axis_bearing_dims[9]);
y_axis_carriage_wid = y_axis_bearing_hole_len + (2 * ((1.5 * (base_t + nut_3mm)) + x_axis_rod));
y_axis_carriage_thickness = 6;

x_axis_rod_separation = y_axis_bearing_hole_len + (base_t + nut_3mm) + x_axis_rod;

/*
 * Carriage dims
 */

ex_carriage_len = 80;
ex_hole_l = 46.785;
ex_hole_w = 24;
ex_hole_space = 6;


bb_support_t = 3.5;
bb_lip_t = 2.6;

function get_bb_dims(b_dia, b_len) = 
	[
		(b_len + 2 * bb_support_t) / 5,	// Individual bearing block width
		b_dia + (2 * bb_support_t),		// ... depth
		0.75 * b_dia,							// ... height
		(b_len + 2 * bb_support_t) / 5,	// ... and gap spacing between blocks
		(b_len + 2 * bb_support_t)			// Total bearing block length
	];


