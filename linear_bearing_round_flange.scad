include <bearing_dims.scad>;

module draw_linear_bearing_round_flange(v)
{
	d = v[0];
	D = v[1];
	L = v[2];
	D1 = v[3];
	H = v[4];
	pcd = v[5];
	d1 = v[6];
	d2 = v[7];
	h = v[8];

	difference()
	{
		union()
		{
			cylinder(r=D1 / 2, h=H, center=false);
			cylinder(r=D / 2, h=L, center=false);
		}

		translate([0,0,-0.1])
			cylinder(r=d / 2, h=L+0.2, center=false);

		for(i = [0,90,180,270])
		{
			rotate([0,0,i]) translate([pcd / 2,0,0])
			{
				translate([0,0,-0.1])
					cylinder(r=d1 / 2, h=H+0.2, center=false);
				translate([0,0,-0.1])
					cylinder(r=d2 / 2, h=h+0.1, center=false);
			}
		}
	}
}

module linear_bearing_round_flange(shaft_size)
{
	d = get_dims_for_shaft_size(shaft_size, linear_bearing_round_flange_dims);
	draw_linear_bearing_round_flange(d);
}

linear_bearing_round_flange(10);