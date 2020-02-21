use <modular_rails.scad>;

/* [frame] */
// Number rail pairs
rail_pairs = 8;
// Space between rails
rail_space = 25;
// The depth (y-axis) of the rails
rail_y = 30;
// The height (z-axis) of the rails
rail_z = 5;
// The width of the locking tabs on the rails
tab_x = 5;


module frame () {


}

 translate([0, 0, 55]) rotate([80, 0, 0]) top_rail();
bottom_rail();
frame();