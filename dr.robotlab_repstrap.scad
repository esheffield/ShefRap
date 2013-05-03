smrd = 8.7; //smooth rod diameter

//positioning stuff
x =-120;
y =30;
z =5;
//bracket  (yes = 1 or no = 0)
br = 0;

/*
--module--
anglecornersupport() - top corner support used to cap the tslot end tooaxis_slider_assay() - is the total axis slider assembly
axis_slider_base() - is the base of the total slider assembly
axis_slider_beltplate() - is the plate for screwing timing belt onto the axis slider connected to axis slider
axis_slider_plate() - is the plate for screwing timing belt onto the axis slider not connected to axis slider
axis_slider() - is axis slider base part not including bearing holder
axis_slider_beltclamp()  - is the one side of axis slider assembly that is used for clamping timing belt
axis_slider_beltclamp2() - is the other side of the axis slider assembly that is used for clamping timing belt
axis_slider_shaft() - is the shaft part of the axis slider 


bearingmodel - just to help visualize the rod alignments 
box(w,h,d) - basic box library  (its from thingiverse)
BottomRodHolder() - bottom smooth rod support it has a m4locknut for clamping
BottomThreadRodHolder() - bottom thread rod support
Bearingholder() - sized for holding a 608 bearing for Z drive
Bearingholder() - sized for holding a 608 bearing for XY drive .. the original holder which was too loose for the smooth rods
bearing() - LM8UU bushing holder inspired/derived from: http://www.thingiverse.com/thing:14814. Note: LM8UU_dia varies sometimes I have 15.2 other times 16.2 //for cross slider use 16.2 this is current ... because I have different bearings ... 16.2 for axis sliders. mount_plate() works with it.

CornerscadB(cx,cy,cz) - Part B for the top corner brackets (both for threaded and smooth) 
CornerscadA() - Part A for the top corner brackets (both for threaded)
cornerelement() - calls CornerscadA and CornerscadB for rendering the corner for threaded rod also calls the Bearingholder
complete_assembly(x,y,z,br) - is the complete assembly with all parts on it
cornersupport() - top corner support right next to anglecornersupport()
cubeassembly() - is the tslot assembly of the whole instrument
carriagebearing() - is the linear bearing holder that fits with the cross slider plate
carriagebearing_h() - is the linear bearing holder that fits with the cross slider plate that is 9mm higher
cross_slider_assy() - is the cross slider assembly with bearings fitting in
crossslider_coupler() - is the part that is connected to the cross_slider_plate that interfaces with the carriagebearing
cross_slider_plate() - is the cross slider plate which the extruder / dispenser can be connected to

dancross_slider() - calls Dan's original cross slider plate
dan_m3locknut(l) - is m3 lock nut

extrusioncube() - calls the extruded aluminum part

footbase() - adjustable feet on corners of instrument

hexagon(height, depth)  - basic hexagon library (its from thingiverse)

m4locknut() - locknut for clamping things on a 8mm smooth rod
motormount() - z motor mount just the part that holds the motor (could be used for xy motors)
MotorBottomRodHolder() - is the clamp that attaches to 20mm aluminum extrusion
MotorBottomRodHolder() - for holding threaded rod for z drive assembly
mount_plate() - is part of LM8UU set up

roundedBox(size, radius, sidesonly) - is Marius Kintel roundedBox library

smoothCornerscadA() - Part A for the top corner brackets (both for smooth)
smoothcornerelement()  - calls smoothCornerscadA and CornerscadB for smooth rod also calls the m4locknut
shaft() - is part of the z bed thread holder that holds the platform

TopXYBearingHolderBracket() - sized for holding a 608 bearing for Z drive. This was used for the xy a 608 bearing for XY drive and its the module that you call when you want to see the whole assembly This one was tricky because the lower bearing was tight fit at 11.2 but the upper bearing loose so created another function XYBearing for this tigher fit this maybe because one side is printed in x direction and other side printed in y direction
TopXYBearingHolderBracket() - sized for holding a 608 bearing for Z drive. This was used for the xy a 608 bearing for XY drive and its the module that you call when you want to see the whole assembly This one was tricky because the lower bearing was tight fit at 11.2 but the upper bearing loose so created another function XYBearing for this tigher fit this maybe because one side is printed in x direction and other side printed in y direction
TopXYLowerBearingHolderBracket - this is the open bracket holder so that means its just easier to move. You need to print 2 per corner and they have to be mirror images so you use this in OpenScad command -- mirror([0,0,1])
tslot20innerbracket() - is a bottom corner support
teardrop(radius, length, angle) - creates a teardrop shaped hole
tslot - Nathan Zadoks 2011 tslot library
tslot20(length,nut) - is part of Nathan Zadoks 2011 tslot library
tslot30(length,nut) - is part of Nathan Zadoks 2011 tslot library
tslot30_3060(length,nut) - is part of Nathan Zadoks 2011 tslot library

XYBearingholder() - sized for holding a 608 bearing for XY drive
xymotormount() - this is the xy motor mount

zbedthread() - z bracket that travels down threaded rod for holding bed
zbedclampsmooth() - z bracket that travels down smooth rod for holding bed
zbedslot() - this is a cooler z bed holder for holding tslots
*/


module dancross_slider()
{
	import("dan.cross_slider.stl");
}

module extrusioncube()
{
	translate([-325,30,-20])
	cubeassembly();
}

module footbase()
{
	translate([50,0,0])
	{
		difference()
		{
			union()
			{
				translate([-3.0,13,-2])
					difference()
					{
						roundedBox([40, 20, 4], 10, true);
						translate([12,0,-5])
							cylinder(r=5.2/2,h=10);
					}
				translate([-13.0,3,-2])
					rotate([0,0,90])
						difference()
						{
							roundedBox([40, 20, 4], 10, true);
								translate([-13,0,-5])
									cylinder(r=5.2/2,h=10);
						}
				difference()
				{
					translate([-23,2,-3])
						cube([20,21,6]);
					translate([-23,2,-3])
						translate([0,15,0])
							cube(8,6,8);
					translate([-13.75,12.75,-4])
						cylinder(r=8.2/2,h=300);
				}
				translate([-13.75,12.75,-4])
					difference()
					{
						cylinder(r=10.3,h=24);
						translate([0,0,0])
							cylinder(r=8.2/2,h=300);
						translate([0,0,16])
							hexagon(13.0,8);
						translate([0,0,20])
							cylinder(r=7.5,h=10);
					}
			}
		}
	}
}

module tslot20innerbracket()
{
	//bottom corner support
	translate([180,2,354])
	{
		rotate([0,90,-270])
		{
			difference()
			{
				cube([30,30,20]);

				translate([27,0,-2])
					cube([10,5,25]);

				translate([0,27,-2])
					cube([10,5,25]);
 
				translate([0,30,25])
					rotate([180,0,45])
						cube([30,50,30]);
						
				translate([5,5,5])
					cube([20,20,9.5]);

				translate([-5,20,10])
					rotate([0,90,0])
						cylinder(r=5.2/2,h=50);

				translate([19,15,10])
					rotate([90,0,0])
						cylinder(r=5.2/2,h=50);
			}
			translate([-2,0,7.5])
				cube([5,13,5]);
		}
	}
}

module bearingmodel()
{
	//remove bearing model
	difference()
	{
		cylinder(r=11,h=6);
		cylinder(r=4.1,h=7);
	}
}

module zbedthread()
{
	//CornerscadB dimensions
	cbx = 45;
	cby = 19;
	cbz = 5;

