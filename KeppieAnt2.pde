// KeppieAnt2

int preset = 3;
// [0]: LR...............Original Langton's ant. Simplicity. Chaos. Emergent order. (MIRRORED)
// [1]: RLR..............Grows chaotically. It is not known whether this ant ever produces a highway.
// [2]: LLRR.............Grows symmetrically.
// [3]: LRRRRRLLR........Fills space in a square around itself.
// [4]: LLRRRLRLRLLR.....Creates a convoluted highway.
// [5]: RRLLLRLLLRRR.....Creates a filled triangle shape that grows and moves.
// [6]: RLLR.............One of the simplest examples of a keppie ant that produces patterns that become symmetric over and over again.
// RRLRR The smallest square-filling "highway"
// RLRLRLRLRLRLR Creates a nice highway.
// RRRRRRRRRRLRRRRRRRRRLRRRRRRRRRR Surprising, check it out!
// RLRLRLRLRLRLR is a nice one
// RLRRRRRLR sure is an interesting one.
// manual input
// make starting direction right
// make state 0 right, eg. LR should maybe be RL, (original)
// handeling presets and manual input better (setting string of character, reading string characters with for loop for position in string)
// changing 0 for dir-- to L, changing 1 for dir++ to R
// hexagonal grid, presets, NORTH, EAST, SOUTH, WEST, 
// Art
// zoom/pan bug preset 5
// Always start with R or L and then the rest so it's easier to compare different ants
// multiple ants
// 4 ants sick repetitive symetry! loading icon!

int[][] grid;
int x;
int y;
int dir;
PImage img;

final int NORTH = 0;
final int EAST = 1;
final int SOUTH = 2;
final int WEST = 3;

float scale = 1;
float xPan = width*8;
float yPan = height*4.5;
boolean zoomIn = false;
boolean zoomOut = false;
boolean panUp = false;
boolean panDown = false;
boolean panLeft = false;
boolean panRight = false;
float panSpeed = 10;
float zoomSpeed = 1.1;

//Rules:
int directions = 4;
int states = 12;
int s0 = 1;
int s1 = 1;
int s2 = 0;
int s3 = 0;
int s4 = 0;
int s5 = 1;
int s6 = 0;
int s7 = 0;
int s8 = 0;
int s9 = 1;
int s10 = 1;
int s11 = 1;

void setup() {
  frameRate(2147483647);
  // Max frameRate: 2147483647
  //size(1600, 900);
  fullScreen();
  preset(preset);
  img = createImage(width, height, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(0);
  }
  img.updatePixels();
  image(img, 0, 0);
  grid = new int[width][height];
  x = width/2;
  y = height/2;
  dir = NORTH;
}

void preset(int preset) {
  switch (preset) {
  case 0:
    states = 2; 
    s0 = 0; 
    s1 = 1;
    break;
  case 1:
    states = 3;
    s0 = 1; 
    s1 = 0; 
    s2 = 1;
    break;
  case 2:
    states = 4;
    s0 = 0; 
    s1 = 0; 
    s2 = 1; 
    s3 = 1;
    break;
  case 3:
    states = 9; 
    s0 = 0; 
    s1 = 1; 
    s2 = 1; 
    s3 = 1; 
    s4 = 1; 
    s5 = 1; 
    s6 = 0; 
    s7 = 0; 
    s8 = 1;
    break;
  case 4:
    states = 12;
    s0 = 0; 
    s1 = 0; 
    s2 = 1; 
    s3 = 1; 
    s4 = 1; 
    s5 = 0; 
    s6 = 1; 
    s7 = 0; 
    s8 = 1; 
    s9 = 0; 
    s10 = 0; 
    s11 = 1;
    break;
  case 5:
    states = 12;
    s0 = 1; 
    s1 = 1; 
    s2 = 0; 
    s3 = 0; 
    s4 = 0; 
    s5 = 1; 
    s6 = 0; 
    s7 = 0; 
    s8 = 0; 
    s9 = 1; 
    s10 = 1; 
    s11 = 1;
    break;
  case 6:
    states = 4; 
    s0 = 1; 
    s1 = 0; 
    s2 = 0; 
    s3 = 1;
    break;
  }
}

