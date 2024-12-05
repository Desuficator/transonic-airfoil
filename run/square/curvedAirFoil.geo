// Inputs
squareSide = 200; // Size of the domain
gridsize = squareSide / 20; // Grid size
extrusionHeight = 0.01; // Small extrusion in z-direction for 2D

// Points
Point(1) = {-squareSide/2, -squareSide/2, 0, gridsize};
Point(2) = {squareSide/2, -squareSide/2, 0, gridsize};
Point(3) = {squareSide/2, squareSide/2, 0, gridsize};
Point(4) = {-squareSide/2, squareSide/2, 0, gridsize};

// Bottom surface
Line(1) = {1, 2}; // bottom
Line(2) = {2, 3}; // inlet
Line(3) = {3, 4}; // top
Line(4) = {4, 1}; // outlet
Line Loop(5) = {1, 2, 3, 4};
Plane Surface(6) = {5};

// Extrusion for 2D mesh
surfaceVector[] = Extrude {0, 0, extrusionHeight} { // Extrude into z-direction
    Surface{6};
    Layers{1};
    Recombine;
};

// Assign Physical Groups
Physical Surface("front") = surfaceVector[0]; // Front surface
Physical Volume("internal") = surfaceVector[1]; // Extruded volume
Physical Surface("bottom") = surfaceVector[2]; // Bottom surface
Physical Surface("right") = surfaceVector[3]; // Right surface
Physical Surface("top") = surfaceVector[4]; // Top surface
Physical Surface("left") = surfaceVector[5]; // Left surface
Physical Surface("back") = {6}; // Back surface