	//bed 
	bl = 275;

	//tslot dimensions
	tx = 200;
	ctx = 380;
	ty = 20;


	//translate([-20+2.+6,-2.-12.5,200])
	translate([-12,-14.5,200])
	{
		rotate([0,0,45])
		{
			shaft(); 
			//translate([-20-15,-4.5,23])
			translate([-35,-4.5,23])
			difference()
			{
				cube([45,13,5]);
				translate([45*0.5,13/2,0])
					cylinder(r=4.3/2,h=10);
				translate([45*0.75,13/2,0])
					cylinder(r=4.3/2,h=10);
				translate([45*0.25,13/2,0])
					cylinder(r=4.3/2,h=10);
			}
		}
	}
}

module zbedslot(){
	//CornerscadB dimensions
	cbx = 45;
	cby = 19;
	cbz = 5;

	//bed 
	bl = 275;

	//tslot dimensions
	tx = 200;
	ctx = 380;
	ty = 20;


	//translate([-20+2.+6,-2.-12.5,200])
	translate([-12,-14.5,200])
		rotate([0,0,90])
		{
			shaft(); 
			//translate([-20-15,-4.5,23])
			translate([-24+7+4,-23/2+6,23])
				difference()
				{
					union()
					{
						cube([28-4,15,5]);
						translate([0,-5,0])
							cube([28-4-4,26,5]);
					}
					translate([45*0.25-0.75,13/2+9,0])
					#cylinder(r=5.2/2,h=10);
					translate([45*0.25-0.75,13/2-6,0])
					#cylinder(r=5.2/2,h=10);
				}
		}
}

module zbedclampsmooth()
{
	translate([1,0,205])
		rotate([0,0,45])
		{
			printable_lm8uu();
			translate([-49,-6.5,19])
				difference()
				{
					cube([45,13,5]);
					translate([45*0.5,13/2,0])
						cylinder(r=4.3/2,h=10);
					translate([45*0.75,13/2,0])
						cylinder(r=4.3/2,h=10);
					translate([45*0.25,13/2,0])
						cylinder(r=4.3/2,h=10);
					translate([52,13/2,0])
						cylinder(r=16.5/2,h=10);
				}
		}
}

module m4locknut()
{
	rotate([90,90,90])
		difference()
		{
			translate([10,13,5])
			//cube([20,20,15]);
			roundedBox([20, 13, 13], 1, true);
			translate([9.5,13.5,-0])
			{
				translate([0,0,3.3])
					hexagon(7.30,3.95);
				translate([0,0,-25])
					cylinder(r=4.3/2,h=100);
				translate([-4.05,0,1.5])
					cube([8.1,12,3.75]);
			}
		}
}

module box(w,h,d)
{
	scale ([w,h,d]) cube(1, true);
}

module hexagon(height, depth)
{
	boxWidth=height/1.75;
	union()
	{
		box(boxWidth, height, depth);
		rotate([0,0,60])
			box(boxWidth, height, depth);
		rotate([0,0,-60])
			box(boxWidth, height, depth);
	}
}

//This one is tricky because the lower bearing was tight fit at 11.2 but the upper bearing loose so created another function XYBearing for this tigher fit. The open ended sides will be separated one will be called top and other bottom. Now seems even 11.2 is too loose for lower as this gets redesigned so reprinting again this time same conditions as the upper
module TopXYBearingHolderBracket()
{
	cx = 23;
	cy = 30;
	cz = 5;

	difference()
	{
		union()
		{
			difference()
			{ 
				union()
				{
					//left support
					translate([-1.5,8,3.5])
					roundedBox([cx-2, cy+35, cz], 1, true);

					difference()
					{
						union()
						{
							translate([-1.5,5,9])
							roundedBox([cx-2, (cy+30)/2+9, cz+8], 1, true);

							//Upper bearing holder 
							translate([-17,-1,5]) 
							XYBearingholder();
						}
						//left bottom support
						translate([-2.5,-4,16])
							rotate([20,0,0])
								roundedBox([cx+17, (cy+30)/2+20, cz+10], 1, true);
					} 

					//right support
					translate([10.05,3,-6])
						rotate([90,90,90])
							roundedBox([cx+1, cy+25, cz], 1, true);

					difference()
					{
						union()
						{
							//right bottom support
							translate([15.05,-7.5,-6])
								rotate([90,90,90])
									roundedBox([cx+1, cy+3, cz+6], 1, true);

							//Lower Bearing holder
							translate([10.05,20,-23.5])
								rotate([180,-90,0])
									XYBearingholder();
						}

						//right bottom support
						translate([19.05,-15.5,-9])
							rotate([90,90,60])
								roundedBox([cx+18, cy+4, cz+10], 1, true);
					}
				}

			}

			//alignment guide
			translate([-5.5,-14,(-cy+10)/2+1])
			difference()
			{
				translate([10,0,0-5.8/2])
					cube([5.8,cy/3+4,5.8]);
				translate([17.5,-15,0-5.8/2])
					rotate([0,0,40])
						cube([8.8,(cy/3)+12,8.8]);
			}
		}

		//big center 608 bearing the lower one
		translate([10,(cy+20)/2-20,(-cy+10)/2 + 1])
			rotate([0,90,0])
			{
				cylinder(r=11.05,h=50);
				translate([0,0,-10])
					cylinder(r=8.2/2,h=50);
			}

		//big center 608 bearing the upper one a little tigher
		translate([-2.5,14,5])
		{
			cylinder(r=11.05,h=50);
			translate([0,0,-10])
				cylinder(r=8.2/2,h=50);
		}

		//screw holes
		translate([-2.5,-17,-10])
			cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-2.5,35.0,-10])
			cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-15.5,26.0,(-cy+10)/2 + 1])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-10.5,-18,(-cy+10)/2+1])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);
	}
}


// this one you need to do a mirror to see other side
// mirror([0,0,1])
module TopXYLowerBearingHolderBracket()
{
	cx = 23;
	cy = 30;
	cz = 5;

	//basic bracket frame
	difference()
	{
		union()
		{
			//this part is the right angle bracket
			translate([-5,-20,-18])
				rotate([180,0,180])
				{
					translate([-0.5,2,3.5])
						roundedBox([cx-0, cy+32, cz], 1, true);

					//alignment guide
					translate([-2.5,-25.5,-11])
						rotate([-90,270,90])
							difference()
							{
								translate([10,0,0-5.8/2])
									cube([5.8,cy/3+4,5.8]);
								translate([17.5,-15,0-5.8/2])
									rotate([0,0,40])
										cube([8.8,(cy/3)+12,8.8]);
								cylinder(r=8.2/2,h=30);
							}
				} //end rotate

				//base support on that side
				difference()
				{
					translate([-15.05,-12.35,-12.5])
						rotate([90,90,90])
							roundedBox([(cx+7)-7, (cy-5)+25, cz], 1, true);
					//clean out center of bearing
					translate([-10.05,0,-8.95])
						rotate([0,-90,0])
							cylinder(r=10./2,h=10);
				} //end difference
		} //end union

		//for support side angle screw holes
		translate([0,-25,0])
			rotate([180,0,0])
			{
				translate([-2.5,-3.0,-10])
					cylinder(r=5.3/2,h=50);
			}

			//for support side angle screw holes
		translate([0,3,0])
			rotate([180,0,0])
			{
				translate([-2.5,-3.0,-10])
					cylinder(r=5.3/2,h=50);
			}

		//for bearing side angle screw holes
		translate([-35.5,-32.0,-9.0])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);

