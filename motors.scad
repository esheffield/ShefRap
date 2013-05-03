module draw_nema(v, length)
{
	// Body size
	bs = v[0];
	// Hole spacing
	hs = v[1];
	// Hole offset
	ho = (bs - hs) / 2;
	// Hole diameter
	hd = v[2];
	// Hole radius
	hr = hd / 2;
	// Hole depth
	hd = v[3];
	// Center
	c = bs / 2;
	// Shoulder height
	sh = v[4];
	// Shoulder diameter
	sd = v[5];
	// shoulder radius
	sr = sd / 2;
	// Shaft length
	sfl = v[6];
	// Shaft diameter
	sfd = v[7];
	// Shaft radius
	sfr = sfd / 2;

	echo(bs);
	echo (bs-ho);

	difference()
	{
		union()
		{
			color([0.5,0.5,0.5]) cube([bs,length,bs]);
			translate([c,-sh,c]) rotate([270,0,0])
				color([0.7,0.7,0.7]) cylinder(r = sr, h = sh);
			translate([c,-sfl,c]) rotate([270,0,0])
				color([0.8,0.8,0.8]) cylinder(r = sfr, h = sfl);
		}
		translate([ho,-0.1,ho]) rotate([270,0,0])
			cylinder(r = hr, h = hd + 0.1);
		translate([bs-ho,-0.1,ho]) rotate([270,0,0])
			cylinder(r = hr, h = hd + 0.1);
		translate([ho,-0.1,bs-ho]) rotate([270,0,0])
			cylinder(r = hr, h = hd + 0.1);
		translate([bs-ho,-0.1,bs-ho]) rotate([270,0,0])
			cylinder(r = hr, h = hd + 0.1);
	}
}

module draw_nema_plate(v, slot_len=0, thickness = 3, margin = 0)
{
	// Body size
	bs = v[0];
	// Hole spacing
	hs = v[1];
	// Hole diameter
	hd = v[2];
	// Hole radius
	hr = hd / 2;
	// Total slot len
	tsl = slot_len + hd;
	// Total len
	len = bs + slot_len + (margin * 2);
	// Total hgt
	hgt = bs + (margin * 2);
	// Center
	c_y = hgt / 2;
	c_x = len / 2;
	// Hole offset from ctr
	ho = hs / 2;
	// Shoulder diameter
	sd = v[5];
	// shoulder radius
	sr = sd / 2;

	difference()
	{
		cube([len, hgt, thickness]);
		translate([c_x - (slot_len / 2), c_y, -0.1])
			cylinder(r=sr + 0.1, h=thickness + 0.2);
		translate([c_x + (slot_len / 2), c_y, -0.1])
			cylinder(r=sr + 0.1, h=thickness + 0.2);
		translate([bs / 2, ((hgt - sd) / 2) - 0.1, -0.1])
			cube([slot_len, sd + 0.2, thickness + 0.2]);

		for(c = [[c_x - ho, c_y - ho], [c_x - ho, c_y + ho],
				  [c_x + ho, c_y - ho], [c_x + ho, c_y + ho]])
		{
			translate([c[0] - (slot_len / 2), c[1], -0.1])
				cylinder(r=hr + 0.05, h=thickness + 0.2);
			translate([c[0] + (slot_len / 2), c[1], -0.1])
				cylinder(r=hr + 0.05, h=thickness + 0.2);
			translate([c[0] - (slot_len / 2), c[1] - (hr + 0.05), -0.1])
				cube([slot_len, hd + 0.1, thickness + 0.2]);			
		}
	}
}

nema_17_dims = [42.3,31,3,4.5,2,22,24,5];
nema_23_dims = [57,47,5.1,4.5,2,38.1,24,10];

function get_nema_17_size() = nema_17_dims[0];
function get_nema_23_size() = nema_23_dims[0];

module nema_17(length)
{
	v=[42.3,31,3,4.5,2,22,24,5];
	draw_nema(v, length);
}

module nema_17_dual(length)
{
	v=[42.3,31,3,4.5,2,22,19.5,5];
	c = v[0] / 2;
	sfr = v[7] / 2;
	union()
	{
		draw_nema(v, length);
		translate([c,length,c]) rotate([270,0,0])
			color([0.8,0.8,0.8]) cylinder(r = sfr, h = 13);
	}
}

module nema_17_plate(slot_len=0, thickness = 3, margin = 0)
{
	v=[42.3,31,3,4.5,2,22,24,5];

	draw_nema_plate(v, slot_len, thickness, margin);
}

module nema_23(length)
{
	v=[57,47,5.1,4.5,2,38.1,24,10];
	draw_nema(v, length);
}

module nema_23_plate(slot_len=0, thickness = 3)
{
	v=[57,47,5.1,4.5,2,38.1,24,10];
	draw_nema_plate(v, slot_len, thickness);
}

$fn = 20;
nema_17_plate(slot_len=5, margin=2);
//nema_17_dual(42.3);
//translate([60,0,0]) nema_23(57);