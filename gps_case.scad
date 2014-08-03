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

module Base()
{
	translate([0, 0, Thickness])
	difference()
	{
		// Walls & floor
		translate([0, 0, -Thickness])
		hull()
		{
			translate([GpsBase+Thickness*2-CornerRadius, GpsBase+Thickness*2-CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([CornerRadius, GpsBase+Thickness*2-CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([GpsBase+Thickness*2-CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
			translate([CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = InnerHeight+Thickness);
		}
		
		// Deepest cut
		translate([Thickness+Shelf, Thickness+Shelf, 0]) cube([GpsBase-Shelf*2, GpsBase-Shelf*2, InnerHeight]);

		// Shelf
		translate([Thickness, Thickness, UnderDepth]) cube([GpsBase, GpsBase, InnerHeight]);
		
		// Hole for wire
		translate([-j, Thickness+CableHolePos, UnderDepth-CableHoleH]) cube([Thickness+Shelf+j*2, CableHoleW, CableHoleH+j]);
	}
}

module Lid()
{
	union()
	{
		difference()
		{
			hull()
			{
				translate([GpsBase+Thickness*2-CornerRadius, GpsBase+Thickness*2-CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([CornerRadius, GpsBase+Thickness*2-CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([GpsBase+Thickness*2-CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
				translate([CornerRadius, CornerRadius, 0]) cylinder(r = CornerRadius, h = Thickness);
			}
			
			// GPS Window
			translate([(GpsBase+Thickness*2)/2, (GpsBase+Thickness*2)/2, -j]) cylinder(r = Window/2, h = Thickness+j*2);
		}

		difference()
		{
			hull()
			{
				translate([GpsBase+Thickness-CornerRadius-Tolerance, GpsBase+Thickness-CornerRadius-Tolerance, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([Thickness+CornerRadius+Tolerance, GpsBase+Thickness-CornerRadius-Tolerance, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([Thickness+CornerRadius+Tolerance, Thickness+CornerRadius+Tolerance, j*2]) cylinder(r = CornerRadius, h = OverDepth);
				translate([GpsBase+Thickness-CornerRadius-Tolerance, Thickness+CornerRadius+Tolerance, j*2]) cylinder(r = CornerRadius, h = OverDepth);
			}
			hull()
			{			
				translate([GpsBase-CornerRadius-Tolerance, GpsBase-CornerRadius-Tolerance, j]) cylinder(r = CornerRadius, h = OverDepth+j*3);
				translate([Thickness*2+CornerRadius+Tolerance, GpsBase-CornerRadius-Tolerance, j]) cylinder(r = CornerRadius, h = OverDepth+j*3);
				translate([Thickness*2+CornerRadius+Tolerance, Thickness*2+CornerRadius+Tolerance, j]) cylinder(r = CornerRadius, h = OverDepth+j*3);
				translate([GpsBase-CornerRadius-Tolerance, Thickness*2+CornerRadius+Tolerance, j]) cylinder(r = CornerRadius, h = OverDepth+j*3);
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