		//clean up the bottom
		translate([-35,-56,-50]) 
			cube([50,20,50]);

    } //end difference of basic bracket frame

	//Bearing piece and transisition
	difference()
	{
		union()
		{
			//the bearing
			translate([-15.05,-15,-23.5])
				rotate([0,-90,0])
					Bearingholder();

			//transistion support
			translate([-25.05,-31.5,-cz/2-1])
				rotate([90,90,90])
					cube([(cx)/2, cy-12, cz+3]); 
		}
		//angled element support of transistion support
		translate([-24.05,-36.5,-cz/2+1])
			rotate([60,90,90])
				cube([(cx)/2+4, cy-7, cz+5]); 
 
		translate([-15.05,-15,-23.5])
			rotate([0,-90,0])
				translate([26.00,5.5,0])
					cube([5,20,11]);
	}
}

module BottomRodHolder()
{
	cx = 23;
	cy = 30;
	cz = 5;

	difference()
	{
		union()
		{
			//left support
			roundedBox([cx, cy, cz], 1, true);
			translate([10.05,5,-9])
				rotate([90,90,90])
					//right support
					roundedBox([cx, cy+10, cz], 1, true);

			//alignment guide
			translate([-5.5,-4,0])
				difference()
				{
					translate([10,0,-12.5-5.8/2])
						cube([5.8,cy/3+4,5.8]);
					translate([17.5,-15,-15.4])
						rotate([0,0,40])
							cube([8.8,(cy/3)+12,8.8]);
				}
		}

		//screw holes
		translate([-2.5,4.0,-10])
			cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-15.5,17.0,-12.5])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-10.5,-6.0,-12.5])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);
	}


	difference()
	{
		//protruded arm
		translate([26.0,-7.5,15])
			rotate([0,45,0])
				union()
				{
					roundedBox([15, 15, 55], 1, false);
					translate([-13,-14,27.5])
						m4locknut();
				}

		//screw holes room
		translate([-10.5,-6.0,-12.5])
			rotate([0,90,0])
				cylinder(r=10.3/2,h=50);

		//inside cleaner 
		translate([-11.5,-26.5,-22.3])
			cube([20,80,20]);
  
		//Guiding smooth rod
		translate([38.5,-20,27.5])
			rotate([0,90,90])
				cylinder(r=smrd/2, h=100);
  
		translate([4.5,-8.,62])
			rotate([0,90+45,0])
				cylinder(r=4.2/2,h=47);
	}
}

module BottomThreadRodHolder()
{
	cx = 23;
	cy = 30;
	cz = 5;

	difference()
	{
		union()
		{
			//left support
			roundedBox([cx, cy, cz], 1, true);
			translate([10.05,5,-9])
				rotate([90,90,90])
					//right support
					roundedBox([cx, cy+10, cz], 1, true);

			//alignment guide
			translate([-5.5,-4,0])
				difference()
				{
					translate([10,0,-12.5-5.8/2])
						cube([5.8,cy/3+4,5.8]);
					translate([17.5,-15,-15.4])
						rotate([0,0,40])
					cube([8.8,(cy/3)+12,8.8]);
				}

		}
  
	//screw holes
	translate([-2.5,4.0,-10])
		cylinder(r=5.3/2,h=50);

	//screw holes
	translate([-15.5,17.0,-12.5])
		rotate([0,90,0])
			cylinder(r=5.3/2,h=50);

	//screw holes
	translate([-10.5,-6.0,-12.5])
		rotate([0,90,0])
			cylinder(r=5.3/2,h=50);
	}

	difference()
	{
		//protruded arm
		translate([19,-7.5,8])
			rotate([0,45,0])
				union()
				{
					roundedBox([15, 15, 33.5], 1, false);
					translate([-13,-14,27.5])
						//m4locknut();
						translate([-2,6.5,-14.5])
							rotate([-90,-90,0])
								Bearingholder();
				}

		//screw holes room
		translate([-10.5,-6.0,-12.5])
			rotate([0,90,0])
				cylinder(r=10.3/2,h=50);

		//inside cleaner 
		translate([-11.5,-26.5,-22.3])
			cube([20,80,20]);
 
		//Guiding smooth rod
		translate([38.5,-20,27.5])
			rotate([0,90,90])
				cylinder(r=smrd/2, h=100);
	}

	//for alignment
	//Guiding smooth rod
	//translate([38.5,-20,27.5])
	//rotate([0,90,90])
	//cylinder(r=smrd/2, h=100);
}

module XYBearingholder()
{
	ox = 30;
	oy = 30;
	oz = 6;

	difference()
	{
		union()
		{
			translate([ox/2-0.5,oy/2,0])
				cylinder(r=15,h=oz*1.75);
		} //end union
  
		translate([ox/2-0.5,oy/2,0])
		{
			translate([0,0,-3])
				cylinder(r=5,h=60);
			translate([0,0,3])
				cylinder(r=11.05,h=30);
		}
	} //end difference
}

module Bearingholder()
{
	ox = 30;
	oy = 30;
	oz = 6;

	difference()
	{
		union()
		{
			translate([ox/2-0.5,oy/2,0])
				cylinder(r=15,h=oz*1.75);
		} //end union
  
		translate([ox/2-0.5,oy/2,0])
		{
			translate([0,0,-3])
				cylinder(r=5,h=60);
			translate([0,0,3])
				cylinder(r=11.2,h=30);
		}
	} //end difference
}

module CornerscadA()
{
	cx = 115;
	cy = 20;
	cz = 4; 
	tx = 200;

	difference()
	{
		union()
		{
			cube([cx,cy,cz]);
			difference()
			{
				//reinforced support
				translate([0,cy/4,z/2])
					cube([cx,cy/2,cz]);

				//cut off one side in diagonal
				translate([-20,10,0])
					rotate([0,0,-45])
						cube([26.5,40,cz*3]);
  
				//cut off one side in diagonal
				translate([113,0,0])
					rotate([0,0,45])
						cube([26.5,40,cz*3]);

				//cut out center
				translate([cx/2+2,10,0])
					cylinder(r=15,h=cz*2);
				translate([0,0,3])
					cylinder(r=11,h=30);
			}
		}

		//cut out center
		translate([cx/2+2,10,0])
			cylinder(r=15,h=cz*2);
	}
}

module CornerscadB(cx,cy,cz)
{
	difference()
	{
		union()
		{
			roundedBox([cx, cy, cz], 5, true);
			translate([-5,-5.85/2,cz-6])
				cube([10,5.85,5]);
		}
		translate([cx/3,0,-5])
			cylinder(r=5.25/2, cz*2);
		translate([-cx/3,0,-5])
			cylinder(r=5.25/2, cz*2);
	} 
}

module cornerelement()
{
	//CornerscadB dimensions
	cbx = 45;
	cby = 19;
	cbz = 5;

	//tslot dimensions
	tx = 200;
	ty = 20;

	//Corner element
	translate([0,0,-10-25])
	{

		//Cornerscad

		//CornerscadA
		translate([tx-100,10,z])
			rotate([0,0,-45])
			{
				CornerscadA();
				translate([45,-5,0])
					Bearingholder();
			}

			//CornerscadB
			translate([tx/2+cbx/3-2,cbx/3,z +cbz/2]) 
				CornerscadB(cbx,cby,cbz);
			translate([tx-cby/2,0-cbx-cbx/3-1,z +cbz/2]) 
				rotate([0,0,90])
					CornerscadB(cbx,cby,cbz);
	} //end corner element
}

