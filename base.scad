use<material.scad>

module base(tubesize, d)
{
	width = d[0];
	length = d[1];
	height = d[2];

	translate([tubesize,0,0]) rotate([0,0,90]) union()
	{
		tube(tubesize, length);
		translate([0,0,height-tubesize])
			tube(tubesize, length);
		translate([0,-(width-tubesize),0])
			tube(tubesize, length);
		translate([0,-(width-tubesize),height-tubesize])
			tube(tubesize, length);

		rotate([0,0,270]) union() color([255,0,0])
		{
			tube(tubesize, width-(tubesize*2));
			translate([0,0,height-tubesize])
				tube(tubesize, width-(tubesize*2));
			translate([0,length-tubesize,0])
				tube(tubesize, width-(tubesize*2));
			translate([0,length-tubesize,height-tubesize])
				tube(tubesize, width-(tubesize*2));
		}

		rotate([0,270,270]) union() color([0,0,255])
		{
			translate([tubesize,0,0])
				tube(tubesize, height-(tubesize*2));
			translate([tubesize,0,-(width-tubesize)])
				tube(tubesize, height-(tubesize*2));
			translate([tubesize,length-tubesize,0])
				tube(tubesize, height-(tubesize*2));
			translate([tubesize,length-tubesize,-(width-tubesize)])
				tube(tubesize, height-(tubesize*2));
		}

		translate([tubesize,-width/2,height-tubesize])
			cube([length-(tubesize*2), tubesize * 2, tubesize]);
	}
}

base(tubesize=13, d=[300,425,75]);