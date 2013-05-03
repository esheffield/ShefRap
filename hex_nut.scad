module hex_nut(width, height, screw)
{
	w = width;
	w2 = width / 2;
	s = w2 / cos(30);
	h = w2 * tan(30);
	
	translate([-s/2, -w2, 0])
	difference()
	{
		linear_extrude(height=height)
			polygon([[0,0],[s,0],[s+h,w2],[s,w],[0,w],[-h,w2],[0,0]]);
		translate([s/2, w2, -0.1])
			cylinder(r = screw / 2, h = height+0.2, $fn=20);
	}
}

hex_nut(5.25, 2, 3);