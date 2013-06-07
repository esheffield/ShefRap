include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <extruder_carriage_v2.scad>;
use <motors.scad>;
use <pulley.scad>;
use <rod_clamp.scad>;
use <linear_bearing_block.scad>;

module x_carriage_assembly(y_separation)
{
	clamp_ht = x_axis_rod / 2 + base_t;
	x_end_width =  y_axis_bearing_wid;
	x_rod_offset = base_t + nut_3mm + x_axis_rod / 2;
	rod_len = y_separation + y_axis_bearing_wid;
	thickness = y_axis_carriage_thickness;

	translate([0, 0, (clamp_ht * 2 + thickness + y_axis_bearing_mid_hgt)])
	rotate([180,0,0])
	union()
	{
		y_carriage_end(y_separation);

		translate([rod_len - y_axis_bearing_wid, 0, 0])
		{
			mirror([1,0,0])
			y_carriage_end(y_separation);
		}


		color(rod_color)
		{
			translate([-((y_axis_bearing_wid / 2)), 
					x_rod_offset, 
					base_t + x_axis_rod / 2])
				rotate([0,90,0])
					cylinder(r = x_axis_rod / 2, h = rod_len);
			translate([-((y_axis_bearing_wid / 2)), 
					x_rod_offset + x_axis_rod_separation, 
					base_t + x_axis_rod / 2])
				rotate([0,90,0])
					cylinder(r = x_axis_rod / 2, h = rod_len);
		}

		translate([(y_separation - ex_carriage_len) / 2, 
					x_rod_offset + x_axis_rod_separation, 
					base_t + x_axis_rod / 2])
			rotate([180,0,0])
			extruder_carriage(show_bearing=true);

	}
}

module y_carriage_end(y_separation)
{
	x_bearing = x_axis_rod;
	y_bearing = y_axis_rod;

	x_end_width =  y_axis_bearing_wid;
	x_end_length = y_axis_carriage_wid;

	clamp_ht = x_axis_rod / 2 + base_t;
	clamp_wid = x_axis_rod + (2 * (base_t + nut_3mm));
	thickness = 6;
	rod_len = y_separation + y_axis_bearing_wid;
	x_rod_offset = base_t + nut_3mm + x_axis_rod / 2;
	hole_offset = (x_end_length - y_axis_bearing_hole_len) / 2;

	translate([-x_end_width / 2, 0, 0])
	{
		translate([-20, 0, clamp_ht * 2])
		{
			difference()
			{
				color(pla_color)
					cube([x_end_width + 20, x_end_length, thickness]);
				translate([20,0,thickness])
					rotate([180,0,90])
						rod_clamp_holes(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
				translate([20,x_end_length - clamp_wid,thickness])
					rotate([180,0,90])
						rod_clamp_holes(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
			}
			translate([10,(x_end_length / 2) - hole_offset,-1])
				rotate([180,0,0])
					pulley(5);
			translate([10,(x_end_length / 2) + hole_offset,-1])
				rotate([180,0,0])
					pulley(5);
		}

		translate([y_axis_bearing_wid / 2,
					(x_end_length - y_axis_bearing_len) / 2,
					y_axis_bearing_mid_hgt + thickness + clamp_ht * 2])
			rotate([0,180,0])
				color([0.6,0.6,0.6]) 
					linear_bearing_long_block(y_axis_rod);

		color(pla_color)
		{
			translate([0, 0, clamp_ht])
			{
				rotate([180,0,90])
					rod_clamp(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
				translate([x_end_width, 0, 0])
					rotate([0,0,90])
						rod_clamp(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
			}

			translate([0, x_end_length - clamp_wid, clamp_ht])
			{
				rotate([180,0,90])
					rod_clamp(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
				translate([x_end_width, 0, 0])
					rotate([0,0,90])
						rod_clamp(x_axis_rod, x_end_width, y_axis_bearing_hole_wid);
			}
		}
	}
}

x_carriage_assembly(350, $fn=80);
//x_motor_mount(45.2);