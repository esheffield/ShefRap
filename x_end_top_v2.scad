include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <hex_nut.scad>;

module x_end_top()
{
	thickness = (x_axis_rod / 2) + base_t;

	nut = nut_3mm;

	width =  y_axis_bearing_wid;
	length = (2 * (base_t + nut) + x_axis_rod);

	echo(width);
	echo(length);
	echo(thickness);
	echo(y_axis_bearing_rod_clr);

	y_offset_1 = (nut / 2) + 2;
	y_offset_2 = (base_t + nut) + x_axis_rod + y_offset_1;

	difference()
	{
		union()
		{
			cube([width, length, thickness]);
		}

		translate([-0.1, (base_t + nut + (x_axis_rod / 2)), 0])
			rotate([0,90,0])
				cylinder(r = x_axis_rod / 2, h = width + 0.2);

		translate([(nut/2)+2, y_offset_1,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), y_offset_1,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([(nut/2)+2, length - y_offset_1,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), length - y_offset_1,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 0.2);
		}
	}
}

x_end_top($fn=80);