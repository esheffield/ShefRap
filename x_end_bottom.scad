include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <linear_bearing_mount.scad>;
use <hex_nut.scad>;

module x_end_bottom(x_bearing, y_bearing)
{
	x_dims = get_dims_for_shaft_size(x_bearing, linear_bearing_dims);
	x_b_dia = x_dims[1] + clearance;
	x_b_len = x_dims[2] + clearance;

	x_bb_dims = get_bb_dims(x_b_dia, x_b_len);
	x_bb_w = x_bb_dims[0];
	x_bb_d = x_bb_dims[1];
	x_bb_h = x_bb_dims[2];
	x_bb_g = x_bb_dims[3];
	x_bb_len = x_bb_dims[4];

	y_dims = get_dims_for_shaft_size(y_bearing, linear_bearing_dims);
	y_b_dia = y_dims[1] + clearance;		// Outer diameter of 10mm linear bearing
	y_b_len = y_dims[2] + clearance;		// Bearing length

	y_bb_dims = get_bb_dims(y_b_dia, y_b_len);
	y_bb_w = y_bb_dims[0];		// Individual bearing block width
	y_bb_d = y_bb_dims[1];		// ... depth
	y_bb_h = y_bb_dims[2];		// ... height
	y_bb_g = y_bb_dims[3];		// ... and gap spacing between blocks
	y_bb_len = y_bb_dims[4];	// Total bearing block length

	thickness = (x_bearing / 2) + base_t;

	nut = nut_3mm;

	p_w = (2 * x_bb_d) + ex_hole_w + ex_hole_space;

	width = y_bb_d + (2 * (4 + nut));
	length = p_w;

	echo(width);
	echo(length);
	echo(thickness);

	x_rod_sep = length - x_bb_d;
	echo(x_rod_sep);

	ctr_x = width / 2;
	ctr_y = length / 2;

	y_offset_1 = ((x_bb_d / 2) - (x_bearing / 2)) / 2;
	y_offset_2 = ((x_bb_d / 2) + (x_bearing / 2)) + y_offset_1;

	translate([-width / 2, 0, y_b_dia / 2])
	difference()
	{
		union()
		{
			cube([width, length, thickness]);
			translate([width / 2 + (y_bb_d / 2), y_bb_len, 0])
				rotate([0,180,90])
					bearing_mount(y_bearing, show_bearing = true);
			translate([width / 2 + (y_bb_d / 2), length, 0])
				rotate([0,180,90])
					bearing_mount(y_bearing, show_bearing = true);
		}

		translate([-0.1, x_bb_d / 2, thickness])
			rotate([0,90,0])
				cylinder(r = x_bearing / 2, h = width + 0.2);

		translate([-0.1, length - (x_bb_d / 2), thickness])
			rotate([0,90,0])
				cylinder(r = x_bearing / 2, h = width + 0.2);

		translate([(nut/2)+2, y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([width - ((nut/2)+2), y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([(nut/2)+2, length - y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([width - ((nut/2)+2), length - y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}

		translate([(nut/2)+2, y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([width - ((nut/2)+2), y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([(nut/2)+2, length - y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
		translate([width - ((nut/2)+2), length - y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2, $fn=20);
		}
	}
}

x_end_bottom(10,10);