module anglecornersupport()
{
	cbx = 19;
	cby = 19;
	cbz = 5;

	rotate([0,0,0])
		difference()
		{
			union()
			{
				roundedBox([cbx, cby, cbz], 5, true);
				translate([-5,-5.85/2,cbz-6])
					cube([10,5.85,4.5]);
			}
			translate([0,0,-5])
				cylinder(r=5.25/2, cbz*2);
		}

	//join piece
	rotate([0,0,0])
		translate([4.5,-9,-2.5])
			cube([18,18,5]);

	//end cap
	rotate([0,0,0])
		translate([17,-0,0])
			roundedBox([cbx, cby, cbz], 5, true);

	//angled join piece
	rotate([0,0,45])
		translate([-5.5,-25,-2.5])
			cube([7,20,5]);

	//angled join piece
	rotate([0,0,0])
		translate([15.0,-20,-2.5])
			cube([8,15,5]);

	translate([17,-25,0])
		rotate([0,0,0])
			difference()
			{
				union()
				{
					roundedBox([cbx, cby, cbz], 5, true);
					translate([-5.85/2,-10/2,cbz-6])
						rotate([0,0,0])
							//cube([10,5.85,4.5]);
							cube([5.85,10,4.5]);
				}

				translate([0,0,-5])
					cylinder(r=5.25/2, cbz*2);
			}
}

module cornersupport()
{
	cbx = 19;
	cby = 19;
	cbz = 5;

	rotate([0,0,0])
		difference()
		{
			union()
			{
				roundedBox([cbx, cby, cbz], 5, true);
				translate([-5,-5.85/2,cbz-6])
					cube([10,5.85,4.5]);
			}

			translate([0,0,-5])
				cylinder(r=5.25/2, cbz*2);
		}

		//join piece
		translate([5,-5,-2.5])
			cube([10,10,5]);

		translate([22,25,0])
			rotate([0,0,90])
				difference()
				{
					union()
					{
						roundedBox([cbx, cby, cbz], 5, true);
						translate([-5,-5.85/2,cbz-6])
							cube([10,5.85,4.5]);
					}
					translate([0,0,-5])
						cylinder(r=5.25/2, cbz*2);
				}

		//join piece
		translate([27.5,7.5,-2.5])
			rotate([0,0,90])
				cube([10,10,5]);

		translate([22,0,0])
			rotate([0,0,90])
				difference()
				{
					union()
					{
						roundedBox([cbx, cby, cbz], 5, true);
						translate([-5,-5.85/2,cbz-6])
							cube([10,5.85,4.5]);
					}
					translate([0,0,-5])
						cylinder(r=5.25/2, cbz*2);
				}
}

module smoothCornerscadA()
{
	cx = 115;
	cy = 20;
	cz = 4; 
	tx = 200;

	difference()
	{
		union()
		{
			cube([cx,cy,cz]);
			difference()
			{
				//reinforced support
				translate([0,cy/4,z/2])
					cube([cx,cy/2,cz]);

				//cut off one side in diagonal
				translate([-20,10,0])
					rotate([0,0,-45])
						cube([26.5,40,cz*3]);

				//cut off one side in diagonal
				translate([113.0,0,0])
					rotate([0,0,45])
						cube([26.5,40,cz*3]);

				//cut out center
				translate([cx/2+2,10,0])
					cylinder(r=smrd/2,h=cz*2);

					//translate([0,0,3])
					//cylinder(r=11,h=30);
			}
		}

		//cut out center
		translate([cx/2+2,10,0])
			cylinder(r=smrd/2,h=cz*2);
	}

	difference()
	{
		//position locknut
		union()
		{
			translate([cx/2-12,0,-3])
				rotate([90,0,0])
					m4locknut();
			translate([cx/2+2,10,5])
				cylinder(r=8,h=15);
		}
		
		//cut out center
		translate([cx/2+2,10,0])
			cylinder(r=smrd/2,h=cz*2+100);
	}
}

module smoothcornerelement()
{
	//CornerscadB dimensions
	cbx = 45;
	cby = 19;
	cbz = 5;

	//tslot dimensions
	tx = 200;
	ty = 20;

	//Corner element
	translate([0,0,-35])
	{
		//Cornerscad
		//CornerscadA
		translate([tx-100,10,z])
			rotate([0,0,-45])
			{
				smoothCornerscadA();
				//translate([45,-5,0])
					//Bearingholder();
			}

		translate([tx/2+cbx/3-2,cbx/3,z +cbz/2]) 
			CornerscadB(cbx,cby,cbz);

		translate([tx-cby/2,-cbx-cbx/3-1,z +cbz/2]) 
			rotate([0,0,90])
				CornerscadB(cbx,cby,cbz);
	} //end corner element
}

module MotorBottomRodHolder()
{
	cx = 23;
	cy = 30;
	cz = 5;

	difference()
	{
		union()
		{
			//left support
			roundedBox([cx, cy, cz], 1, true);
			translate([10.05,5,-9])
				rotate([90,90,90])
			//right support
			roundedBox([cx, cy+10, cz], 1, true);

			//alignment guide
			translate([-5.5,-4,0])
				difference()
				{
					translate([10,0,-12.5-5.8/2])
						cube([5.8,cy/3+4,5.8]);
					translate([17.5,-15,-12.5-5.8/2])
						rotate([0,0,40])
							cube([8.8,(cy/3)+12,8.8]);
				}
		}
		
		//screw holes
		translate([-2.5,4.0,-10])
			cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-15.5,17.0,-12.5])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);

		//screw holes
		translate([-10.5,-6.0,-12.5])
			rotate([0,90,0])
				cylinder(r=5.3/2,h=50);
	}

	difference()
	{
		//protruded arm
		translate([26.0,-7.5,15])
			rotate([0,45,0])
				union()
				{
					translate([0,0,-15])
						roundedBox([15, 15, 28], 1, false);

					//translate([-21.5,-18.5,-22.5])
					translate([-21.5,-17.5,-22.5])
						rotate([90,0,0])
							motormount();
				}

		//screw holes room
		translate([-10.5,-6.0,-12.5])
			rotate([0,90,0])
				cylinder(r=10.3/2,h=50);

		//inside cleaner 
		translate([-11.5,-26.5,-22.3])
			cube([20,80,20]);
  
		//Guiding smooth rod
		translate([38.5,-20,27.5])
			rotate([0,90,90])
				cylinder(r=smrd/2, h=100);
 
		//to clean up area
		translate([26.0,-7.5,15])
			rotate([0,45,0])
				translate([-21,-10.5,-22.5])
					rotate([90,0,0])
						//motormount();
						translate([-1,19,-18.5])
							cube([43,43,9.5]);

		//clean stuff in motor inside
		translate([38.5,-20,25.5])
			rotate([0,90,90])
				cylinder(r=11.5, h=14);
	}

	translate([26.0,-7.5,15])
		rotate([0,45,0])
			//transition to motor
			translate([-7,-4,-15])
				difference()
				{
					cube([14,11.5,19]);
					translate([-0,16,8])
						rotate([45,0,0])
							cube([20,20,20]);
				}
}

module motormount()
{
	mmx = 42;
	mmy = 42;
	mmz = 8.5;
	mmposx = 0;
	mmposy = 19;
	mmposz = -18.5;

	m6rad = 6.5/2;
	m3rad = 4.5/2;
	motrad = 11.5;
	//motrad = 4;

