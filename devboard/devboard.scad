/* vim:ts=4
 * Description: Holder for two breadboards and SOC/SBC
 * Author:      martinak
 * Version:     0
 * Dimensions:  X,Y,Z
 */

// Storage Cap (SC): 2x USB; 2xSD
module Cap () {

    union () {
        // Top Plate (TP): 
        translate ([171, 162, 14])
            cube( [40, 13, 1]);

        // SD Card 1 (SD1): [24, 2.1, *]
        translate ([171, 164, 3])
            cube ([24, 3, 11]);

        // SD Card 2 (SD2): [24, 2.1, *]
        translate ([171, 170, 3])
            cube ([24, 3, 11]);

        // translate() -> shift usb block over. 
        // USB 1 (USB1): [12.2, 4.6, *]
        translate ([198, 162, 3])
            cube ([5, 13, 11]);

        // USB 2 (USB2): [12.2, 4.6, *]
        translate ([206, 162, 3])
            cube ([5, 13, 11]);
    }
}


// Body: 2x Bread Board; 2x SBC/SOC; 2x SD Card; 2x USB
module Body () {

    // (SH - BB - PI - PT1 - PT2 - PT3) - USB
    difference () {

        // (SH - BB - PI - PT1 - PT2) - PT3
        difference () {

            // (SH -BB - PI - PT1) - PT2
            difference () {
    
                // (SH -BB -PI - PT1) - PT2
                difference () {
    
                    // (SH - BB - PI) - PT1
                    difference () {

                        // (SH - BB) - PI
                        difference () {

                            // Shell - BB
                            difference () {
                                // Shell (Sh): [223, 200, 13]
                                // x: +9 for walls/divider; y: flush w/ BB; z: +3 for floor
                                cube ([214, 179, 13]);
    
                                // Bread Board (BB): [163.7, 54.6, 9.7] + y -> [165, 110, 10] 
                                translate ([3, 66, 3])
                                    cube ([165, 110, 11]);

                            } // end Shell - BB
    
                            translate ([3, 3, 3])
                                cube ([165, 60, 13]);
                        } // end (SH - BB) - PI

                        // Parts Tray 1 (PT1): [40, 50, 10]
                        translate ([171, 3, 3])
                            cube ([40, 50, 11]);

                    } // end (SH - BB - PI) - PT1

                    // Parts Tray 2 (PT2): [40, 50, 10]
                    translate ([171, 56, 3])
                        cube ([40, 50, 11]);

                } // end (SH -BB -PI - PT1) - PT2

            } // end (SH - BB - PI - PT1 - PT2) - PT3
    
            // Parts Tray 3 (PT3): [40, 50, 10]
            translate ([171, 109, 3])
                cube ([40, 50, 11]);
        }
    }
}

// Build body
difference () {
    Body ();
    Cap ();
}

// Build cap
translate([0, 30, -3])
    Cap ();

