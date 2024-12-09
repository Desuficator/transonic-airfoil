// Inputs
squareSide = 1; // Size of the domain
gridsize = squareSide / 100; // Grid size
extrusionHeight = 0.01; // Small extrusion in z-direction for 2D

// Points
Point(1) = {squareSide/2, -squareSide/2, 0, gridsize};  // Bottom-right
Point(2) = {squareSide/2, squareSide/2, 0, gridsize};   // Top-right
Point(3) = {-squareSide/2, squareSide/2, 0, gridsize};  // Top-left
Point(4) = {-squareSide/2, -squareSide/2, 0, gridsize}; // Bottom-left
Point(5) = {0, -7*squareSide/16, 0, gridsize}; // Center-bottom (triangle apex)

// Bottom surface
Line(1) = {1, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 5}; 
Line(5) = {5, 1}; 

// Line Loop and Plane Surface
Line Loop(6) = {1, 2, 3, 4, 5}; // Define the closed loop
Plane Surface(7) = {6};         // Define the 2D surface


// Extrusion for 2D mesh
surfaceVector[] = Extrude {0, 0, extrusionHeight} { // Extrude into z-direction
    Surface{7};
    Layers{1};
    Recombine;
};

// Assign Physical Groups
// Assign Physical Groups
Physical Surface("front") = surfaceVector[0];    // Front surface
Physical Volume("internal") = surfaceVector[1];   // Extruded volume
Physical Surface("outlet") = surfaceVector[2];   // Bottom triangular surface
Physical Surface("top") = surfaceVector[3];   // Outlet (left side)
Physical Surface("inlet") = surfaceVector[4];    // Inlet (right side)
Physical Surface("bottomLeft") = surfaceVector[5];      // Top surface
Physical Surface("bottomRight") = surfaceVector[6];   // Outlet (left side)
Physical Surface("back") = {7};                  // Back surface

