/*
###############################################################################
# DESCRIPTION
###############################################################################
This is a small case I made for the the GPS receiver base on a Ublox NEO-6M, as shipped by [Unmanned Tech](http://www.unmannedtech.co.uk) in the UK.

---

Update 11/08/2014: Added a bit more space around the parts to allow for slight over-printing problems stopping the lid from attaching. Added an option to create four holes in the base to allow for fixing to a quad. There is now also a configurable  parameter ```tolerance```, which is a distance that will be added between the lid and the base, and between the base and the PCB. The default is set pretty tight.

---

The latest snapshot is available on [GitHub](https://github.com/Cylindric3D/quad_parts).


###############################################################################
# INSTRUCTIONS
###############################################################################

Print out the two parts that comprise the base and the lid. The defaults should be fine for a v2 GPS module, although the tolerances are set very tight.
Either using the Configurator here, or by editing the scad file, you can easily change the following settings:

* ```GpsBase``` The width of the GPS PCB. Assumed to be square, if yours isn't, put the longest dimension.
* ```UnderDepth``` and ```OverDepth``` The clearance required below and above the PCB for components.
* ```CableHoleW``` The width of the hole for the cable.
* ```CableHolePos``` How far from the edge is the cable connector?
* ```MountingCentres``` The distance between the mounting holes to make in the base. Set to zero to not make any holes.
* ```MountingBoltSize``` The diameter of the mounting holes.
* ```Thickness``` How thick to make the walls, floor and lid.
* ```Shelf``` How wide to make the shelf that the PCB sits on. Probably only need to change this if you have some components particularly close to the edge of the PCB.
* ```CornerRadius``` How curved to make the box.
* ```PCB``` The thickness of the PCB.
* ```Window``` The diameter of the hole in the lid for the GPS signals to go through. Set to zero for no hole.
* ```Tolerance``` The extra space to add between the lid and base, and between the PCB and the walls.

###############################################################################
*/

/* [Global] */

// Which part would you like to see?
part = "both"; // [both:Lid and base,base:Base only,lid:Lid only]

/* [GPS Box] */

// Size of the GPS board
GpsBase = 51;

// Clearance required below the PCB
UnderDepth = 5;

// Clearance required above the PCB
OverDepth = 8;

// Width of the connection plug
CableHoleH = 3;

// Height of the connection plug
CableHoleW = 9;

// Distance of the connection from the edge of the board
CableHolePos = 16;

// Mounting holes for the base? (Zero=no holes)
MountingCentres = 31;

// Diameter of the mounting holes?
MountingBoltSize = 3;

/* [Advanced Settings] */
// Thickness of the walls, lid and bottom
Thickness = 1;

// Width of the shelf that supports the PCB
Shelf = 3;

// Roundness of the corners
CornerRadius = 1;

// Thickness of the PCB
PCB = 1.6;

// Diameter of the hole in the lid
Window = 25;

// Extra tolerance for the lid/base fitting
Tolerance = 0.2;

/* [Hidden] */
j = 0.1;
$fn=100;
InnerHeight = UnderDepth + PCB + OverDepth;

BaseInnerLarge = GpsBase + (Tolerance * 2);
BaseInnerSmall = BaseInnerLarge - (Shelf * 2);
BaseOuter = BaseInnerLarge + (Thickness * 2);

LidOuterLip = BaseOuter;
LidOuter = BaseInnerLarge - (Tolerance * 2);
LidInner = LidOuter - (Thickness * 2);

SemiLidOuterLip = LidOuterLip / 2;
SemiLidOuter = LidOuter / 2;
SemiLidInner = LidInner / 2;