	difference()
	{
		translate([mmposx,mmposy,mmposz])
			cube([mmx,mmy,mmz]);
			
		translate([mmposx+mmx/2,mmposy+mmy/2,mmposz])
			cylinder(r=motrad, h=9);

		//m3 motor screws
		translate([mmposx+mmx/2-15.5,mmposy+mmy/2-15.5,mmposz])
			cylinder(r=m3rad, h=9);
		translate([mmposx+mmx/2-15.5,mmposy+mmy/2+15.5,mmposz])
			cylinder(r=m3rad, h=9);
		translate([mmposx+mmx/2+15.5-1.5,mmposy+mmy/2+15.5,mmposz])
			cylinder(r=m3rad, h=9);
		translate([mmposx+mmx/2+15.5-1.5,mmposy+mmy/2-15.5,mmposz])
			cylinder(r=m3rad, h=9);
	}
}

module complete_assembly()
{
	//positioning stuff
	x =-120;
	y =30;
	z =5;
	//bracket  (yes = 1 or no = 0)
	br = 0;

	//CornerscadB dimensions
	cbx = 45;
	cby = 19;
	cbz = 5;

	//bed 
	bl = 275;

	//tslot dimensions
	tx = 200;
	ctx = 380;
	ty = 20;

	extrusioncube();

	translate([x,y,z])
	{
		//threaded corner A
		translate([tx-cby/2-3,2.45,300])
			rotate([90,180,0])
				BottomThreadRodHolder(); //- bottom thread rod support
  
		//threaded rod
		translate([tx-cby-32,ty-cbx,-40])
		{
			cylinder(r=8./2,h=400);
			//zbedthread();
			translate([-2.5,-15,0])
				rotate([0,0,-90])
					zbedslot(); 

			//x and y rod bracket
			translate([32,37.5,60])
				rotate([90,0,-90])
					TopXYBearingHolderBracket();

			//x rod
			translate([41,30,105.25-40])
				rotate([90,0,0])
					cylinder(r=8.2/2,h=350);

			//y rod
			translate([21,40,74.25])
				rotate([0,-90,0])
					cylinder(r=8.2/2,h=350);
		}
		
		cornerelement();

		//Top supports
		translate([203,15,7])
			rotate([0,90,180])
				cornersupport();

		translate([190,27.5,2])
			rotate([-90,90,180])
				anglecornersupport();

		translate([-174,-175,353])
			rotate([-270,0,90])
				tslot20innerbracket();
   
		translate([175,52,380])
			rotate([0,0,270])
				footbase();

		translate([-202,-ctx+377,365])
			rotate([-90,180,-90])
				anglecornersupport();
		//End Corner A

		//threaded corner B 
		translate([-ctx+ctx-0,-ctx+30,0])
			rotate([0,0,180])
			{
				translate([tx-cby/2-3,2.45,300])
					rotate([90,180,0])
						//BottomRodHolder();
						BottomThreadRodHolder(); //- bottom thread rod support
  
				translate([tx-cby-32,ty-cbx,-40])
				{
					cylinder(r=8./2,h=400);
					//zbedslot();
					translate([-3.5,-12.5,0])
						rotate([0,0,-90])
							zbedslot(); 

					//x and y rod bracket
					translate([32,37.5,60])
						rotate([90,0,-90])
							TopXYBearingHolderBracket();

					//x rod
					translate([41,30,65.25])
						rotate([90,0,0])
							cylinder(r=8.2/2,h=350);

					//y rod
					translate([21,40,74.25])
						rotate([0,-90,0])
							cylinder(r=8.2/2,h=350);
				}
				cornerelement();
			}

		translate([177-ctx,-ctx+15,7])
			rotate([90,90,-90-180])
				cornersupport();
		translate([190.7-ctx,-ctx+0.1,2])
			rotate([-0,90,-270])
				anglecornersupport();

		translate([0,0,380])
			rotate([270,0,180]) 
				tslot20innerbracket();

		translate([-177,-401,380])
			rotate([0,0,90])
				footbase();

		translate([-173,-ctx+2,365])
			rotate([-90,180,0])
				anglecornersupport();
		//End Corner B

		//threaded corner C
		translate([ctx/2-15,-ctx/2+15,0])
			rotate([0,0,270])
			{
				translate([tx-cby/2-3,2.45,300])
					rotate([90,180,0])
						MotorBottomRodHolder();
				//threaded rod
				translate([tx-cby-32,ty-cbx,-40])
				{
					cylinder(r=8./2,h=400);
						translate([15,-3,0])
							zbedslot(); 

					//x and y rod bracket
					//Open bracket system 
					translate([32,42.5,74])
						rotate([90,180,-90])
							TopXYLowerBearingHolderBracket();

					//x and y rod bracket
					//Open bracket system 
					translate([44,29.5,65])
						rotate([90,180,180])
							mirror([0,0,1])
								TopXYLowerBearingHolderBracket();
				}

				cornerelement();
			}

		//C
		translate([190,-ctx+2,7])
			rotate([0,90,-90-180])
				cornersupport();

		translate([202.7,-ctx+15.1,2])
			rotate([-90,90,-270])
				anglecornersupport();

		translate([0,0,350])
			rotate(a=90,v=[1,0,0])
				tslot20innerbracket();

				translate([227,-352,380])
			rotate([0,0,180])
				footbase();

		translate([202.7,-ctx+32,365])
			rotate([-90,180,90])
				anglecornersupport();
		//End Corner C

		//threaded corner D
		translate([-ctx/2+15,-ctx/2+15,0])
			rotate([0,0,450])
			{
				translate([tx-cby/2-3,2.45,300])
					rotate([90,180,0])
						//BottomRodHolder();
						MotorBottomRodHolder();

				//threaded rod
				translate([tx-cby-32,ty-cbx,-40])
				{
					cylinder(r=8./2,h=400);
					translate([15,-3,0])
						zbedslot(); 

					//x and y rod bracket
					//Open bracket system 
					translate([32,42.5,74])
						rotate([90,180,-90])
							TopXYLowerBearingHolderBracket();

					//x and y rod bracket
					//Open bracket system 
					translate([44,29.5,65])
						rotate([90,180,180])
							mirror([0,0,1])
								TopXYLowerBearingHolderBracket();
				}
				cornerelement();
			}

		//D
		//Top corner support
		translate([190-ctx,28,9.])
			rotate([-0,-270,-90])
				cornersupport();

		translate([177.7-ctx,15,3])
			rotate([0,90,0])
				anglecornersupport();
  
		translate([175,-175,377])
			rotate([-270,180,270])
				tslot20innerbracket();

		translate([-227,3,380])
			footbase();

		translate([172.7,-ctx+408,365])
			rotate([-90,180,180])
				anglecornersupport();

		//bed
		/*
		translate([-bl/2,-bl -35,178])
			cube([bl,bl,5]);
		*/

		//tslot supports for bed

		//bed support
		translate([115,0,187])
			rotate([90,90,0])
				tslot20(350);
		translate([-145,0,187])
			rotate([90,90,0])
				tslot20(350);
	}

	//xymotormounts
	translate([-15,65,345])
		rotate([90,0,0])
			xymotormount();
	mirror([0,0,1])
		translate([87,-25,-345])
			rotate([-90,0,90])
				xymotormount();

}

module shaft()
{
	sl = 25;
	//sl = 45;
	mx = -2; //adjust shaftx
	mz = 5.00;
	my = 2;

