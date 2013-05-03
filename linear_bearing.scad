include <bearing_dims.scad>;

module draw_linear_bearing(v)
{
	bore = v[0];
	outer = v[1];
	len = v[2];
	ring_space = v[3];
	ring_dia = v[4];
	ring_gap = v[5];

	ends_len = (len - ring_space) / 2;
	ctr_len = ring_space - (ring_gap * 2);

	difference()
	{
		union()
		{
			cylinder(r=ring_dia / 2, h = len);
			cylinder(r=outer / 2, h = ends_len);
			translate([0, 0, ends_len + ring_gap])
				cylinder(r=outer / 2, h = ctr_len);
			translate([0, 0, ends_len + ring_space])
				cylinder(r=outer / 2, h = ends_len);
		}

		translate([0, 0, -0.1])
			cylinder(r=bore / 2, h = len + 0.2);
	}
}

module linear_bearing(shaft_size)
{
	d = get_dims_for_shaft_size(shaft_size, linear_bearing_dims);
	draw_linear_bearing(d);
}

linear_bearing(10);