module anti_backlash_nut()
{
	function mm(inch) = inch * 25.4;

	bore = mm(0.5);
	ht = mm(1.125);
	sm_d = mm(0.875);
	fl_d = mm(1.5);
	fl_w = mm(1.25);
	fl_ht = mm(0.25);
	mnt_cir_r = mm(1.188 / 2);
	mnt_d = mm(0.25);

	difference()
	{
		union()
		{
			cylinder(r=sm_d / 2, h = ht);
			intersection()
			{
				cylinder(r=fl_d / 2, h = fl_ht);
				translate([0,0,fl_ht / 2])
					cube([fl_d, fl_w, fl_ht], center=true);
			}
		}
		translate([0,0,-0.1])
			cylinder(r=bore / 2, h = ht + 0.2);
		for(a = [45,135,225,315])
		{
			rotate([0,0,a])
				translate([mnt_cir_r,0,-0.1])
					cylinder(r = mnt_d / 2, h = fl_ht + 0.2);
		}
	}	
}

anti_backlash_nut();