	translate([20,0,sl/2-2])
	{
		difference()
		{
			union()
			{
				translate([mx,my,mz]) //here
					rotate([0,0,30])
						hexagon(20.7,sl);
				//base(); //tmp
			}

			translate([mx,my,mz]) //here
				rotate([0,0,30])
					hexagon(13.0,sl);
		}

		translate([mx,my,mz+5])
			difference()
			{
				rotate([0,0,30])
					hexagon(12.7,5);
				translate([0,0,-8])
				{
					cylinder(r=6.4,6);
					cylinder(r=6.0,6.5);
					cylinder(r=5.5,7);
					cylinder(r=5.0,7.5);
					cylinder(r=4.8,8);
					cylinder(r=4.4,20);
				}
			}
	}
}

/*
This script generates a teardrop shape at the appropriate angle to prevent overhangs greater than 45 degrees.
The angle is in degrees, and is a rotation around the Y axis. You can then rotate around Z to point it in any 
direction. Rotation around Y or Z will cause the angle to be wrong.
*/

module teardrop(radius, length, angle)
{
	rotate([0, angle, 0]) 
		union() 
		{
			linear_extrude(height = length, center = true, convexity = radius, twist = 0)
				circle(r = radius, center = true, $fn = 30);
			linear_extrude(height = length, center = true, convexity = radius, twist = 0)
				projection(cut = false) rotate([0, -angle, 0]) translate([0, 0, radius * sin(45) * 1.5])
					cylinder(h = radius * sin(45), r1 = radius * sin(45), r2 = 0, center = true, $fn = 30);
		}
}

//(C) Nathan Zadoks 2011
//CC-BY-SA or GPLv2, pick your poison.
module tslot(
	size=10,	//size of each side
	length=10,	//length. descriptive enough, no?
	thickness=3,	//thickness of the 'sheet'
	gap=0,		//gap, thickness of the lower part of the 'T'
	center=false,	//somewhat vague. todo.
	nut=false,	//set to true to make a fitting T-slot nut
	)
{
	start=thickness/sqrt(2);
	if(nut)
	{
		linear_extrude(height=10)
		intersection()
		{
			polygon([[size/2-gap/2,0],[size/2-gap/2,thickness],[thickness+start,thickness],[size/2,size/2-2],
					 [size-thickness-start,thickness],[size/2+gap/2,thickness],[size/2+gap/2,0]]);
			square([size,size/2-(gap+thickness)/2]);
		}
	}	
	else
	{
		color([0.5,0.5,0.5])
			linear_extrude(height=length,center=center)
				translate([15,15])
					difference()
					{
						union()
						{
							for(d=[0:3]) 
								rotate([0,0,d*90]) 
									polygon(points=[[0,0],[0,start],[size/2-thickness-start,size/2-thickness],
										[gap/2,size/2-thickness],[gap/2,size/2],[size/2,size/2],[size/2,gap/2],
										[size/2-thickness,gap/2],[size/2-thickness,size/2-thickness-start],[start,0]
									]);
							square(gap+thickness,center=true);
						}
						circle(r=gap/2,center=true);
					}
	}
}

module tslot20(length,nut)
{
	tslot(size=20,gap=5.26,thickness=1.5,length=length,nut=nut);
}

module tslot30(length,nut)
{
	tslot(size=30,gap=8.13,thickness=2.55,length=length,nut=nut);
}

module tslot30_3060(length,nut)
{
	union()
	{
		tslot30(length,nut);
		translate([30,0,0])
		tslot30(length,nut);
	}
}

// EXAMPLE USAGE:
// roundedBox([20, 10, 4], 5, true);
// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly)
	{
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
			y = [radius-size[1]/2, -radius+size[1]/2])
		{
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else
	{
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2])
		{
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
				y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2])
			{
				rotate(rot[axis]) 
					translate([x,y,0]) 
						cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		
		for (x = [radius-size[0]/2, -radius+size[0]/2],
			y = [radius-size[1]/2, -radius+size[1]/2],
			z = [radius-size[2]/2, -radius+size[2]/2])
		{
			translate([x,y,z]) sphere(radius);
		}
	}
}

module cubeassembly()
{
	l = 380;

	//cube part
	//part 1
	translate([0,0,0])
		tslot20(l);

	//part 2
	translate([0,5,-5])
		rotate([90,0,0])
			tslot20(l);

	//part 3
	translate([5,0,-5])
		rotate([90,0,90])
			tslot20(l);

	//cube part
	//part 4 like part 1
	translate([l,0,20])
		tslot20(l);

	//part 5 like part 3
	translate([5,0,l-5])
		rotate([90,0,90])
			tslot20(l);

	//part 6 like part 2
	translate([l,25,-5])
		rotate([90,0,0])
			tslot20(l);

	//part 7 like part 3
	translate([25,-l,-5])
		rotate([90,0,90])
			tslot20(l);

	//part 8 like part 2
	translate([0,5,l-5])
		rotate([90,0,0])
			tslot20(l);

	//part 9 like part 1
	translate([0,-l,0])
		tslot20(l);

	//part 10 like part 7
	translate([25,-l,l-5])
		rotate([90,0,90])
			tslot20(l);

	//part 11 like part 6
	translate([l,25,l-5])
		rotate([90,0,0])
			tslot20(l);

	//part 12 like part 4
	//cube part
	//part 4 like part 1
	translate([l,-l,20])
		tslot20(l);

	//part 13 base part cross section
	translate([l/2,3,375])
		rotate([90,0,0])
			tslot20(l-24);

	//part 14 base part cross section
	translate([26,-l/2,375])
		rotate([90,0,90])
			tslot20((l-26-20)/2);

	//part 15 base part cross section
	translate([26+190,-l/2,375])
		rotate([90,0,90])
			tslot20((l-26-20)/2);
}

 module carriagebearing()
 {
	translate([39.25+21/2-14.5/2,16.,-12.5])
		rotate([90,0,0])
		{
			difference()
			{
				union()
				{
					difference()
					{
						cube([14.5,25,5]);
						translate([-5.5,0,5]) //the x value will be adjusted for fitting
							rotate([0,60,0])
						cube([14.5,25,5]);

						translate([14.5,0,-5]) //the x value will be adjusted for fitting
							rotate([0,-60,0])
								cube([14.5,25,5]);
					}
					translate([14.5/2,12.5,16.])
					{
						bearing();
						translate([-10.5,-12.5,-11])
							cube([21,25,11]);
					}
				}

				translate([(14.5/2-6/2),0,-2.4+3.95])
					cube([6,25,2.4]);

				translate([(14.5/2-3.5/2),0,-2.6+1.75])
					cube([3.5,25,2.6]);

				translate([14.5/2,5,-50])
					cylinder(r=3.1/2,h=100);

				translate([14.5/2,20,-50])
					cylinder(r=3.1/2,h=100);
			}
		}
}

 //higher carriage bearing 9mm
 module carriagebearing_h()
 {
	translate([39.25+21/2-14.5/2,16.,-12.5])
		rotate([90,0,0])
		{
			difference()
			{
				union()
				{
					difference()
					{
						#cube([14.5,25,5]);
						translate([-5.5,0,5]) //the x value will be adjusted for fitting
							rotate([0,60,0])
								cube([14.5,25,5]);

						translate([14.5,0,-5]) //the x value will be adjusted for fitting
							rotate([0,-60,0])
								cube([14.5,25,5]);
					}
					
					translate([14.5/2,12.5,16.+9])
					{
						bearing();
						translate([-10.5,-12.5,-11-9])
							cube([21,25,11+9]);  // this is the higher one
					}
				}

				translate([(14.5/2-6/2),0,-2.4+3.95])
					cube([6,25,2.4]);

				translate([(14.5/2-3.5/2),0,-2.6+1.75])
					cube([3.5,25,2.6]);

				translate([14.5/2,5,-50])
					cylinder(r=3.1/2,h=100);

				translate([14.5/2,20,-50])
					cylinder(r=3.1/2,h=100);
			}
		}
}

