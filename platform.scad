include <ShefRap_common.scad>;
use <angle.scad>;
use <linear_bearing_block.scad>;
use <leadscrew.scad>;
include <bearing_dims.scad>;

module platform(depth, width, z_bearing, z_sep)
{
	z_dims = get_dims_for_shaft_size(z_bearing, linear_bearing_block_dims);
	z_bb_ht = z_dims[1];
	z_bb_l = z_dims[4];

	rotate([90,0,0])
	union()
	{
		color(bracket_color)
		{
			linear_bearing_block(12);
			translate([z_sep,0,0])
				linear_bearing_block(12);
		}
		translate([width - (width - z_sep) / 2,z_bb_l,z_bb_ht])
			rotate([0,0,180])
				bed(depth, width);
	}
}

module bed(depth, width)
{
		angle(2,50,50,width);
		translate([(width - 50) / 2,0,0])
			mirror([0,0,1])
				drive_bracket();
		translate([0,0,depth])
			rotate([0,90,0])
				angle(2,50,50,depth);
		translate([width,0,depth])
			rotate([0,90,90])
				angle(2,50,50,depth);
}

module drive_bracket()
{
	function mm(inch) = inch * 25.4;

	bore = mm(0.5);
	ht = mm(1.125);
	sm_d = mm(0.875);
	fl_d = mm(1.5);
	fl_w = mm(1.25);
	fl_ht = mm(0.25);
	mnt_cir_r = mm(1.188 / 2);
	mnt_d = mm(0.25);

	union()
	{
		difference()
		{
			angle(2,50,50,50);
			translate([50 / 2, 2.1, 50 / 2])
				rotate([90,0,0])
				{
					cylinder(r=sm_d / 2, h = 2.2);
					for(a = [45,135,225,315])
					{
						rotate([0,0,a])
							translate([mnt_cir_r,0,-0.1])
								cylinder(r = mnt_d / 2, h = fl_ht + 0.2);
					}
				}
		}

		translate([50 / 2, fl_ht + 2.01, 50 / 2])
			rotate([90,0,0])
				color(bracket_color)
					anti_backlash_nut();
	}
}

//drive_bracket();
//bed(200,300);
platform(300, 300, 12, 250);