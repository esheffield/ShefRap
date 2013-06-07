include <ShefRap_common.scad>;
use <TSlot_v1.0.scad>;
use <shaft_collar_support.scad>;
use <shaft_tee_support.scad>;
use <linear_bearing_block.scad>;
use <angle.scad>;
use <motors.scad>;
use <x_carriage_assembly_v2.scad>;
use <pulley.scad>;
use <platform.scad>;

width = 520;
height = 500;
depth = 500;
y_rs = 350;
z_rs = 250;
rod_offset = (width - y_rs) / 2;
z_rod_offset = (width - z_rs) / 2;

module shef_rap()
{

	translate([0,width,0])
		back(width, height, y_rs, z_rs);

	translate([depth, 0, 0])
		rotate([0,0,180])
			front(width, height, y_rs);

	translate([20,10,10])
		rotate([0,90,0])
		 		tslot2020(depth-40);

	translate([20,width - 10,10])
		rotate([0,90,0])
		 		tslot2020(depth-40);

	translate([20,10,height - 10])
		rotate([0,90,0])
		 		tslot2020(depth-40);

	translate([20,width - 10,height - 10])
		rotate([0,90,0])
		 		tslot2020(depth-40);

	translate([0,0,height - 50])
		gantry();
}

module gantry()
{
	translate([20,rod_offset,0])
		rotate([0,90,0]) color(rod_color)
			cylinder(r=5, h=depth-40);

	translate([20,rod_offset+y_rs,0])
		rotate([0,90,0]) color(rod_color)
			cylinder(r=5, h=depth-40);

	translate([200,rod_offset,0])
		rotate([0,0,90])
			x_carriage_assembly(y_rs);
}

module pulley_mount()
{
	union()
	{
		rotate([90,0,0])
		color([0.4,0.4,0.4])
			angle(3,25,50,50);

		translate([15,-35,4])
			pulley(5);
		translate([35,-15,20])
			rotate([180,0,0])
			pulley(5);
	}
}

module front(width, height, y_rs)
{
	rod_1_loc = -rod_offset;
	rod_2_loc = rod_1_loc - y_rs;

	union()
	{
		front_back(width, height, y_rs);

		// Y Rod Supports
		color(bracket_color)
		{
			translate([20, rod_2_loc, height - 50])
				rotate([90,0,90])
					shaft_collar_support(10);

			translate([20, rod_1_loc, height - 50])
				rotate([90,0,90])
					shaft_collar_support(10);
		}

		// Pulley Assemblies
		translate([20,-70,height - 34])
			rotate([0,0,90])
				pulley_mount();

		translate([20,-width + 70,height - 34])
			rotate([0,0,90])
				mirror([1,0,0])
					pulley_mount();
	}
}

module motor_and_bracket()
{
	// Motor, mount, and coupler
	rotate([90,180,90])
	{
		// Motor mount
		translate([42,0,-8])
		rotate([180,180,0]) difference()
		{
			color([0.8,0.8,0.8])
				angle(3,25,50,42);
			translate([42-21,3.5,29])
				rotate([90,0,0])
					cylinder(r=11, h=4);
		}
		// Motor
		nema_17(40);

		translate([21,-23,21])
		rotate([270,0,0])
			pulley(5);
	}
}

module back(width, height, y_rs, z_rs)
{
	rod_1_loc = -width + rod_offset;
	rod_2_loc = rod_1_loc + y_rs;

	z_rod_1_loc = -width + z_rod_offset;
	z_rod_2_loc = z_rod_1_loc + z_rs;

	b_rot = 0; //asin(20 / 32);
	y_rod_ht = 50;

	union()
	{
		front_back(width, height, y_rs);

		color(bracket_color)
		{
			// Y Rod Supports
			translate([20, rod_2_loc, height - y_rod_ht])
				rotate([90,b_rot,90])
					shaft_collar_support(10);

			translate([20, rod_1_loc, height - y_rod_ht])
				rotate([90,-b_rot,90])
					shaft_collar_support(10);

			// Z Rod Supports
			translate([20,z_rod_1_loc,height - 50])
				rotate([90,0,90])
					shaft_tee_support(12);

			translate([20,z_rod_2_loc,height - 50])
				rotate([90,0,90])
					shaft_tee_support(12);

			translate([20,z_rod_1_loc,50])
				rotate([90,0,90])
					shaft_tee_support(12);

			translate([20,z_rod_2_loc,50])
				rotate([90,0,90])
					shaft_tee_support(12);
		}

		// Z Rods
		color(rod_color)
		{
			translate([20 + 23,z_rod_1_loc,40])
				rotate([0,0,0])
					cylinder(r=6, h=height-80);

			translate([20 + 23,z_rod_2_loc,40])
				rotate([0,0,0])
					cylinder(r=6, h=height-80);
		}

		translate([28,-width + 20 + 42,height - 43])
			rotate([0,0,0])
				motor_and_bracket();

		translate([28,-20,height - 43])
			rotate([0,0,0])
				motor_and_bracket();

		translate([20 + 23,z_rod_1_loc,60])
			rotate([0,0,90])
				platform(300,300,12,z_rs);
	}
}

module front_back(width, height)
{
	translate([10,-20,0])
	union()
	{
		translate([0,0,30])
			rotate([90,0,0])
				tslot2060(width - 40);

		translate([0,10,0])
			tslot2020(height);

		translate([0,-(width - 40 + 10),0])
			tslot2020(height);

		translate([0,0,(height - 30)])
			rotate([90,0,0])
				tslot2060(width - 40);
	}
}

module coupler_5x8()
{
	color(pulley_color)
	difference()
	{
		cylinder(r=9, h=25);
		translate([0,0,-0.2])
			cylinder(r=2.5, h=13);
		translate([0,0,12.5])
			cylinder(r=4, h=13);
	}
}


//pulley(8);
shef_rap();
//front(490,450,300);