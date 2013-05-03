module angle(thickness, width, height, length)
{
	color([0.5,0.5,0.5])
	union()
	{
		cube([length,width,thickness]);
		cube([length,thickness,height]);
	}
}
