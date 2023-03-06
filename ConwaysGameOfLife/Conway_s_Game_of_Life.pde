GoF_Func game_func;

int WINDOW_WIDTH = 1720;
int WINDOW_HEIGHT = 960;

int cell_size = 4;
int cell_numbers = 15000;

void setup() {
  size (1720, 960);
  background (#343434);
  noStroke();
  fill(#A5A5A5);

  game_func = new GoF_Func(WINDOW_HEIGHT, WINDOW_WIDTH, cell_size);
  
  for(int i = 0; i < cell_numbers; i++)
    game_func.setlive(int(random(game_func.pxheight)),int(random(game_func.pxwidth)));
    
  frameRate(10);
}

void draw() {

  game_func.think();
  game_func.render();

}
