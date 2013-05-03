include <bearing_dims.scad>;
use <linear_bearing.scad>;
use <roundCornersCube.scad>;
use <linear_bearing_mount.scad>;

module draw_extruder_carriage(v, show_bearing)
{
	p_l = v[0];
	p_w = v[1];
	p_t = v[2];
	bearing = v[3];
	bb_w = v[4];
	bb_d = v[5];
	bb_h = v[6];
	bb_g = v[7];
	bb_len = v[8];
	hole_l = v[9];
	hole_w = v[10];
	hole_t = v[11];

	length = p_l;
	width = p_w;
	thick = p_t;

	mnt_r = 2.5;
	mnt_offset = 15.063;

	ctr_x = length / 2;
	ctr_y = width / 2;

	difference()
	{
		union()
		{
			cube([length, width, thick]);
			translate([0,0,thick])
				bearing_mount(bearing, show_bearing);
			translate([length - bb_len,0,thick])
				bearing_mount(bearing, show_bearing);
			translate([0,width-bb_d,thick])
				bearing_mount(bearing, show_bearing);
			translate([length - bb_len,width-bb_d,thick])
				bearing_mount(bearing, show_bearing);
			fan_mnt_tab_small(p_t);
			translate([ctr_x - (16.125 / 2), 0, 0])
				fan_mnt_tab_large(p_t);
			translate([length - 8, 0, 0])
				fan_mnt_tab_small(p_t);
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

module extruder_carriage(bearing, show_bearing=false)
{
	dims = get_dims_for_shaft_size(bearing, linear_bearing_dims);
	b_dia = dims[1] + clearance;		// Outer diameter of 10mm linear bearing
	b_len = dims[2] + clearance;		// Bearing length

	support_t = 3.5;

	bb_w = (b_len + 2 * support_t) / 5;		// Individual bearing block width
	bb_d = b_dia + (2 * support_t);			// ... depth
	bb_h = 0.75 * b_dia;						// ... height
	bb_g = bb_w;									// ... and gap spacing between blocks
	bb_len = (3 * bb_w) + (2 * bb_g);		// Total bearing block length

	p_t = 3.250;		// Main plate thickness

	hole_l = 46.785;
	hole_w = 24;
	hole_t = p_t + 0.2;

	p_w = (2 * bb_d) + hole_w + 6;			// ... width
	p_l = 80;										// ... length

	v = [p_l, p_w, p_t, bearing, bb_w, bb_d, bb_h, bb_g, bb_len, hole_l, hole_w, hole_t];

	translate([p_l, -(bb_d / 2), (p_t + b_dia / 2)])
		rotate([0,180,0])
			draw_extruder_carriage(v, show_bearing);
}

extruder_carriage(8, true);

