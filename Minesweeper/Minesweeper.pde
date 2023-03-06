int WIDTH = 1080, HEIGHT = 800, PXSIZE; // 58 - mic 46 - Mediu, 34 - Mare
int sizeSelect = 2;

int SIZEW; 
int SIZEH;

int[][] gameSpace;
int[][] clickSpace;

int[] diri = {-1, -1, -1, 0, 0, 1, 1, 1};
int[] dirj = {-1, 0, 1, -1, 1, -1, 0, 1};

boolean firstClick;
boolean dead;
boolean finishedgame;
boolean settingsChanged;

int mineNumber;
int flagNumber;
int flagCop;
int minesFlagged;
int secondsPassed;
int secondsCop;

int difficultySelect = 1;
int difficulty;  //10 - easy 6 - mediu 3 - hard

PImage emptyTile, fillTile, oneTile, twoTile, threeTile, fourTile, fiveTile, sixTile, sevenTile, eightTile, flaggedTile, bombClickedTile, bombUnclickedTile, bombWrongTile, normal, clicked, finished, deadstate, border, buttonNormal, buttonClicked;
PImage[] clock = new PImage[11];

//Reset func

void resetBoard(){
 //Reset variables
 firstClick = true;
 dead = false;
 finishedgame = false;
 settingsChanged = false;

 mineNumber = 0;
 flagNumber = 0;
 minesFlagged = 0;
 secondsPassed = 0;
 
 //Difficulty and Size selector
 if(difficultySelect == 1)
   difficulty = 10;
 else if(difficultySelect == 2)
   difficulty = 6;
 else difficulty = 3;
 
 if(sizeSelect == 1)
   PXSIZE = 58;
 else if(sizeSelect == 2)
   PXSIZE = 46;
 else PXSIZE = 34;
 
 SIZEW = WIDTH/PXSIZE;  
 SIZEH = HEIGHT/PXSIZE;
 
 gameSpace = new int[SIZEH][SIZEW];
 clickSpace = new int[SIZEH][SIZEW];
  
 //First time setup of board, only bombs
 for(int i = 0; i < SIZEH; i++)
   for(int j = 0; j < SIZEW; j++){
     gameSpace[i][j] = int(random(-2,difficulty));
     if(gameSpace[i][j] != -1)
       gameSpace[i][j] = 0;
     else mineNumber++;
       
     clickSpace[i][j] = 0;
   }
   
 //Counting bombs
 for(int i = 0; i < SIZEH; i++)
   for(int j = 0; j < SIZEW; j++){
      if(gameSpace[i][j] == 0){
      int count = 0;
      
      for(int d = 0; d < 8; d++){
        int veci = i+diri[d];
        int vecj = j+dirj[d];
        
        if((veci >= 0 && veci < SIZEH) && (vecj >=0 && vecj < SIZEW) && gameSpace[veci][vecj] == -1)
          count=count-gameSpace[veci][vecj];
      }
      gameSpace[i][j] = count;
      
     }
   }
   flagNumber = mineNumber;
}

//Dead State func

