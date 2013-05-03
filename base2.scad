use<material.scad>

module base(tubesize, d)
{
	ts = tubesize;
	w = d[0];
	l = d[1];
	h = d[2];
	t = d[3];

	//translate([ts,0,0]) rotate([0,0,90]) 
	union()
	{
		translate([ts,0,0])
			tube(ts, l-(ts*2));
		translate([ts,0,h-ts])
			tube(ts, l-(ts*2));
		translate([ts,-(w-ts),0])
			tube(ts, l-(ts*2));
		translate([ts,-(w-ts),h-ts])
			tube(ts, l-(ts*2));

		union() color([255,0,0])
		{
			rotate([0,0,270])
				tube(ts, w-(ts*2));
			translate([0,0,h-ts])
				rotate([0,0,270])
				tube(ts, w-(ts*2));
			translate([l-ts,0,0])
				rotate([0,0,270])
				tube(ts, w-(ts*2));
			translate([l+t,-w+ts,h+t])
				rotate([270,90,0])
				angle(25,t,w);
		}

		rotate([0,270,270]) union() color([0,0,255])
		{
			translate([0,0,0])
				tube(ts, h);
			translate([0,0,-(w-ts)])
				tube(ts, h);
			translate([0,l-ts,0])
				tube(ts, h);
			translate([0,l-ts,-(w-ts)])
				tube(ts, h);
		}
	}
}

base(tubesize=13, d=[300,425,75,3.175]);