module crossslider_coupler()
{
	difference()
	{
		cube([14.5,25,5]);
		translate([0,0,0.2])
			difference()
			{
				cube([14.5,25,5]);
				translate([-5.6,0,5]) //the x value will be adjusted for fitting original is -5.5
					rotate([0,60,0])
						cube([14.5,25,5]);

				translate([14.6,0,-5]) //the x value will be adjusted for fitting original is 14.5
					rotate([0,-60,0])
						cube([14.5,25,5]);
			}
	}
}

module dan_m3locknut(l)
{
	difference()
	{
		cube([14.5,l,5]);
		translate([-5.6,0,5]) //the x value will be adjusted for fitting original is -5.5
			rotate([0,60,0])
				cube([14.5,l,5]);

		translate([14.6,0,-5]) //the x value will be adjusted for fitting original is 14.5
			rotate([0,-60,0])
				cube([14.5,l,5]);

		translate([14.5/2-6/2,0,2.5])
			cube([6,l,2.4]);

		translate([14.5/2-3.5/2,0,0])
			cube([3.5,l,2.6]);

		translate([14.25,0,0])
			cube([14.5,l,5]);
	}
}

module cross_slider_plate()
{
	translate([0,0,4])
		difference()
		{
			union()
			{
				roundedBox([80, 80, 4], 5, true);
				translate([-18,-18,0])
					rotate([0,0,45])
						#roundedBox([80, 27, 4], 5, true);

				translate([-14.5/2,14,2.])
					crossslider_coupler();

				translate([-14.5/2,14-53,2.])
					crossslider_coupler();

				translate([-14,-7,2.])
					rotate([0,0,90])
						crossslider_coupler();

				translate([39,-7,2.])
					rotate([0,0,90])
						crossslider_coupler();
 }



 translate([-29,31,0])
 roundedBox([35, 40, 4], 5, true);
 translate([34,31,0])
 roundedBox([19, 40, 4], 5, true);
 translate([30,-31,0])
 roundedBox([31, 40, 4], 5, true);


 translate([34.5,0,-25])
 cylinder(r=3.2/2,h=100); 

 translate([19.5,0,-25])
 cylinder(r=3.2/2,h=100); 

 translate([-34.5,0,-25])
 cylinder(r=3.2/2,h=100); 

 translate([-19.5,0,-25])
 cylinder(r=3.2/2,h=100); 

 translate([0,34.5,-25])
 cylinder(r=3.2/2,h=100); 

 translate([0,19.5,-25])
 cylinder(r=3.2/2,h=100); 

 translate([0,-34.5,-25])
 cylinder(r=3.2/2,h=100); 

 translate([0,-19.5,-25])
 cylinder(r=3.2/2,h=100); 

 translate([-3,-3,-50])
 cylinder(r=6.2/2,h=100);

 translate([-38,-38,-50])
 cylinder(r=6.2/2,h=100);

 translate([-22.15,-23.5,-25])
 cylinder(r=9,h=100);

 }

}

//This is the function that calls the whole assembly
module axis_slider_assay()
{
	axis_slider_base();
	bearing();

	difference()
	{
		translate([13,14.5,0])
			rotate([90,0,0])
				dan_m3locknut(15);
		translate([29.5-19/2,31,44/2-14])
			rotate([90,90,0])
				cylinder(r=2.9/2,h=50);
	}
	
	difference()
	{
		translate([13,-14.5,15])
			rotate([-90,0,0])
				dan_m3locknut(15);
		translate([19-19/2+10.5,19+12,44/2-4-10])
			rotate([90,90,0])
				cylinder(r=2.9/2,h=50);
	}
}

module axis_slider_base()
{
	//base part
	rotate([0,0,180])
		translate([-2*19+8.5,-19/2,0])
		{
			difference()
			{
				axis_slider();

				translate([15,-10,30])
					rotate([0,0,0])
						cube([50,60,15]); 

				translate([-15,-10,30])
					rotate([0,0,0])
						cube([20,60,15]);
			}
		}
}

//this is the belt plate that aligns the screws and calles axis_slider_plate
module axis_slider_beltplate()
{
	//Belt plate
	translate([30,4.5,34])
	difference()
	{
		axis_slider_plate();
		//screw holes
		translate([0,4,6])
		{
			translate([-10,3,-12])
				rotate([0,90,0])
					cylinder(r=3.25/2,h=200);

			translate([-50,3,1])
				rotate([0,90,0])
					cylinder(r=3.25/2,h=200);
		}

		translate([0,-20,6])
		{
			translate([-10,3,-12])
				rotate([0,90,0])
					cylinder(r=3.25/2,h=200);

			translate([-50,3,1])
				rotate([0,90,0])
					cylinder(r=3.25/2,h=200);
		}
	}//end plate
}

module axis_slider_plate()
{
	cl = 4;
	ct = 23;
	mcl = -4;
	r=3.25;

	difference()
	{
		union()
		{
			translate([2,0,0])
			{
				difference()
				{
					translate([mcl,0,-13])
						cube([cl,12,ct]);
					translate([mcl,10-2.5 ,-10.5+0-13])
						rotate([42,0,0])
							cube([cl,45,10]);
				}
			}

			translate([-6,-10,0])
				rotate([180,180,0])
				{
					difference()
					{
						translate([mcl-4,0,-13])
							cube([cl,12,ct]);
						translate([mcl-4,10-2.5,-10.5+0-13])
							rotate([42,0,0])
								cube([cl,45,10]);
					}
				}

			//plate
			translate([-2,-10,-13])
				cube([cl,15,ct]);

			//alignment screw holes
			/*
			translate([0,4,6])
			{
				translate([-10,3,-12])
					rotate([0,90,0])
						cylinder(r=3/2,h=200);

				translate([-50,3,1])
					rotate([0,90,0])
						cylinder(r=3/2,h=200);
			}

			translate([0,-20,6])
			{
				translate([-10,3,-12])
					rotate([0,90,0])
						cylinder(r=3/2,h=200);

				translate([-50,3,1])
					rotate([0,90,0])
						cylinder(r=3/2,h=200);
			}
			 */ //end alignment screws

		} //end union

		translate([-17.5,-15,-26.5])
			cube([20,20.3,ct]);

	} //end difference
}


//axis slider base part not including bearing holder
module axis_slider()
{
	difference()
	{
		axis_slider_shaft();
		translate([20,9.5,18.5])
			rotate([0,90,0])
				cylinder(r=4.4/2,h=10, center=true, $fn=20);
	}

	//beltclamp();
	translate([9,18+1,37.5-13/2-0])
	{
		translate([0,0,9])
			axis_slider_beltclamp();
	}

	translate([9,1,37.5+13-13/2])
	{
		rotate([180,180,0])
			translate([-2,0,-4])
				axis_slider_beltclamp2();
	}
}

module axis_slider_beltclamp()
{
	cl = 10;
	mcl = -4;