module Base()
{
	translate([0, 0, Thickness])
	difference()
	{
		// Walls & floor
		translate([0, 0, -Thickness])
		hull()
		{
			translate([BaseOuter-CornerRadius, GpsBase+Thickness*2-CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([CornerRadius, BaseOuter-CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([BaseOuter-CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
		}
		
		// Deepest cut
		translate([Thickness+Shelf, Thickness+Shelf, 0]) cube([BaseInnerSmall, BaseInnerSmall, InnerHeight]);

		// Shelf
		translate([Thickness, Thickness, UnderDepth]) cube([BaseInnerLarge, BaseInnerLarge, InnerHeight]);
		
		// Hole for wire
		translate([-j, Thickness+CableHolePos, UnderDepth-CableHoleH]) cube([Thickness+Shelf+j*2, CableHoleW, CableHoleH+j]);
		
		// Mounting Holes
		if(MountingCentres > 0)
		{
			translate([-MountingCentres/2, -MountingCentres/2, 0]) translate([BaseOuter * 0.5, BaseOuter * 0.5, -Thickness-j]) cylinder(r = MountingBoltSize/2, h = Thickness+j*2);
			translate([-MountingCentres/2, MountingCentres/2, 0]) translate([BaseOuter * 0.5, BaseOuter * 0.5, -Thickness-j]) cylinder(r = MountingBoltSize/2, h = Thickness+j*2);
			translate([MountingCentres/2, -MountingCentres/2, 0]) translate([BaseOuter * 0.5, BaseOuter * 0.5, -Thickness-j]) cylinder(r = MountingBoltSize/2, h = Thickness+j*2);
			translate([MountingCentres/2, MountingCentres/2, 0]) translate([BaseOuter * 0.5, BaseOuter * 0.5, -Thickness-j]) cylinder(r = MountingBoltSize/2, h = Thickness+j*2);
		}
	}
}

module Lid()
{
	translate([SemiLidOuterLip, SemiLidOuterLip, 0])
	union()
	{
		difference()
		{
			// Lid lip
			hull()
			{
				translate([SemiLidOuterLip-CornerRadius,    SemiLidOuterLip-CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([-SemiLidOuterLip+CornerRadius,  SemiLidOuterLip-CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([SemiLidOuterLip-CornerRadius,   -SemiLidOuterLip+CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([-SemiLidOuterLip+CornerRadius, -SemiLidOuterLip+CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
			}
			
			if(Window > 0)
			{
				// GPS Window
				translate([0, 0, -j]) cylinder(r = Window/2, h = Thickness+j*2);
			}
		}

		difference()
		{
			// Outer dimension
			hull()
			{
				translate([SemiLidOuter-CornerRadius,   SemiLidOuter-CornerRadius, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([-SemiLidOuter+CornerRadius, SemiLidOuter-CornerRadius, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([-SemiLidOuter+CornerRadius, -SemiLidOuter+CornerRadius, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([SemiLidOuter-CornerRadius, -SemiLidOuter+CornerRadius, j*2]) cylinder(r = CornerRadius, h = OverDepth);
			}
			
			// Inner dimension
			hull()
			{			
				translate([SemiLidInner-CornerRadius,   SemiLidInner-CornerRadius, j]) cylinder(r = CornerRadius, h = OverDepth+j*2);
				translate([-SemiLidInner+CornerRadius, SemiLidInner-CornerRadius, j]) cylinder(r = CornerRadius, h = OverDepth+j*2);
				translate([-SemiLidInner+CornerRadius, -SemiLidInner+CornerRadius, j]) cylinder(r = CornerRadius, h = OverDepth+j*2);
				translate([SemiLidInner-CornerRadius, -SemiLidInner+CornerRadius, j]) cylinder(r = CornerRadius, h = OverDepth+j*2);
			}
		}
		
	}
}

module print_part()
{
	if (part == "lid")
	{
		translate([GpsBase+Thickness, GpsBase+Thickness, 0]*-0.5)
		Lid();
	} else if (part == "base")
	{
		translate([GpsBase+Thickness, GpsBase+Thickness, 0]*-0.5)
		Base();
	} else if (part == "both")
	{
		translate([-(GpsBase+Thickness*3), -(GpsBase+Thickness)*0.5, 0])
		Base();

		translate([Thickness, -(GpsBase+Thickness)*0.5, 0]) 
		Lid();
	}
}

print_part();
