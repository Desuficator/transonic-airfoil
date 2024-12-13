// Inputs
squareSide = 1; // Size of the domain
diamondWidth = 0.6;
diamondHeight = 0.2;
gridsize = squareSide / 100; // Grid size
extrusionHeight = 0.01; // Small extrusion in z-direction for 2D

// Points for square boundary
Point(1) = {2*squareSide, 0, 0, gridsize};  // Bottom-right
Point(2) = {2*squareSide, squareSide, 0, gridsize};   // Top-right
Point(3) = {0, squareSide, 0, gridsize};  // Top-left
Point(4) = {0, 0, 0, gridsize}; // Bottom-left

// Lines for square boundary
Line(1) = {1, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 1}; 

// Line Loop for square
Line Loop(5) = {1, 2, 3, 4};

// Points for diamond
Point(7) = {squareSide/2 - diamondWidth/2, squareSide/2, 0, gridsize};
Point(8) = {squareSide/2, squareSide/2 + diamondHeight/2, 0, gridsize};
Point(9) = {squareSide/2 + diamondWidth/2, squareSide/2, 0, gridsize};
Point(10) = {squareSide/2, squareSide/2 - diamondHeight/2, 0, gridsize};

// Lines for diamond
Line(5) = {7, 8}; 
Line(6) = {8, 9}; 
Line(7) = {9, 10}; 
Line(8) = {10, 7}; 

// Line Loop for diamond
Line Loop(6) = {5, 6, 7, 8};

// Subtract diamond from square to create a hole
Plane Surface(7) = {5, -6}; // Square with diamond hole

// Extrusion for 2D mesh
extruded[] = Extrude {0, 0, extrusionHeight} {
    Surface{7};
    Layers{1};
    Recombine;
};

// Assign Physical Groups
Physical Surface("front") = {extruded[0]};    // Front surface
Physical Volume("internal") = {extruded[1]};  // Extruded volume
Physical Surface("outlet") = {extruded[2]};     
Physical Surface("top") = {extruded[3]}; 
Physical Surface("inlet") = {extruded[4]};   
Physical Surface("bottom") = {extruded[5]};  
Physical Surface("diamondLeftUpper") = {extruded[6]};    
Physical Surface("diamondRightUpper") = {extruded[7]};  
Physical Surface("diamondRightLower") = {extruded[8]};    
Physical Surface("diamondLeftLower") = {extruded[9]};  
Physical Surface("back") = {7};      
