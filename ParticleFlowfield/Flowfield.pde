int scale = 10;
int particleNumber = 22500;

int rows;
int cols;

float xoff_global;
float yoff_global;
float zoff_global = 0;

//Settings//
boolean isZoffStatic = false;
boolean doBackground = false;
boolean isDebugMode = false;

Particle[] particles;



void setup(){
  size(1720, 1020, P2D);
  colorMode(HSB);
  smooth(16);
  
  rows = width / scale;
  cols = height / scale;
    
  PVector randomStartPosition = new PVector();
  
  particles = new Particle[particleNumber];
  for(int i = 0; i < particleNumber; i++){
    randomStartPosition.set(random(width), random(height));
    particles[i] = new Particle(randomStartPosition);
  }
}



void draw(){ 
  if(doBackground)
    background(#C4C4C4, 0);
  
  if(isDebugMode){
    yoff_global = 0;
    for(int y = 0; y < cols; y++){
      xoff_global = 0;
      for(int x = 0; x < rows; x++){
        push();
      
        translate(x * scale, y * scale);
        rotate(noise(xoff_global, yoff_global, zoff_global) * TWO_PI * 6);
        line(0, 0, scale, 0);
      
        pop();
      
        xoff_global += 0.02;
      }
      yoff_global += 0.02;
    }
  }
  else{
    for(int i = 0; i < particleNumber; i++){
      particles[i].checkFlow();
      particles[i].updateVel();
      particles[i].render();
    }
 }
  
 if(!isZoffStatic)
   zoff_global += 0.001;
}

void keyPressed(){
  if(key == 's')
    isZoffStatic = (isZoffStatic) ? false:true;
  
  if(key == 'b')
    doBackground = (doBackground) ? false:true;
  
  if(key == 'f')
    background(#C4C4C4);
  
  if(key == 'r')
    for(int i = 0; i < particleNumber; i++)
      particles[i].resetPos();
  
  if(key == 'd')
    isDebugMode = (isDebugMode) ? false:true;
}
