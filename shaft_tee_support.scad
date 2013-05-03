module draw_shaft_tee_support(v)
{
	d=v[0];
	h=v[1];
	w=v[2];
	l=v[3];
	f=v[4];
	g=v[5];
	p=v[6];
	b=v[7];
	s=v[8];

	tab = (w - p) /2;
	center = w / 2;
	mnt_ctr = (w - b) / 2;
	
	translate([-center,-l/2,0])
	difference()
	{
		union()
		{
			cube(size=[tab, l, g], center=false);
			translate(v = [tab, 0, 0])
			{
				cube(size=[p, l, f], center=false);
				translate(v = [p, 0, 0])
				{
					cube(size=[tab, l, g]);
				}
			}
		}
		translate(v = [mnt_ctr, l / 2, g / 2])
		{
			cylinder(h = g * 1.1, r = s / 2, center = true);
		}
		translate(v = [mnt_ctr + b, l / 2, g / 2])
		{
			cylinder(h = g * 1.1, r = s / 2, center = true);
		}
		translate([center, l / 2, h]) rotate([90, 0, 0])
		{
			cylinder(h = l * 1.1, r = d / 2, center = true);
		}
	}
}

module shaft_tee_support(shaft_size)
{
	dims = [
		[8, 20, 42, 14, 32.8, 6, 18, 32, 5.5],
		[10, 20, 42, 14, 32.8, 6, 18, 32, 5.5],
		[12, 23, 42, 14, 37.5, 6, 20, 32, 5.5],
		[13, 23, 42, 14, 37.5, 6, 20, 32, 5.5],
		[16, 27, 48, 16, 44, 8, 25, 38, 5.5],
		[20, 31, 60, 20, 51, 10, 30, 45, 6.6],
		[25, 35, 70, 24, 60, 12, 38, 56, 6.6],
		[30, 42, 84, 28, 70, 12, 44, 64, 9],
		[35, 50, 98, 32, 82, 15, 50, 76, 11],
		[40, 60, 114, 36, 96, 15, 60, 90, 11],
		[50, 70, 126, 40, 120, 18, 74, 100, 14],
		[60, 80, 148, 45, 136, 18, 90, 120, 14]
	];

	i = search(shaft_size, dims, 1, 0)[0];
	draw_shaft_tee_support(dims[i]);
}

shaft_tee_support(10);