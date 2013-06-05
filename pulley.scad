module pulley(bore)
{
	color([0.7,0.7,0.7])
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
