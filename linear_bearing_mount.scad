include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <linear_bearing.scad>;

module bearing_mount(bearing, show_bearing=false)
{
	dims = get_dims_for_shaft_size(bearing, linear_bearing_dims);
	echo(dims);
	b_dia = dims[1] + clearance;
	b_len = dims[2] + clearance;

	bb_dims = get_bb_dims(b_dia, b_len);
	bb_w = bb_dims[0];		// Individual bearing block width
	bb_d = bb_dims[1];		// ... depth
	bb_h = bb_dims[2];		// ... height
	bb_g = bb_dims[3];		// ... and gap spacing between blocks
	bb_len = bb_dims[4];		// Total bearing block length

	w = bb_w;
	d = bb_d;
	g = bb_g;
	h = bb_h;

	len = bb_len;

	b_lip = bb_lip_t;

	echo(11111);
	echo(b_dia);
	echo(b_len);
	echo(w);
	echo(d);
	echo(g);
	echo(h);
	echo(len);
	echo(11111);

	difference()
	{
		color(pla_color) union()
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
			bearing(bearing);
	}
}

module bearing(bearing)
{
	color([0.4,0.4,0.4])
		rotate([0,90,0])
			linear_bearing(bearing);
}

bearing_mount(10, false);