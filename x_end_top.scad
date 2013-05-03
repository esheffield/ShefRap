include <ShefRap_common.scad>;
include <bearing_dims.scad>;
use <linear_bearing_mount.scad>;
use <hex_nut.scad>;
use <motors.scad>;

module x_end_top(x_bearing, y_bearing, with_motor_mount=false, show_motor=false)
{
	x_dims = get_dims_for_shaft_size(x_bearing, linear_bearing_dims);
	x_b_dia = x_dims[1] + clearance;
	x_b_len = x_dims[2] + clearance;

	x_bb_dims = get_bb_dims(x_b_dia, x_b_len);
	x_bb_w = x_bb_dims[0];
	x_bb_d = x_bb_dims[1];
	x_bb_h = x_bb_dims[2];
	x_bb_g = x_bb_dims[3];
	x_bb_len = x_bb_dims[4];

	y_dims = get_dims_for_shaft_size(y_bearing, linear_bearing_dims);
	y_b_dia = y_dims[1] + clearance;		// Outer diameter of 10mm linear bearing
	y_b_len = y_dims[2] + clearance;		// Bearing length

	y_bb_dims = get_bb_dims(y_b_dia, y_b_len);
	y_bb_w = y_bb_dims[0];		// Individual bearing block width
	y_bb_d = y_bb_dims[1];		// ... depth
	y_bb_h = y_bb_dims[2];		// ... height
	y_bb_g = y_bb_dims[3];		// ... and gap spacing between blocks
	y_bb_len = y_bb_dims[4];	// Total bearing block length

	thickness = (x_bearing / 2) + base_t;
	echo(thickness);

	nut = nut_3mm;

	p_w = (2 * x_bb_d) + ex_hole_w + ex_hole_space;

	width = y_bb_d + (2 * (4 + nut));
	length = p_w;

	ctr_x = width / 2;
	ctr_y = length / 2;
	
	y_offset_1 = ((x_bb_d / 2) - (x_bearing / 2)) / 2;
	y_offset_2 = ((x_bb_d / 2) + (x_bearing / 2)) + y_offset_1;

	translate([width / 2, 0, thickness])
	rotate([0,180,0])
	difference()
	{
		union()
		{
			cube([width, length, thickness]);
			if(with_motor_mount)
			{
				translate([width, length-40, 0])
				rotate([0,180,0])
					x_motor_mount(width, show_motor=show_motor);
			}
		}

		translate([-0.1, x_bb_d / 2, thickness])
			rotate([0,90,0])
				cylinder(r = x_bearing / 2, h = width + 0.2);
		translate([-0.1, length - (x_bb_d / 2), thickness])
			rotate([0,90,0])
				cylinder(r = x_bearing / 2, h = width + 0.2);

		translate([(nut/2)+2, y_offset_1,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([width - ((nut/2)+2), y_offset_1,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([(nut/2)+2, y_offset_2,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([width - ((nut/2)+2), y_offset_2,-0.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}

		color([1,0,0])
		{
		translate([(nut/2)+2, length - y_offset_1,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([width - ((nut/2)+2), length - y_offset_1,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([(nut/2)+2, length - y_offset_2,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		translate([width - ((nut/2)+2), length - y_offset_2,-3.1])
		{
			cylinder(r = 1.52, h = thickness + 3.2, $fn=20);
		}
		}
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
			nema_17(40);
		}
	}
}


x_end_top(10,10,with_motor_mount=true,show_motor=true);