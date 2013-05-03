include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <linear_bearing_block.scad>;
use <hex_nut.scad>;

function get_end_thickness() = (x_axis_rod / 2) + base_t;

function get_mount_pad_hgt() = get_end_thickness() - y_axis_bearing_rod_clr + 1;

module x_end_bottom()
{
	thickness = get_end_thickness();

	nut = nut_3mm;

	width =  y_axis_bearing_wid;
	length = y_axis_bearing_len + (2 * (2 * (base_t + nut) + x_axis_rod));

	//echo(width);
	//echo(length);
	//echo(thickness);

	y_offset_1 = (nut / 2) + 2;
	y_offset_2 = (base_t + nut) + x_axis_rod + y_offset_1;

	mount_pad_hgt = get_mount_pad_hgt();

	//translate([-width / 2, 0, 0])
	difference()
	{
		union()
		{
			cube([width, length, thickness]);
			translate([0, (length - y_axis_bearing_len) / 2, thickness])
				cube([width, y_axis_bearing_len, mount_pad_hgt]);

			translate([y_axis_bearing_wid / 2,
						(length - y_axis_bearing_len) / 2,
						y_axis_bearing_mid_hgt + thickness + mount_pad_hgt])
				rotate([0,180,0])
					color([0.6,0.6,0.6]) 
						linear_bearing_block(y_axis_rod);
		}

		translate([-0.1, (base_t + nut + (x_axis_rod / 2)), thickness])
			rotate([0,90,0])
				cylinder(r = x_axis_rod / 2, h = width + 0.2);
		translate([-0.1, length - (4 + nut + (x_axis_rod / 2)), thickness])
			rotate([0,90,0])
				cylinder(r = x_axis_rod / 2, h = width + 0.2);

		translate([(nut/2)+2, y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([(nut/2)+2, length - y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), length - y_offset_1,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}

		translate([(nut/2)+2, y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([(nut/2)+2, length - y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}
		translate([width - ((nut/2)+2), length - y_offset_2,-0.1])
		{
			rotate([0,0,30])
				hex_nut(nut, 2.1, 3);
			cylinder(r = 1.52, h = thickness + 0.2);
		}

		translate([0,(length - y_axis_bearing_len) / 2,-0.1])
			linear_bearing_mount_holes(y_axis_bearing_dims, thickness + mount_pad_hgt + 0.2);
	}
}

x_end_bottom($fn=80);