int[][] map;
final int pxSize = 48;
final int screenWidth = 1920;
final int screenHeight = 1080;
final int mapWidth = screenWidth / pxSize;
final int mapHeight = screenHeight / pxSize;

boolean keyLeft = false;
boolean keyRight = false;
boolean keyUp = false;
boolean keyDown = false;

boolean mouseLeft = false;
boolean mouseRight = false;

float speedValue = 2;

float viewAngle = PI;

PVector mouseDir;
PVector velocity;
PVector playerPos;

byte hitWallSide = 0;

boolean debug = false;
