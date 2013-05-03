

module M8_Extruder_Block() {
	//import original
	import_stl("M8_Extruder_Block_3.stl");
	//close unneeded holes
	translate([69,5,0]) cylinder(r=2.2,h=28,$fn=20);
	translate([81,5,0]) cylinder(r=2.2,h=28,$fn=20);
	difference() {
		translate([75,11,15]) rotate([90,0,0]) cylinder(r=8.2,h=11,$fn=30);
		translate([75,12,15]) rotate([90,0,0]) cylinder(r=2,h=12,$fn=20);
	}
	//close mountholes
	#translate([46.5,5,14]) rotate([90,0,0]) cylinder(r=3,h=5,$fn=30);
	#translate([96.5,5,14]) rotate([90,0,0]) cylinder(r=3,h=5,$fn=30);
}

module M8_Extruder_Block_Bfb() {

	difference() {
		M8_Extruder_Block();
		//holes to mount the BfB hotend
		translate([60,9,21]) rotate([90,0,0]) cylinder(r=2.5,h=10,$fn=20);
		translate([90,9,21]) rotate([90,0,0]) cylinder(r=2.5,h=10,$fn=20);

		//nut holes
		translate([90,9,21]) rotate([90,0,0]) cylinder(r=4.5,h=4,$fn=6);
		translate([60,9,21]) rotate([90,0,0]) cylinder(r=4.6,h=5,$fn=6);
		//nut hole access
		translate([56,7,21]) rotate([90,0,0]) cube([5,7.9,4],center=true);

		//new mounting holes
		#translate([50,5,15]) rotate([90,0,0]) cylinder(r=2.8,h=6,$fn=30);
		#translate([100,5,15]) rotate([90,0,0]) cylinder(r=2.8,h=6,$fn=30);
	}
}

M8_Extruder_Block_Bfb();