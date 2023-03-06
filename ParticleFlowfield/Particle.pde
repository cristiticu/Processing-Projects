class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  
  PVector previousPos;
  
  int currentHSBvalue;
  
  float xoff_particle;
  float yoff_particle;
  
  Particle(PVector startPos){
    pos = new PVector(0, 0);
    pos.set(startPos);
    
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    previousPos = new PVector(0, 0);
    previousPos.set(pos);
    
    currentHSBvalue = 0;
  }
  
  void checkFlow(){
   xoff_particle = (pos.x/scale) / 50;
   yoff_particle = (pos.y/scale) / 50;
   
   PVector flowVector = new PVector();
   flowVector = PVector.fromAngle(noise(xoff_particle, yoff_particle, zoff_global) * TWO_PI * 6);
   flowVector.setMag(0.5);
   
   acc.add(flowVector);
  }
  
  void render(){
    if(doBackground)
      stroke(0); 
    else{ 
      stroke(currentHSBvalue, 150, 150, 5);
      currentHSBvalue ++;  
      if(currentHSBvalue > 255)
        currentHSBvalue = 0;
    }
    line(pos.x, pos.y, previousPos.x, previousPos.y);
  }
  
  void checkEdges(){
    if(pos.x > width){
      pos.set(0, random(height));
      vel.setMag(random(10, 50));
      previousPos.set(pos);
    }
    
    if(pos.x < 0){
      pos.set(width, random(height));
      vel.setMag(random(10, 50));
      previousPos.set(pos);
    }
    
    if(pos.y > height){
      pos.set(random(width), 0);
      vel.setMag(random(10, 50));
      previousPos.set(pos);
    }
    
    if(pos.y < 0){
      pos.set(random(width), height);
      vel.setMag(random(10, 50));
      previousPos.set(pos);
    }
  }
  
  void updateVel(){
    previousPos.set(pos.x, pos.y);
   
    pos.add(vel);
    
    if(vel.mag() >= 5)
      previousPos.set(pos.x, pos.y);
      
    vel.limit(0.75);
    vel.add(acc);
    acc.mult(0);
    
    
    checkEdges();
  }
  
  void resetPos(){
    pos.set(random(width), random(height));
    previousPos.set(pos);
  }
}
