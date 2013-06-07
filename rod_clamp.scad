include <ShefRap_common.scad>;
use <hex_nut.scad>;

module rod_clamp(rod_dia, len, screw_sep, nuts=false, $fn=20)
{
	wid = rod_dia + (2 * (base_t + nut_3mm));
	ht = (rod_dia / 2) + base_t;

	screw_r = screw_3mm / 2;
	screw_h = ht + 0.2;
	screw_o = (base_t + nut_3mm) / 2;
	screw_o_l = screw_sep / 2;

	len_ctr = len / 2;

	difference()
	{
		cube([wid, len, (rod_dia / 2) + base_t]);

		translate([wid / 2, -0.1, 0])
			rotate([-90,0,0])
				cylinder(r=rod_dia / 2, h=len + 0.2);

		rod_clamp_holes(rod_dia, len, screw_sep);

		if(nuts)
		{
			translate([screw_o, len_ctr - screw_o_l, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([screw_o, len_ctr + screw_o_l, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([wid - screw_o, len_ctr - screw_o_l, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([wid - screw_o, len_ctr + screw_o_l, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
		}
	}
}

module rod_clamp_holes(rod_dia, len, screw_sep)
{
	wid = rod_dia + (2 * (base_t + nut_3mm));
	ht = (rod_dia / 2) + base_t;

	screw_r = screw_3mm / 2;
	screw_h = ht + 0.2;
	screw_o = (base_t + nut_3mm) / 2;
	screw_o_l = screw_sep / 2;

	len_ctr = len / 2;

	union()
	{
		translate([screw_o, len_ctr - screw_o_l, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([screw_o, len_ctr + screw_o_l, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([wid - screw_o, len_ctr - screw_o_l, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([wid - screw_o, len_ctr + screw_o_l, -0.1])
			cylinder(r=screw_r, h=screw_h);
	}
}

rod_clamp(x_axis_rod, 40, 20, nuts=true);
