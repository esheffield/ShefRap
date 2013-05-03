include <bearing_dims.scad>;

module draw_linear_bearing_block(v)
{
	d = v[0];
	h = v[1];
	e = v[2];
	w = v[3];
	l = v[4];
	f = v[5];
	g = v[6];
	b = v[7];
	c = v[8];
	k = v[9];
	t = v[10];
	s1 = v[11];
	s2 = v[12];
	L1 = v[13];

	st = (k - (s2 / 2)) / 2;
	t1 = t + st;
	h1 = f - g;
	p1 = (w - (2 * h1 + 2 * st)) / 4;
	c1 = (l - c) / 2;

	translate([-w/2,0,h])
	rotate([90,180,180])
	difference()
	{
		linear_extrude(height=l)
			polygon(points=[
				[0,0],[w,0],[w,t],[w-st,t1],[w-st,g],
				[w-st-p1,g],[w-st-p1-h1,f],[st+p1+h1,f],
				[st+p1,g],[st,g],[st,t1],[0,t]],
				path=[0,1,2,3,4,5,6,7,8,9,10,11]);

		translate([e,h,-0.1])
			cylinder(r=d/2, h=l+0.2, center=false);

		translate([k,L1,c1]) rotate([90,0,0])
			cylinder(r=s1/2, h=L1+0.1, center=false);
		translate([k,L1,c+c1]) rotate([90,0,0])
			cylinder(r=s1/2, h=L1+0.1, center=false);
		translate([w-k,L1,c1]) rotate([90,0,0])
			cylinder(r=s1/2, h=L1+0.1, center=false);
		translate([w-k,L1,c+c1]) rotate([90,0,0])
			cylinder(r=s1/2, h=L1+0.1, center=false);

		translate([k,g+0.1,c1]) rotate([90,0,0])
			cylinder(r=s2/2, h=g+0.1, center=false);
		translate([k,g+0.1,c+c1]) rotate([90,0,0])
			cylinder(r=s2/2, h=g+0.1, center=false);
		translate([w-k,g+0.1,c1]) rotate([90,0,0])
			cylinder(r=s2/2, h=g+0.1, center=false);
		translate([w-k,g+0.1,c+c1]) rotate([90,0,0])
			cylinder(r=s2/2, h=g+0.1, center=false);
	}
}

module linear_bearing_mount_holes(dims, depth)
{
	w = dims[3];
	l = dims[4];
	c = dims[8];
	k = dims[9];
	s2 = dims[12];

	c1 = (l - c) / 2;

	translate([k,c1,0])
		cylinder(r=s2/2, h=depth, center=false);
	translate([k,c+c1,0])
		cylinder(r=s2/2, h=depth, center=false);
	translate([w-k,c1,0])
		cylinder(r=s2/2, h=depth, center=false);
	translate([w-k,c+c1,0])
		cylinder(r=s2/2, h=depth, center=false);

}

module linear_bearing_block(shaft_size)
{
	d = get_dims_for_shaft_size(shaft_size, linear_bearing_block_dims);
	draw_linear_bearing_block(d);
}

module linear_bearing_long_block(shaft_size)
{
	d = get_dims_for_shaft_size(shaft_size, linear_bearing_long_block_dims);
	draw_linear_bearing_block(d);
}

linear_bearing_block(10);
translate([50,0,0])
	linear_bearing_long_block(10);