void turn() {
  switch(grid[x][y]) {
  case 0:
    dirChange(s0);
    break;
  case 1:
    dirChange(s1);
    break;
  case 2:
    dirChange(s2); 
    break;
  case 3:
    dirChange(s3);
    break;
  case 4:
    dirChange(s4);
    break;
  case 5:
    dirChange(s5); 
    break;
  case 6:
    dirChange(s6); 
    break;
  case 7:
    dirChange(s7); 
    break;
  case 8:
    dirChange(s8); 
    break;
  case 9:
    dirChange(s9);
    break;
  case 10:
    dirChange(s10);
    break;
  case 11:
    dirChange(s11);
    break;
  }
  //W to N and N to W:
  if (dir >= directions) {
    dir = 0;
  } else if (dir < 0) {
    dir = directions - 1;
  }
}

void dirChange(int adaptation) {
  if (adaptation == 0) {
    dir--;
  } else if (adaptation == 1) {
    dir++;
  }
}

void changeState() {
  grid[x][y]++;
  //Back to first state once a cell has gone through all of the states:
  if (grid[x][y] >= states) {
    grid[x][y] = 0;
  }
}

void changePixel() {
  switch(grid[x][y]) {
  case 0:  
    img.pixels[x + y * width] = color(0, 0, 255);
    break;
  case 1:
    img.pixels[x + y * width] = color(0, 255, 0);
    break;
  case 2:
    img.pixels[x + y * width] = color(255, 0, 0);
    break;
  case 3:
    img.pixels[x + y * width] = color(255, 255, 0);
    break;
  case 4:
    img.pixels[x + y * width] = color(0, 255, 255);
    break;
  case 5:
    img.pixels[x + y * width] = color(255, 0, 255);
    break;
  case 6:
    img.pixels[x + y * width] = color(127, 255, 255);
    break;
  case 7:
    img.pixels[x + y * width] = color(0, 0, 0);
    break;
  case 8:
    img.pixels[x + y * width] = color(127, 127, 127);
    break;
  case 9:
    img.pixels[x + y * width] = color(127, 255, 0);
    break;
  case 10:
    img.pixels[x + y * width] = color(127, 0, 255);
    break;
  case 11:
    img.pixels[x + y * width] = color(255, 255, 255);
    break;
  }
}

void move() {
  switch(dir) {
  case NORTH:  
    y--; 
    break;
  case EAST:   
    x++; 
    break;
  case SOUTH:  
    y++; 
    break;
  case WEST:   
    x--; 
    break;
  }
  //Out of window to other side of the window:
  if (x > width-1) {
    x = 0;
  } else if (x < 0) {
    x = width-1;
  }
  if (y > height-1) {
    y = 0;
  } else if (y < 0) {
    y = height-1;
  }
}

void visionControl() {
  translate (width/2, height/2);
  scale (scale);
  translate (-xPan, -yPan);
  if (zoomIn) {
    scale *= zoomSpeed;
  }
  if (zoomOut) {
    scale /= zoomSpeed;
  }
  if (panUp) {
    yPan -= panSpeed;
  }
  if (panDown) {
    yPan += panSpeed;
  }
  if (panLeft) {
    xPan -= panSpeed;
  }
  if (panRight) {
    xPan += panSpeed;
  }
}

void feedBack() {
  println("\r\n\r\n\r\nStep#:          " + (frameCount) + " M");
  println("Steps/s:        " + (frameRate) + " M");
}

void draw() {
  for (int i = 0; i < 1000; i++) {
    turn();
    changeState();
    changePixel();
    move();
  }

  //  visionControl();
  img.pixels[x + y * width] = color(255, 0, 0);
  img.updatePixels();
  image(img, 0, 0);

  if (frameCount % 100 == 0) {
    feedBack();
  }

  //if (frameCount % 1000 == 0) {
  //  // So every gigastep (1000 * 1000 * 1000) (10^9 or G or billion)
  //  println("Saving frame!");
  //  saveFrame();
  //}
}

void mouseClicked() {
  println("Saving frame!");
  saveFrame();
}

void keyPressed() {
  if (keyCode == UP) {
    zoomIn = true;
    zoomOut = false;
  }
  if (keyCode == DOWN) {
    zoomOut = true;
    zoomIn = false;
  }
  if (key == 'w') {
    panUp = true;
    panDown = false;
  }
  if (key == 's') {
    panDown = true;
    panUp = false;
  }
  if (key == 'a') {
    panLeft = true;
    panRight = false;
  }
  if (key == 'd') {
    panRight = true;
    panLeft = false;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    zoomIn = false;
  }
  if (keyCode == DOWN) {
    zoomOut = false;
  }
  if (key == 'w') {
    panUp = false;
  }
  if (key == 's') {
    panDown = false;
  }
  if (key == 'a') {
    panLeft = false;
  }
  if (key == 'd') {
    panRight = false;
  }
}
