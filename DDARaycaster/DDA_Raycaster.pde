void setup() {
  size(1080, 720);
  background(#0f0f0f);
  noFill();
  stroke(#A5A5A5);
  noCursor();
  fullScreen();

  map = new int[100][100];

  velocity = new PVector(0, 0);
  playerPos = new PVector(500, 500);
  mouseDir = new PVector(0, 0);
}

void draw() {


  background(#0f0f0f);
  if (debug)
    renderDG();
  else renderFP();

  checkMovement();
  checkMouse();
}

void checkMovement() {
  if (keyUp)
    velocity.add((PVector.fromAngle(viewAngle)).mult(speedValue));
  if (keyDown)
    velocity.add((PVector.fromAngle(viewAngle)).mult(-speedValue));
  if (keyLeft)
    velocity.add((PVector.fromAngle(viewAngle - HALF_PI)).mult(speedValue));
  if (keyRight)
    velocity.add((PVector.fromAngle(viewAngle + HALF_PI)).mult(speedValue));

  velocity.limit(2);

  //playerPos.add(velocity);
  PVector temp = new PVector();
  temp.set(playerPos);
  temp.add(velocity);
  temp.add(velocity);
  temp.add(velocity);
  temp.add(velocity);
  if (map[int(temp.y) / pxSize][int(temp.x) / pxSize] != 1)
    playerPos.add(velocity);
  else velocity.set(0, 0);
  velocity.mult(0.9);
}

void checkMouse() {
  if (mouseRight && debug) {
    int iMouseX = mouseX / pxSize;
    int iMouseY = mouseY / pxSize;

    map[iMouseY][iMouseX] = 1; //(map[iMouseY][iMouseX] == 1)? 0 : 1;
  }
  if (debug) {
    fill(#4D71C9);
    strokeWeight(2);
    line(playerPos.x, playerPos.y, mouseX, mouseY);
  }

  float addAngle = (mouseX - pmouseX) * 0.01;
  print(addAngle, '\n');
  viewAngle += addAngle;

  mouseDir = PVector.fromAngle(viewAngle);

  if (viewAngle > TWO_PI)
    viewAngle = 0;
  if (viewAngle < 0)
    viewAngle = TWO_PI;

  PVector dirVector = new PVector(mouseX, mouseY);
  PVector posVector = new PVector(playerPos.x, playerPos.y);
  dirVector = PVector.fromAngle(viewAngle);
  //dirVector.sub(posVector);

  float baseAngle = dirVector.heading();
  float wallHeight;

  for (float i = 0; i < screenWidth; i += 8) {
    wallHeight = DDA(playerPos.x, playerPos.y, baseAngle - QUARTER_PI + 2 * i / screenWidth * QUARTER_PI);
    if (wallHeight != -1) {
      wallHeight = height / wallHeight;
      push();
      rectMode(CENTER);

      fill(color(wallHeight / 8, wallHeight / 8, wallHeight / 8));
      rect(i, height / 2, 8, wallHeight);
      pop();
    }
  }
  //DDA(pX, pY, mouseX, mouseY);
}

void renderFP() {
}

void renderDG() {
  stroke(#A5A5A5);
  strokeWeight(1);
  for (int y = 0; y < mapHeight; y++)
    for (int x = 0; x < mapWidth; x++) {
      if (map[y][x] == 1)
        fill(#D89797);
      else fill(#0f0f0f);
      square(x * pxSize, y * pxSize, pxSize);
    }


  noStroke();
  fill(#44BC45);
  circle(mouseX, mouseY, 16);
  fill(#C9514D);
  circle(playerPos.x, playerPos.y, 16);
}


void mousePressed() {
  if (mouseButton == RIGHT) {
    mouseRight = true;
  }

  if (mouseButton == LEFT)
    mouseLeft = true;
}

void mouseReleased() {
  if (mouseButton == LEFT)
    mouseLeft = false;
  if (mouseButton == RIGHT)
    mouseRight = false;
}

void keyPressed() {
  if (key == 'w')
    keyUp = true;
  if (key == 's')
    keyDown = true;
  if (key == 'd')
    keyRight = true;
  if (key == 'a')
    keyLeft = true;
}

void keyReleased() {
  if (key == 'w')
    keyUp = false;
  if (key == 's')
    keyDown = false;
  if (key == 'd')
    keyRight = false;
  if (key == 'a')
    keyLeft = false;

  if (key == 'g') {
    debug = !debug;
    background(#0f0f0f);
  }
}
