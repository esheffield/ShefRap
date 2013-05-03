include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <x_end_bottom_v2.scad>;
use <x_end_top_v2.scad>;
use <extruder_carriage.scad>;
use <motors.scad>;
use <pulley.scad>;

module x_carriage_assembly(y_separation)
{
	x_bearing = x_axis_rod;
	y_bearing = y_axis_rod;

	x_end_top_length = (2 * (base_t + nut_3mm) + x_axis_rod);
	x_end_width =  y_axis_bearing_wid;
	x_end_length = y_axis_bearing_len + (2 * x_end_top_length);

	thickness = (x_bearing / 2) + base_t;
	rod_len = y_separation + y_axis_bearing_wid;
	x_rod_offset = base_t + nut_3mm + x_axis_rod / 2;

	mnt_len = 40;

	union()
	{
		translate([-x_end_width / 2,0,0])
		{
			x_end_bottom();

			translate([0, 0, thickness])
				x_end_top();

			translate([0, x_axis_rod_separation, thickness])
				x_end_top();

			translate([y_separation, 0, 0])
			{
				x_end_bottom(10,10);

				translate([0, 0, thickness])
					x_end_top();

				translate([0, x_axis_rod_separation, thickness])
					x_end_top();
			}
		}
/*
		translate([-(x_end_width / 2), x_end_length - mnt_len, (y_b_dia / 2) + (thickness * 2)])
			x_motor_mount(x_end_width, mnt_len=mnt_len, show_motor=true);
*/
		color([0.8,0.8,0.8])
		{
			translate([-((x_end_width / 2)), 
					x_rod_offset, 
					base_t + (x_bearing / 2)])
				rotate([0,90,0])
					cylinder(r = x_bearing / 2, h = rod_len);
			translate([-((x_end_width / 2)), 
					x_rod_offset + x_axis_rod_separation, 
					base_t + (x_bearing / 2)])
				rotate([0,90,0])
					cylinder(r = x_bearing / 2, h = rod_len);
		}

/*
		translate([x_end_width / 2 + 10, 
					x_rod_offset, 
					(y_b_dia / 2) + base_t + (x_bearing / 2)])
			extruder_carriage(10, show_bearing=true);
*/
	}
}

module x_motor_mount(x_end_width, mnt_len = 40, thickness = 3, show_motor = false)
{
	offset = 17;
	slot_len = 5;
	margin = 2;
	motor_h = get_nema_17_size() + (margin * 2);
	motor = get_nema_17_size() + slot_len + (margin * 2);

	union()
	{
		cube([x_end_width, mnt_len, thickness]);
		translate([-thickness, 0, -(offset - thickness)])
			cube([thickness, mnt_len + thickness, motor_h]);
		translate([-(thickness + motor), 0, -offset])
			cube([motor + thickness, mnt_len + thickness, thickness]);
		translate([-(motor + thickness), (mnt_len + thickness), -(offset - thickness)])
			rotate([90,0,0])
				nema_17_plate(slot_len=slot_len, margin=margin);

		translate([0, mnt_len + thickness, 0])
			rotate([90,0,0])
				linear_extrude(height = thickness)
					polygon(points=[[0,-offset],[x_end_width,0],
							[x_end_width,thickness],
							[0, motor_h - offset + thickness],
							[0, -offset]]);
		if (show_motor)
		{
			translate([-(thickness + margin + slot_len / 2), mnt_len, -(offset - thickness - margin)])
				rotate([0, 0, 180])
				{
					nema_17(40);
					translate([21,-4,21])
					rotate([90,0,0])
						pulley(5);
				}
		}
	}
}

x_carriage_assembly(300, $fn=80);
//x_motor_mount(45.2);