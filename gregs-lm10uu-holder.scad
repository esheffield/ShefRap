// Gregs PRUSA Mendel  
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
// Modified by Djamuka
//https://github.com/GregFrost/PrusaMendel

//include <configuration.scad>
m8_diameter=10;
clearance=0.7;

lm10uu_diameter=19+clearance;
lm10uu_length=29+clearance;
lm10uu_support_thickness=3.2; 
lm10uu_end_diameter=m8_diameter+1.5;

lm10uu_holder_width=lm10uu_diameter+2*lm10uu_support_thickness;
lm10uu_holder_length=lm10uu_length+2*lm10uu_support_thickness;
lm10uu_holder_height=lm10uu_diameter*0.75+lm10uu_support_thickness;
lm10uu_holder_gap=(lm10uu_holder_length-6*lm10uu_support_thickness)/2;

module lm10uu_bearing_holder()
{
	difference()
	{
		cube([lm10uu_holder_width,lm10uu_holder_length,lm10uu_holder_height]);
		translate([lm10uu_holder_width/2,0,lm10uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,lm10uu_support_thickness])
		cylinder(r=lm10uu_diameter/2,h=lm10uu_length,$fn=40);

		translate([lm10uu_holder_width/2,0,lm10uu_holder_width/2])
		rotate([-90,0,0])
		translate([0,0,-1])
		{
			cylinder(r=lm10uu_end_diameter/2,h=lm10uu_holder_length+2,$fn=40);
			translate([-lm10uu_end_diameter/2,-lm10uu_end_diameter,0])
			cube([lm10uu_end_diameter,lm10uu_end_diameter,lm10uu_holder_length+2]);
		}

		translate([-1,2*lm10uu_support_thickness,lm10uu_support_thickness])
		cube([lm10uu_holder_width+2,lm10uu_holder_gap,
			lm10uu_holder_height-lm10uu_support_thickness+1]);

		translate([-1,4*lm10uu_support_thickness+lm10uu_holder_gap,
			lm10uu_support_thickness])
		cube([lm10uu_holder_width+2,lm10uu_holder_gap,
			lm10uu_holder_height-lm10uu_support_thickness+1]);
	}
}

lm10uu_bearing_holder();