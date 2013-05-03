module draw_shaft_collar_support(v)
{
	d=v[0];
	w=v[1];
	l=v[2];
	t=v[3];
	f=v[4];
	g=v[5];
	b=v[6];
	s=v[7];

	center = w / 2;
	mnt_ctr = (w - b) / 2;
	dist = (b / 2);
	small_r = (w - b) / 2;
	large_r = (g / 2);
	tan_len = sqrt((dist * dist) 
		- ((large_r - small_r) * (large_r - small_r)));
	tan_ang_sin = (large_r - small_r) / dist;
	tan_ang = asin(tan_ang_sin);
	tan_y = tan_ang_sin * tan_len;
	tan_x = cos(tan_ang) * tan_len;
	trans_ang = 90 + tan_ang;
	trans_x = tan_ang_sin * small_r;
	trans_y = cos(tan_ang) * small_r;
	fill_x1 = dist - tan_x + trans_x;
	fill_y1 = tan_y + trans_y;
	fill_x2 = dist + trans_x;
	fill_y2 = trans_y;

	difference()
	{
		union()
		{
			translate([-b / 2, 0, 0])
				cylinder(h = t, r = (w - b) / 2);
			cylinder(h = l, r = g / 2);
			translate([b / 2, 0, 0])
				cylinder(h = t, r = (w - b) / 2);

			linear_extrude(height=t)
				polygon(points=
					[[fill_x1, fill_y1],[fill_x2,fill_y2],
					[fill_x2,-fill_y2],[fill_x1,-fill_y1],
					[-fill_x1,-fill_y1],[-fill_x2,-fill_y2],
					[-fill_x2,fill_y2],[-fill_x1,fill_y1]],
					paths=[[0,1,2,3,4,5,6,7]], center=false);
		}

		translate([-b / 2, 0, -0.1])
			cylinder(h = t + 0.2, r = s / 2);
		translate([0, 0, -0.1])
			cylinder(h = l + 0.2, r = d /2);
		translate([b / 2, 0, -0.1])
			cylinder(h = t + 0.2, r = s / 2);
	}
}

module shaft_collar_support(shaft_size)
{
	dims = [
		[10, 43, 10, 5, 24, 20, 32, 5.5],
		[12, 47, 13, 7, 28, 25, 36, 5.5],
		[13, 47, 13, 7, 28, 25, 36, 5.5],
		[16, 50, 14, 8, 31, 28, 40, 5.5],
		[20, 60, 20, 8, 37, 34, 48, 7],
		[25, 70, 25, 10, 42, 40, 56, 7],
		[30, 80, 30, 12, 50, 46, 64, 9],
		[35, 92, 35, 14, 58, 50, 72, 12]
	];

	i = search(shaft_size, dims, 1, 0)[0];
	echo(i);
	draw_shaft_collar_support(dims[i]);
}

module flange_bearing(shaft_size)
{
	dims = [
		[8, 57, 11.5, 5.5, 34, 34, 42, 5.5, 4],
		[10, 60, 11.5, 5.5, 36, 36, 45, 5.5, 4],
		[12, 63, 11.5, 5.5, 38, 38, 48, 5.5, 4]
	];

	i = search(shaft_size, dims, 1, 0)[0];
	difference()
	{
		union()
		{
			draw_shaft_collar_support(dims[i]);
			translate([0,0,dims[i][2]])
				cylinder(r=(dims[i][0]/2)+2, h=dims[i][8]);
		}
		translate([0,0,-0.1])
			cylinder(r=(dims[i][0]/2), h=dims[i][2]+dims[i][8]+0.2);
	}
}
