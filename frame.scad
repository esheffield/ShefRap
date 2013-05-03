use <TSlot_v1.0.scad>;
use <shaft_collar_support.scad>;
use <shaft_tee_support.scad>;
use <linear_bearing.scad>;
use <angle.scad>;
use <motors.scad>;

module shef_rap()
{
	width = 500;
	height = 450;
	depth = 500;
	y_rs = 300;
	z_rs = 200;

	translate([0,width,0])
		back(width, height, y_rs, z_rs);

	translate([depth, 0, 0])
		rotate([0,0,180])
			front(width, height, 300);

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

	translate([10,(width / 2) - (y_rs / 2),height - 10])
		rotate([0,90,0])
			cylinder(r=5, h=depth-40);

	translate([10,(width / 2) + (y_rs / 2),height - 10])
		rotate([0,90,0])
			cylinder(r=5, h=depth-40);

	translate([100,(width / 2) + (y_rs / 2),height-10+13])
		rotate([0,0,90])
			linear_bearing_long(10);

	translate([455,(width / 2) - (y_rs / 2),height-10+13])
		rotate([0,0,90])
			linear_bearing_long(10);
}

module front(width, height, rod_spacing)
{
	union()
	{
		front_back(width, height, rod_spacing);
		translate([20,-60,height])
			rotate([0,90,0])
				shaft_bracket();

		translate([20,-(width-60),height])
			rotate([180,-90,0])
				mirror([1,0,0])
				shaft_bracket();

		translate([20+25,0,height-37])
			rotate([90,0,0])
			{
				translate([0,0,50])
				{
					cylinder(r=4, h=((width-100-47) / 2) - 13);
					translate([0,0,40])
						pulley(8);
				}
				translate([0,0,(width / 2) + 19.5 + (47 / 2)])
				{
					cylinder(r=4, h=((width-100-47) / 2) - 20);
					translate([0,0,112]) rotate([180,0,0])
						pulley(8);
				}
				translate([0,0,width / 2 - 25.5])
					rotate([180,0,0])
					coupler_5x8();
				translate([0,0,width / 2 + 30.5])
					coupler_5x8();
				translate([-21,21.25,(width + 47) / 2])
				rotate([90,180,90])
				{
					translate([44.1,0,-4])
						rotate([0,0,180]) difference()
						{
							angle(3,25,50,60);
							translate([23,3.5,25])
								rotate([90,0,0])
									cylinder(r=11, h=4);
						}
					nema_17_dual(47);
				}
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


module back(width, height, y_rs, z_rs)
{
	union()
	{
		front_back(width, height, y_rs);
		translate([20,-(width/2) - (z_rs/2),height-50])
			rotate([90,0,90])
				shaft_tee_support(10);

		translate([20,-(width/2) + (z_rs/2),height-50])
			rotate([90,0,90])
				shaft_tee_support(10);

		translate([20,-(width/2) - (z_rs/2),50])
			rotate([90,0,90])
				shaft_tee_support(10);

		translate([20,-(width/2) + (z_rs/2),50])
			rotate([90,0,90])
				shaft_tee_support(10);

		translate([20 + 20,-(width/2) - (z_rs/2),40])
			rotate([0,0,0])
				cylinder(r=5, h=height-80);

		translate([20 + 20,-(width/2) + (z_rs/2),40])
			rotate([0,0,0])
				cylinder(r=5, h=height-80);
	}
}

module front_back(width, height, rod_spacing)
{
	rs = rod_spacing;

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

		translate([10, -((width / 2) - (rs / 2) - 20), height - 10])
			rotate([90,0,90])
				shaft_collar_support(10);

		translate([10, -((width / 2) + (rs / 2) - 20), height - 10])
			rotate([90,0,90])
				shaft_collar_support(10);
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

module pulley(bore)
{
	difference()
	{
		union()
		{
			cylinder(r=6.5, h=16);
			cylinder(r=9, h=1);
			translate([0,0,9])
			cylinder(r=9, h=7);
		}
		translate([0,0,-0.1])
			cylinder(r=bore/2, h=16.2);
	}
}

//pulley(8);
shef_rap();
//front(490,450,300);