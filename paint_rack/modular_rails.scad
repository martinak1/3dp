/* [top_rail] */
// Number of holes in the rail
hole_num = 10;
// Hole the paint bottle slips into in mm
body_hole_diameter = 25;
// The space between each hole in mm
body_hole_gap = 5;

/* [bottom_rail] */
nozzle_hole_diameter = 8;

/* [rail] */
// The thickness of the rail in mm
rail_height = 5;
// The width of the locking tabs
tab_width = 5;
// The angle of the rails in degrees
rail_angle = 80;

/* [frame] */
// Number of rails the frame is 
rail_pairs = 8;
rail_spacing = 25;

// calculates the width of the rail
function compute_rail_width (hole_num=hole_num, 
                            body_hole_diameter=body_hole_diameter, 
                            body_hole_gap=body_hole_gap) =
   (hole_num * body_hole_diameter) + ((hole_num - 1) * body_hole_gap) + (2 * body_hole_gap);

// Calculates the height of the frame 
function compute_frame_height (rail_pairs=rail_pairs ) = 0;

/* [Computed_Values] */
// Length (x-axis) of the rail in mm; Space consumed by the holes + The space between the holes + beginning and end gap
rail_width = compute_rail_width();
// Depth (y-axis) of the rail in mm; Pot diameter + 2.5mm on each side
rail_depth = body_hole_diameter + 5;
// the height (z-axis) of the tab; 1/2 of the rail height
tab_height = rail_height / 2;
// The gap between bottle nozzles on the bottom rail
nozzle_hole_gap = (body_hole_diameter / 2) + body_hole_gap;


// Builds the basic rail shape
module rail(rail_width=rail_width, rail_depth=rail_depth, 
            rail_height=rail_height, tab_width=tab_width) {
    union () {
        // add the locking tabs
        cube([rail_width + (tab_width * 2), rail_depth / 2, rail_height / 2], center=true);
        // add the rail
        cube([rail_width, rail_depth, rail_height], center=true);
    }
}


module top_rail(rail_width=rail_width, rail_height=rail_height, 
                body_hole_gap=body_hole_gap, 
                body_hole_diameter=body_hole_diameter) {

    difference () {
        rail();
        // Punch out the holes
        for( x=[((rail_width / 2) * -1) + body_hole_gap + (body_hole_diameter / 2) : (body_hole_gap + body_hole_diameter) : (rail_width / 2) - body_hole_gap - (body_hole_diameter / 2)] ) {
            translate([x, 0, 0])
                cylinder(r=(body_hole_diameter / 2), h=rail_height + 1, center=true);
        }
    }
}

module bottom_rail(rail_width=rail_width, rail_height=rail_height, 
                   body_hole_gap=body_hole_gap, 
                   body_hole_diameter=body_hole_diameter, 
                   nozzle_hole_diameter=nozzle_hole_diameter) {

    difference () {
        rail();
        // punch out the holes
        for( x=[((rail_width / 2) * -1) + body_hole_gap + (body_hole_diameter / 2) : (body_hole_gap + body_hole_diameter) : (rail_width / 2) - body_hole_gap - (body_hole_diameter / 2)] ) {
            translate([x, 0, 0])
                cylinder(r=(nozzle_hole_diameter / 2), h=rail_height + 1, center=true);
        }
    }

}

module frame(rail_depth=rail_depth, rail_height=rail_height, 
             rail_pairs=rail_pairs, tab_width=tab_width, tab_height=tab_height) {
    cube([tab_width, rail_depth, 100], center=true);

}

translate([0, 0, rail_spacing]) top_rail();
bottom_rail();
translate([(rail_width / 2) * -1, 0, 0]) frame();