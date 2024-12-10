// Inputs
squareSide = 1; // Size of the domain
gridsize = squareSide / 200; // Grid size
extrusionHeight = 0.01; // Small extrusion in z-direction for 2D
width = 1;
height = 1;

// Points
Point(1) = {width*squareSide, -height*squareSide/2, 0, gridsize};  // Bottom-right
Point(2) = {width*squareSide, height*squareSide/2, 0, gridsize};   // Top-right
Point(3) = {-width*squareSide, height*squareSide/2, 0, gridsize};  // Top-left
Point(4) = {-width*squareSide, -height*squareSide/2, 0, gridsize}; // Bottom-left
Point(5) = {-width*squareSide/2, -height*squareSide/2, 0, gridsize}; // Bottom-left
Point(6) = {0, -height*squareSide/2+0.05, 0 , gridsize};
Point(7) = {width*squareSide/2, -height*squareSide/2, 0, gridsize}; // Bottom-left

// Bottom surface
Line(1) = {1, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 5}; 
BSpline(5) = {5, 6, 7}; 
Line(6) = {7, 1}; 

// Line Loop and Plane Surface
Line Loop(7) = {1, 2, 3, 4, 5, 6}; // Define the closed loop
Plane Surface(8) = {7};         // Define the 2D surface


// Extrusion for 2D mesh
surfaceVector[] = Extrude {0, 0, extrusionHeight} { // Extrude into z-direction
    Surface{8};
    Layers{1};
    Recombine;
};

// Assign Physical Groups
Physical Surface("front") = surfaceVector[0];  
Physical Volume("internal") = surfaceVector[1];  
Physical Surface("outlet") = surfaceVector[2];  
Physical Surface("top") = surfaceVector[3];   
Physical Surface("inlet") = surfaceVector[4]; 
Physical Surface("bottomLeft") = surfaceVector[5];   
Physical Surface("bottom") = surfaceVector[6];   
Physical Surface("bottomRight") = surfaceVector[7];   
Physical Surface("back") = {8};             