void drawDeadBoard(){
  for(int i = 0; i < SIZEH; i++)
    for(int j = 0; j < SIZEW; j++){
      if(gameSpace[i][j] == -1 && clickSpace[i][j] == 0)
        image(bombUnclickedTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
      if(gameSpace[i][j] > 99)
        image(bombWrongTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
    }
}

//Setup func
void setup(){
  size(1080,960,P2D);
  frameRate(30);
  
  PFont pixfont;
  
  pixfont = createFont("PixelatedRegular.ttf", 25);
  textFont(pixfont, 25);
   
  //Loading sprites
  emptyTile = loadImage("emptyTile.png"); fillTile = loadImage("fillTile.png");
  oneTile = loadImage("1Tile.png"); twoTile = loadImage("2Tile.png");
  threeTile = loadImage("3Tile.png"); fourTile = loadImage("4Tile.png");
  fiveTile = loadImage("5Tile.png"); sixTile = loadImage("6Tile.png");
  sevenTile = loadImage("7Tile.png"); eightTile = loadImage("8Tile.png");
  bombClickedTile = loadImage("bombClickedTile.png"); bombUnclickedTile = loadImage("bombUnclickedTile.png");
  bombWrongTile = loadImage("bombWrongTile.png"); flaggedTile = loadImage("flaggedTile.png");
  normal = loadImage("normal.png"); clicked = loadImage("clicked.png");
  finished = loadImage("finished.png"); deadstate = loadImage("dead.png");
  border = loadImage("border.png"); buttonNormal = loadImage("buttonNormal.png");
  buttonClicked = loadImage("buttonClicked.png");
  
  for(int i=0; i<11; i++)
    clock[i] = new PImage();
  
  clock[0] = loadImage("timer0.png"); clock[6] = loadImage("timer6.png");
  clock[1] = loadImage("timer1.png"); clock[7] = loadImage("timer7.png");
  clock[2] = loadImage("timer2.png"); clock[8] = loadImage("timer8.png");
  clock[3] = loadImage("timer3.png"); clock[9] = loadImage("timer9.png");
  clock[4] = loadImage("timer4.png"); clock[10] = loadImage("timer-.png");
  clock[5] = loadImage("timer5.png"); 

  resetBoard();
}  

void draw(){
  background(0);
  
  stroke(#767676); 
  fill(#9b0f0f);
  
  //Mouse Border
  if(mouseX > WIDTH-PXSIZE)
    mouseX = WIDTH-PXSIZE;
    
  //Drawing the board 
  for(int i = 0; i < SIZEH; i++)
    for(int j = 0; j < SIZEW; j++){  
        if(clickSpace[i][j] == 0)
          image(fillTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);  
        else{
          if(gameSpace[i][j] == 0)
            image(emptyTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE); 
          if(gameSpace[i][j] == 1)
            image(oneTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 2)
            image(twoTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 3)
            image(threeTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 4)
            image(fourTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 5)
            image(fiveTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 6)
            image(sixTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 7)
            image(sevenTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == 8)
            image(eightTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
          if(gameSpace[i][j] == -1)
            image(bombClickedTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
        }
        //Flag
        if(clickSpace[i][j] == 0 && gameSpace[i][j] >= 99)
            image(flaggedTile, j*PXSIZE, i*PXSIZE, PXSIZE, PXSIZE);
    }
    
    //Timer
    
    if(frameCount % int(frameRate) < 1 && (!dead && !finishedgame) && !firstClick)
      secondsPassed++;
    
    //Down border
    
    image(border, 0, 781, 1058, 181);
    
    //Flags left
    
    flagCop = flagNumber;
    for(int i=0; i<4; i++){
      if(!firstClick){
        image(clock[flagCop%10], 170-i*39, 830, 39, 60);
        flagCop=flagCop/10;
      }
      else image(clock[10], 170-i*39, 830, 39, 60);
    }
    text("Flags Left", 44, 913);
    
    //Time 
    
    secondsCop = secondsPassed;
    for(int i=0; i<4; i++){
      if(!firstClick){
        image(clock[secondsCop%10], 971-i*39, 830, 39, 60);
        secondsCop=secondsCop/10;
      }
      else image(clock[10], 971-i*39, 830, 39, 60);
    }
    text("Seconds", 867, 913);
    
    //Face
    
    image(normal, 500, 837, 64, 64);
    if(finishedgame)
      image(finished, 500, 837, 64, 64);
    if(dead){
      image(deadstate, 500, 837, 64, 64);
      drawDeadBoard();
    }
    
    //Size and Difficulty Select
    fill(#9b0f0f);
    
    image(border, 246, 816, 230, 96);
    image(border, 591, 816, 230, 96);
    
    image(buttonNormal, 407, 836, 56, 56);
    image(buttonNormal, 605, 836, 56, 56);
    
    text("Size", 318, 925);
    text("Difficulty", 613, 925);
    if(difficultySelect == 1){
      fill(#0f9b30);
      text("Easy", 695, 876);
    }
    else if(difficultySelect == 2){
      fill(#bf6c2e);
      text("Medium", 695, 876);
    }
    else{
      fill(#9b0f0f);
      text("Hard", 695, 876);
    }
    
    if(sizeSelect == 1){
      fill(#0f9b30);
      text("Small", 277, 874);
    }
    else if(sizeSelect == 2){
      fill(#bf6c2e);
      text("Medium", 277, 874);
    }
    else{
      fill(#9b0f0f);
      text("Big", 277, 874);
    }

    if(mousePressed){
      if(mouseY < HEIGHT-PXSIZE/2){
        fill(#AFAFAF);  //Mouse click
        square(mouseX-mouseX%PXSIZE, mouseY-mouseY%PXSIZE, PXSIZE);
      }
      if(mouseX > 500 && mouseX < 564 && mouseY > 837 && mouseY < 891) //Face click
        image(clicked, 500, 837, 64, 64);
      if(mouseX > 407 && mouseX < 463 && mouseY > 836 && mouseY < 892)
        image(buttonClicked, 407, 836, 56, 56);
      if(mouseX > 605 && mouseX < 661 && mouseY > 836 && mouseY < 892)
        image(buttonClicked, 605, 836, 56, 56);
    }
   
   //Finish check
   if(minesFlagged-1 == mineNumber)
     finishedgame = true;
}

////////////////
//Mouse Clicks//
////////////////

void mouseReleased(){
  int posX = (mouseX-mouseX%PXSIZE)/PXSIZE;
  int posY = (mouseY-mouseY%PXSIZE)/PXSIZE;
  
  if(mouseButton == LEFT){
   //Reset check first
   if(mouseX > 500 && mouseX < 564 && mouseY > 837 && mouseY < 891)
     resetBoard();
   
   //Button check
   
   //Difficulty
   if(mouseX > 605 && mouseX < 661 && mouseY > 836 && mouseY < 892){
     difficultySelect++;
     if(difficultySelect == 4)
       difficultySelect = 1;
     resetBoard();
   }
   //Size
   if(mouseX > 407 && mouseX < 463 && mouseY > 836 && mouseY < 892){
     sizeSelect++;
     if(sizeSelect == 4)
       sizeSelect = 1;
     resetBoard();
   }
   
   //Lee 
   else if(posY < SIZEH && posX < SIZEW && gameSpace[posY][posX] < 99 && (!dead && !finishedgame)){
     //Check if first click
     if(firstClick == true){
       firstClick = false;
       if(gameSpace[posY][posX] == -1){
         gameSpace[posY][posX] = 0;
         
         int count = 0;
      
         for(int d = 0; d < 8; d++){
            int veci = posY+diri[d];
            int vecj = posX+dirj[d];
        
            if((veci >= 0 && veci < SIZEH) && (vecj >=0 && vecj < SIZEW) && gameSpace[veci][vecj] == -1)
              count=count-gameSpace[veci][vecj];
          }
          gameSpace[posY][posX] = count;
       }
      mineNumber--;
     }
     
     clickSpace[posY][posX] = 1;
     //Mine check
     if(gameSpace[posY][posX] == -1)
       dead = true;
     
     if(gameSpace[posY][posX] == 0){
       lee[] leeVec = new lee[SIZEW*SIZEH];
       for(int i = 0; i < SIZEW*SIZEH; i++)
         leeVec[i] = new lee();
         
       int prim=0;
       int ultim=0;
       int vx, vy;
       
       leeVec[prim].y = posY;
       leeVec[prim].x = posX;
       
       while(prim <= ultim){
         vx = leeVec[prim].x;
         vy = leeVec[prim].y;
         
         clickSpace[vy][vx] = 1;
         
         for(int d = 0; d < 8; d++){
           int vecx = vx + dirj[d];
           int vecy = vy + diri[d];
           
           if(vecx >=0 && vecx < SIZEW && vecy >=0 && vecy < SIZEH && gameSpace[vecy][vecx] < 99){
             if(gameSpace[vecy][vecx] == 0 && clickSpace[vecy][vecx] == 0){
               ultim++;
               leeVec[ultim].x = vecx;
               leeVec[ultim].y = vecy;
               }
             clickSpace[vecy][vecx] = 1;
             }
           }
         prim++;
       }
     }
    }
  }
  
  if(mouseButton == RIGHT && (!dead && !finishedgame)){
    if(posY < SIZEH && posX < SIZEW && clickSpace[posY][posX] == 0){
        if(gameSpace[posY][posX] < 99 && flagNumber > 0){
          gameSpace[posY][posX]+=100;
          flagNumber--;
          if(gameSpace[posY][posX] == 99)
            minesFlagged++;
        }
        else{
          if(gameSpace[posY][posX] >= 99){
            gameSpace[posY][posX]-=100;
            flagNumber++;
          }
          if(gameSpace[posY][posX] == -1)
            minesFlagged--;
        }
    }
  }
}
