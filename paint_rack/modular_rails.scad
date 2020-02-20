// Number of holes in the rail
hole_num = 10;

/*
    Variables that effect the top rail
*/
// Hole the paint bottle slips into in mm
body_hole_diameter = 25;
// The space between each hole in mm
body_hole_gap = 5;

/*
     Variables that effect the bottom rail
*/
nozzle_hole_diameter = 8;
nozzle_hole_gap = (body_hole_diameter / 2) + body_hole_gap;

/* 
Variables that effect the rail dimensions
*/
// Depth of the rail in mm
rail_depth = body_hole_diameter + 5;
// Length of the rail in mm; Space consumed by the holes + The space between the holes + beginning and end gap
rail_width = (hole_num * body_hole_diameter) + ((hole_num - 1) * body_hole_gap) + (2 * body_hole_gap);
// The thickness of the rail in mm
rail_height = 5;
// The width of the locking tabs
tab_width = 5;
// the height of the tab; default is 1/2 of the rail height
tab_height = rail_height / 2;


module rail() {
    union () {
        // add the locking tabs
        cube([rail_width + (tab_width * 2), rail_depth / 2, rail_height / 2], center=true);
        // add the rail
        cube([rail_width, rail_depth, rail_height], center=true);
    }
}


module top_rail() {

    difference () {
        rail();
        // Punch out the holes
        for( x=[((rail_width / 2) * -1) + body_hole_gap + (body_hole_diameter / 2) : (body_hole_gap + body_hole_diameter) : (rail_width / 2) - body_hole_gap - (body_hole_diameter / 2)] ) {
            translate([x, 0, 0])
                cylinder(r=(body_hole_diameter / 2), h=rail_height + 1, center=true);
        }
    }
}

module bottom_rail() {
    difference () {
        rail();
        // punch out the holes
        for( x=[((rail_width / 2) * -1) + body_hole_gap + (body_hole_diameter / 2) : (body_hole_gap + body_hole_diameter) : (rail_width / 2) - body_hole_gap - (body_hole_diameter / 2)] ) {
            translate([x, 0, 0])
                cylinder(r=(nozzle_hole_diameter / 2), h=rail_height + 1, center=true);
        }
    }

}

translate([0, 60, 0]) top_rail();
bottom_rail();