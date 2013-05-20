include <ShefRap_common.scad>;
use <hex_nut.scad>;

module rod_clamp(rod_dia, len, nuts=false, $fn=20)
{
	wid = rod_dia + (2 * (base_t + nut_3mm));
	ht = (rod_dia / 2) + base_t;

	screw_r = screw_3mm / 2;
	screw_h = ht + 0.2;
	screw_o = (base_t + nut_3mm) / 2;

	difference()
	{
		cube([wid, len, (rod_dia / 2) + base_t]);

		translate([wid / 2, -0.1, 0])
			rotate([-90,0,0])
				cylinder(r=rod_dia / 2, h=len + 0.2);

		translate([screw_o, screw_o, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([screw_o, len - screw_o, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([wid - screw_o, screw_o, -0.1])
			cylinder(r=screw_r, h=screw_h);
		translate([wid - screw_o, len - screw_o, -0.1])
			cylinder(r=screw_r, h=screw_h);

		if(nuts)
		{
			translate([screw_o, screw_o, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([screw_o, len - screw_o, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([wid - screw_o, screw_o, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
			translate([wid - screw_o, len - screw_o, ht - 3])
				hex_nut(nut_3mm, 3.1, 0);
		}
	}
}

rod_clamp(x_axis_rod, 40, nuts=true);
