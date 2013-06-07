include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <linear_bearing.scad>;
use <roundCornersCube.scad>;
use <linear_bearing_mount.scad>;

module extruder_carriage(show_bearing = false)
{
	x_rod_sep = x_axis_rod_separation;
	bearing = x_axis_rod;
	b_dia = x_axis_bearing_dia + clearance;
	b_len = x_axis_bearing_len + clearance;

	bb_dims = get_bb_dims(b_dia, b_len);
	bb_w = bb_dims[0];		// Individual bearing block width
	bb_d = bb_dims[1];		// ... depth
	bb_h = bb_dims[2];		// ... height
	bb_g = bb_dims[3];		// ... and gap spacing between blocks
	bb_len = bb_dims[4];	// Total bearing block length

	hole_l = ex_hole_l;
	hole_w = ex_hole_w;
	hole_t = base_t + 0.2;;

	length = ex_carriage_len;
	width = x_rod_sep + bb_d;
	thick = base_t;

	mnt_r = 2.5;
	mnt_offset = 15.063;

	ctr_x = length / 2;
	ctr_y = width / 2;

	echo(99999);
	echo(b_dia);
	echo(b_len);
	echo(length);
	echo(bb_len);
	echo(99999);

	translate([length, -(bb_d / 2), (base_t + b_dia / 2)])
	rotate([0,180,0])
	difference()
	{
		union()
		{
			color(pla_color)
				cube([length, width, thick]);
			translate([0,0,thick])
				bearing_mount(bearing, show_bearing);
			translate([length - bb_len,0,thick])
				bearing_mount(bearing, show_bearing);
			translate([0,width-bb_d,thick])
				bearing_mount(bearing, show_bearing);
			translate([length - bb_len,width-bb_d,thick])
				bearing_mount(bearing, show_bearing);

			color(pla_color)
			{
				fan_mnt_tab_small(base_t);
				translate([ctr_x - (16.125 / 2), 0, 0])
					fan_mnt_tab_large(base_t);
				translate([length - 8, 0, 0])
					fan_mnt_tab_small(base_t);
			}
		}
		translate([ctr_x, ctr_y, (hole_t / 2) - 0.1])
			roundCornersCube(hole_l, hole_w, hole_t, 6);
		translate([mnt_offset, ctr_y, -0.1])
			cylinder(r = 2.5, h = hole_t);
		translate([length - mnt_offset, ctr_y, -0.1])
			cylinder(r = 2.5, h = hole_t);

	}
}

module fan_mnt_tab_small(plate_thickness)
{
	p_t = plate_thickness;
	w = 8;
	translate([w / 2, -3, p_t / 2])
	difference()
	{
		roundCornersCube(w, 10, p_t, 2);
		translate([0, 3 + (2.1 / 2), 0])
			cube([8.2, 2.1, p_t+0.2], center=true);
		translate([0, -1, -(p_t / 2) - 0.1])
			cylinder(r=3.6 / 2, h = p_t + 0.2);
	}
}

module fan_mnt_tab_large(plate_thickness)
{
	p_t = plate_thickness;
	w = 16.125;
	translate([w / 2, -3, p_t / 2])
	difference()
	{
		roundCornersCube(w,10,p_t,2);
		translate([0,3 + (2.1 / 2),0])
			cube([w + 0.2,2.1,p_t+0.2],center=true);
		translate([-((w / 2) - 4), -1, -(p_t / 2) - 0.1])
			cylinder(r=3.6 / 2, h = p_t + 0.2);
		translate([(w / 2) - 4, -1, -(p_t / 2) - 0.1])
			cylinder(r=3.6 / 2, h = p_t + 0.2);
	}
}

extruder_carriage(true);

