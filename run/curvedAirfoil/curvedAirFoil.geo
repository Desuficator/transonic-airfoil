// Inputs
squareSide = 1; // Size of the domain
gridsize = squareSide / 1000; // Grid size
extrusionHeight = 0.01; // Small extrusion in z-direction for 2D

// Points
Point(1) = {squareSide/2, -squareSide/2, 0, gridsize};  // Bottom-right
Point(2) = {squareSide/2, squareSide/2, 0, gridsize};   // Top-right
Point(3) = {-squareSide/2, squareSide/2, 0, gridsize};  // Top-left
Point(4) = {-squareSide/2, -squareSide/2, 0, gridsize}; // Bottom-left
Point(5) = {0, -0.45, 0 , gridsize};


// Bottom surface
Line(1) = {1, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
BSpline(4) = {4, 5, 1}; 

// Line Loop and Plane Surface
Line Loop(5) = {1, 2, 3, 4}; // Define the closed loop
Plane Surface(6) = {5};         // Define the 2D surface

// Transfinite definition
Transfinite Line {1, 2, 3, 4} = 100 Using Progression 1; // 100 points along each line
Transfinite Surface {6}; // Apply transfinite meshing to the 2D surface
Recombine Surface {6};   // Create quadrilateral elements

// Extrusion for 2D mesh
surfaceVector[] = Extrude {0, 0, extrusionHeight} { // Extrude into z-direction
    Surface{6};
    Layers{1};
    Recombine;
};

// Transfinite for extruded volume
Transfinite Volume{surfaceVector[1]};
Recombine Volume{surfaceVector[1]}; // Create hexahedral elements

// Assign Physical Groups
Physical Surface("front") = surfaceVector[0];  
Physical Volume("internal") = surfaceVector[1];  
Physical Surface("outlet") = surfaceVector[2];  
Physical Surface("top") = surfaceVector[3];   
Physical Surface("inlet") = surfaceVector[4]; 
Physical Surface("bottom") = surfaceVector[5];   
Physical Surface("back") = {6};             

