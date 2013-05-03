module tube(size, length)
{
	cube([length, size, size]);
}

module angle(size, thickness, length)
{
	s = size;
	t = thickness;
	l = length;

	union()
	{
		cube([s, t, l]);
		cube([t, s, l]);
	}
}

angle(18, 3, 300);