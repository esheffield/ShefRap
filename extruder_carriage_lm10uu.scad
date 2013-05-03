use <linear_bearing.scad>;
use <roundCornersCube.scad>;

clearance = 0.7;

b_dia = 19 + clearance;		// Outer diameter of 10mm linear bearing
b_len = 29 + clearance;		// Bearing length

support_t = 3.5;

bb_w = (b_len + 2 * support_t) / 5;		// Individual bearing block width
bb_d = b_dia + (2 * support_t);			// ... depth
bb_h = 0.75 * b_dia;						// ... height
bb_g = bb_w;									// ... and gap spacing between blocks
bb_len = (3 * bb_w) + (2 * bb_g);		// Total bearing block length

p_t = 3.250;					// Main plate thickness

hole_l = 46.785;
hole_w = 24;
hole_t = p_t + 0.2;

p_w = (bb_d * 2) + hole_w + 4;		// Main plate width
p_l = 80.125;								// ... length

module draw_extruder_carriage(show_bearing)
{
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
				bearing_mount(show_bearing);
			translate([length - bb_len,0,thick])
				bearing_mount(show_bearing);
			translate([0,width-bb_d,thick])
				bearing_mount(show_bearing);
			translate([length - bb_len,width-bb_d,thick])
				bearing_mount(show_bearing);
			fan_mnt_tab_small();
			translate([ctr_x - (16.125 / 2), 0, 0])
				fan_mnt_tab_large();
			translate([length - 8, 0, 0])
				fan_mnt_tab_small();
		}
		translate([ctr_x, ctr_y, (hole_t / 2) - 0.1])
			roundCornersCube(hole_l, hole_w, hole_t, 6);
		translate([mnt_offset, ctr_y, -0.1])
			cylinder(r = 2.5, h = hole_t);
		translate([length - mnt_offset, ctr_y, -0.1])
			cylinder(r = 2.5, h = hole_t);

	}
}

module fan_mnt_tab_small()
{
	translate([8 / 2, -3, p_t / 2])
	difference()
	{
		roundCornersCube(8,10,p_t,2);
		translate([0,3 + (2.1 / 2),0])
			cube([8.2,2.1,p_t+0.2],center=true);
		translate([0, -1, -(p_t / 2) - 0.1])
			cylinder(r=3.6 / 2, h = p_t + 0.2);
	}
}

module fan_mnt_tab_large()
{
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

module bearing_mount(show_bearing=false)
{
	w = bb_w;
	d = bb_d;
	g = bb_g;
	h = bb_h;

	len = bb_len;

	b_lip = 2.6;

	difference()
	{
		union()
		{
			cube([w,d,h]);
			translate([w + g, 0, 0])
				cube([w,d,h]);
			translate([(w + g) * 2, 0, 0])
				cube([w,d,h]);
		}
		translate([(len - b_len) / 2, d / 2, b_dia / 2])
		{
			rotate([0,90,0])
				cylinder(r = b_dia / 2, h = b_len);
			translate([-((len - b_len) / 2) - 0.1, 0, 0]) rotate([0,90,0])
				cylinder(r = (b_dia / 2) - b_lip, h = len + 0.2);
		}
	}

	if(show_bearing) {
		translate([(len - b_len) / 2, d / 2, b_dia / 2])
			bearing();
	}
}

module bearing()
{
	color([0.4,0.4,0.4])
		rotate([0,90,0])
			linear_bearing(10);
}

module extruder_carriage(show_bearing=false)
{
	translate([p_l, -(bb_d / 2), (p_t + b_dia / 2)])
		rotate([0,180,0])
			draw_extruder_carriage(show_bearing);
}

extruder_carriage(true);

