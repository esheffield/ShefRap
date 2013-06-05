use <ShefRap_common.scad>;
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
rod_offset = 85; //110;
z_rod_offset = rod_offset + 50;

module shef_rap()
{

	translate([0,width,0])
		back(width, height, y_rs, z_rs);

	translate([depth, 0, 0])
		rotate([0,0,180])
			front(width, height, y_rs);
/*
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
*/
	translate([0,0,height - 50])
		gantry();
}

module gantry()
{
	translate([20,rod_offset,0])
		rotate([0,90,0]) color([0.6, 0.6, 0.6])
			cylinder(r=5, h=depth-40);

	translate([20,rod_offset+y_rs,0])
		rotate([0,90,0]) color([0.6, 0.6, 0.6])
			cylinder(r=5, h=depth-40);

	translate([80,rod_offset,0])
		rotate([0,0,90])
			x_carriage_assembly(y_rs);
}

module front(width, height, y_rs)
{
	rod_1_loc = -rod_offset;
	rod_2_loc = rod_1_loc - y_rs;

	union()
	{
		front_back(width, height, y_rs);

		// Y-axis rod supports
		translate([20, rod_2_loc, height - 50])
			rotate([90,0,90])
				shaft_collar_support(10);

		translate([20, rod_1_loc, height - 50])
			rotate([90,0,90])
				shaft_collar_support(10);

	}
}

module y_drive()
{
		// Y-drive
		// Shaft support bearings
		translate([20,-y_rs-80,height])
			rotate([0,90,0])
				shaft_bracket();

		translate([20,-140,height])
			rotate([180,-90,0])
				mirror([1,0,0])
				shaft_bracket();

		// Shaft and motor assemblies
		translate([20+25,0,height-37])
			rotate([90,0,0])
			{
				// Drive shaft & pulleys
				translate([0,0,84.5])
				{
					cylinder(r=4, h=y_rs+33);
					translate([0,0,20])
						pulley(8);
					translate([0,0,y_rs+30]) rotate([180,0,0])
						pulley(8);
				}

				// Motor, mount, and coupler
				translate([-21,21,60])
				rotate([90,180,90])
				{
					// Motor mount
					translate([-16,0,-4])
						rotate([0,0,0]) difference()
						{
							angle(3,25,50,60);
							translate([60-23,3.5,25])
								rotate([90,0,0])
									cylinder(r=11, h=4);
						}
					// Motor
					nema_17(40);
					//Coupler
					translate([21.15,-11.5,21.15])
						rotate([90,0,0])
							coupler_5x8();
				}
			}

}

module shaft_bracket()
{
	difference()
	{
		union()
		{
			angle(3,25,50,60);
			translate([37,0,25])
				rotate([90,45,0])
					flange_bearing(8);
		}
		translate([37,-0.5,25])
			rotate([0,90,90])
			cylinder(r=4,h=4);
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

		translate([20, rod_2_loc, height - y_rod_ht])
			rotate([90,b_rot,90])
				shaft_collar_support(10);

		translate([20, rod_1_loc, height - y_rod_ht])
			rotate([90,-b_rot,90])
				shaft_collar_support(10);


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

		translate([20 + 23,z_rod_1_loc,40])
			rotate([0,0,0])
			{
				cylinder(r=6, h=height-80);
			}
		translate([20 + 23,z_rod_2_loc,40])
			rotate([0,0,0])
			{
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
	color([0.9,0.9,0.9])
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