	difference()
	{
		union()
		{
			difference()
			{
				translate([-4,0,0])
					cube([10,6.90,4]);
				//translate([-7,1,2])
				//	cube([13,4,9]);
			}

			translate([0,-4,-6])   
				difference()
				{
					translate([mcl,0,-13])
						cube([cl,12,23]);
					translate([mcl,10-2.5 ,-10.5+0-13])
						rotate([42,0,0])
							cube([cl,45,10]);
				}
		}

		translate([-10,3,-12])
			rotate([0,90,0])
				cylinder(r=3/2,h=200);

		translate([-50,3,1])
			rotate([0,90,0])
				cylinder(r=3/2,h=200);
	}
}

module axis_slider_beltclamp2()
{
	cl = 10;
	mcl = -4;

	difference()
	{
		union()
		{
			difference()
			{
				translate([-4,0,0])
					cube([10,6.90,4]);
				//translate([-7,1,2])
				//	cube([15,4,9]);
			}

			translate([0,-4,-6])   
				difference()
				{
					translate([mcl,0,-13])
						cube([cl,12,23]);
					translate([mcl,10-2.5 ,-10.5+0-13])
						rotate([42,0,0])
							cube([cl,45,10]);
				}
		}
		
		//translate([2.5,3.,-15])
        //	cylinder(r=3/2,h=200);

		translate([-10,3,-12])
			rotate([0,90,0])
				cylinder(r=3/2,h=200);

		translate([-50,3,1])
			rotate([0,90,0])
				cylinder(r=3/2,h=200);
	}
}

module axis_slider_shaft()
{
	difference()
	{
		union()
		{
			cube([19,19,44]);
			//translate([10,10,0])
			//	roundedRect([19, 19, 44], 2, $fn=12);
		}
		
		translate([19/2,19/2,-1])
			cylinder(r=8.7/2,h=44*2);

		/*
		//set screws
		translate([-19/2,19/2,44-17])
			rotate([0,90,0])
				cylinder(r=2.9/2,h=50);
		*/

		//set screws to hole axis bar in place
		translate([19-19/2,19+12,44/2-4-10])
			rotate([90,90,0])
				cylinder(r=2.9/2,h=50);
	}
}
	
module cross_slider_assy()
{
	translate([-40-19.5/2,-26,23])
		rotate([270,0,0])
			carriagebearing();

	translate([-40-19.5/2,26,23])
		rotate([270,0,0])
			carriagebearing();

	translate([-26.5,-50,23])
		rotate([270,0,90])
			carriagebearing_h();

	translate([26.5,-50,23])
		rotate([270,0,90])
			carriagebearing_h();

	cross_slider_plate();
}

module mount_plate()
{
	// screw/nut dimensions
	screw_dia = 4.2;
	
	difference()
	{
		translate([0,0,1.5])
			cube([37,10,3], center=true);

		translate([14,0,0])
			cylinder(r=screw_dia/2, h=3, $fn=20);

		translate([-14,0,0])
			cylinder(r=screw_dia/2, h=3, $fn=20);
	}
}

module bearing()
{
	// LM8UU bushing holder
	// Inspired/derived from:
	// http://www.thingiverse.com/thing:14814

	// screw/nut dimensions
	screw_dia = 4.2;
	nut_dia = 6.9;
	nut_height=2;

	// main body dimensions
	body_width = 21;
	gap_width = 10;
	body_height = 20;

	//this was the original way LM8UU_dia = 16.2; //for cross slider use 16.2 because I have different bearings ... 15.2 for axis sliders
	// should be LM8UU_dia = 15.2; //for cross slider use 16.2 this is current ... because I have different bearings ... 16.2 for axis sliders
	LM8UU_dia = 16.2; //temporary for cross slider use 16.2 because I have different bearings ... 15.2 for axis sliders
	screw_elevation = body_height-1.5;

	// main body
	difference()
	{
		union()
		{
			//mount_plate();

			translate([0,0,10])
				cube([body_width,25,body_height], center=true);

			// nut trap surround
			translate([gap_width/2,0,screw_elevation])
				rotate([0,90,0])
					cylinder(r=nut_dia/2+2, h=body_width/2 - gap_width/2, $fn=6);

			// Screw hole surround
			translate([-gap_width/2,0,screw_elevation])
				rotate([0,-90,0])
					cylinder(r=nut_dia/2+2, h=(body_width-gap_width)/2 - nut_height, $fn=20);
		}

		// bushing hole
		translate([0,0,LM8UU_dia/2+2])
			rotate([90,0,0])
				cylinder(r=LM8UU_dia/2, h=25.1, center=true);

		// top gap
		translate([0,0,20])
			cube([gap_width,25.1,20],center=true);

		// screw hole (one all the way through)
		translate([0,0,screw_elevation])
			rotate([0,90,0])
				#cylinder(r=screw_dia/2, h=100, center=true, $fn=20);

		// nut trap
		translate([body_width/2-nut_height-1,0,screw_elevation])
			rotate([0,90,0])
				cylinder(r=nut_dia/2, h=nut_height+1.5,$fn=6);
		translate([body_width/2-nut_height-1,0,screw_elevation+3])
			rotate([0,90,0])
				cylinder(r=nut_dia/2, h=nut_height+1.5,$fn=6);

		// Screw hole
		translate([-(body_width/2-nut_height),0,screw_elevation])
			rotate([0,-90,0])
				cylinder(r=nut_dia/2, h=nut_height+.01,$fn=20);
	}
}

module xymotormount()
{
	difference()
	{
		union()
		{
			translate([0,11.15,21])
				rotate([90,0,0])
					roundedBox([60, 42, 7], 10, true);

			translate([-39.5,7.65,0])
				cube([80,7,16.5]);

			translate([-33,11.15,15])
				rotate([90,0,0])
					roundedBox([15, 30, 7.0], 3, true);

			translate([33,11.15,13])
				rotate([90,0,0])
					roundedBox([15, 25, 7.0], 3, true);

			translate([2,22,3.5])
				difference()
				{
					roundedBox([58, 28, 7], 6, true);

					translate([38,5,0])
						roundedBox([20, 25, 7], 3, true);
				}

			translate([25.,-13,21])
				rotate([0,90,0])
					roundedBox([42, 45, 7.0], 1, true);

			translate([22.,-30.,21])
				rotate([0,90,0])
					roundedBox([42, 10, 7.0], 1, true);

			translate([22.,3.5,21])
				rotate([0,90,0])
					roundedBox([42, 11, 7.0], 1, true);

		}

		translate([10,2,5.65])
			rotate([0,90,0])
				cylinder(r=4.3/2,h=25);

		translate([15,-13.5,21.1])
			rotate([0,90,0])
				cylinder(r=7/2,h=25);

		translate([34.6,23.5,17])
			rotate([90,0,0])
				cylinder(r=5.6/2,h=25);

		translate([-34.6,23.5,17])
			rotate([90,0,0])
				cylinder(r=5.6/2,h=25);

		translate([-18.6,24.6,-4])
			rotate([0,0,0])
				cylinder(r=5.6/2,h=25);

		translate([18.6,24.6,-4])
			rotate([0,0,0])
				cylinder(r=5.6/2,h=25);

		translate([10,2-31,5.65])
			rotate([0,90,0])
				cylinder(r=4.3/2,h=25);

		translate([10,2,5.65+31])
		{
			rotate([0,90,0])
				cylinder(r=4.3/2,h=25);
			translate([0,-2,0])
				cube([19,3.9,7]);
		}

		translate([10,2-31,5.65+31])
		{
			rotate([0,90,0])
				cylinder(r=4.3/2,h=25);
			translate([0,-2,0])
				cube([19,3.9,7]);
		}
	}
}

complete_assembly();
