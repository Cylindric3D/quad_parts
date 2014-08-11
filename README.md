This is a small case I made for the the GPS receiver base on a Ublox NEO-6M, as shipped by [Unmanned Tech](http://www.unmannedtech.co.uk) in the UK.  
---  
Update 11/08/2014: Added a bit more space around the parts to allow for slight over-printing problems stopping the lid from attaching. Added an option to create four holes in the base to allow for fixing to a quad. There is now also a configurable  parameter ```tolerance```, which is a distance that will be added between the lid and the base, and between the base and the PCB. The default is set pretty tight.  
---  
The latest snapshot is available on [GitHub](https://github.com/Cylindric3D/quad_parts).
---
Print out the two parts that comprise the base and the lid. The defaults should be fine for a v2 GPS module, although the tolerances are set very tight.  
Either using the Configurator here, or by editing the scad file, you can easily change the following settings:  
```GpsBase``` The width of the GPS PCB. Assumed to be square, if yours isn't, put the longest dimension.  
```UnderDepth``` and ```OverDepth``` The clearance required below and above the PCB for components.  
```CableHoleW``` The width of the hole for the cable.  
```CableHolePos``` How far from the edge is the cable connector?  
```MountingCentres``` The distance between the mounting holes to make in the base. Set to zero to not make any holes.  
```MountingBoltSize``` The diameter of the mounting holes.  
```Thickness``` How thick to make the walls, floor and lid.  
```Shelf``` How wide to make the shelf that the PCB sits on. Probably only need to change this if you have some components particularly close to the edge of the PCB.  
```CornerRadius``` How curved to make the box.  
```PCB``` The thickness of the PCB.  
```Window``` The diameter of the hole in the lid for the GPS signals to go through. Set to zero for no hole.  
```Tolerance``` The extra space to add between the lid and base, and between the PCB and the walls.
