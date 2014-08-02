GpsBase = 50;
UnderDepth = 5;
OverDepth = 8;
Thickness = 1;
Shelf = 3;
CornerRadius = Thickness;
PCB = 1.6;
Window = 25;
CableHoleH = 3;
CableHoleW = 9;
CableHolePos = 16;
Tolerance = 0;
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

Base();
translate([GpsBase+Thickness*3, 0, 0]) Lid();