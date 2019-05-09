Ramp topRamp, middleRamp, bottomRamp;
Frog frog;
ArrayList<Ramp> safe, notSave;
PImage frogImage;
float frogX, frogY;
boolean canMove = true;
boolean started = true;
 void setup(){
   size(850,660);
   safe = new ArrayList<Ramp>();
   topRamp    = new Ramp(0,0,width,45,' ');
   middleRamp = new Ramp(0,height/2-40,width,45,' ');
   bottomRamp = new Ramp(0,height-45,width,45,' ');   
   frogImage = loadImage("frog.png");
   safe.add(topRamp);
   safe.add(middleRamp);
   safe.add(bottomRamp);
   notSave = new ArrayList<Ramp>();
   initNotSafe(notSave);
 }
    
        
void draw(){   
  float s = millis();
  background(0);
  initSafe();  
  moveNotSafe();
    if(started){ 
      started = false; 
      frog = new Frog(random(0,width-45),height-50);    
    }
    player(frog,s);   
}
void moveNotSafe(){
  for( Ramp nSave : notSave){
    nSave.move();
    nSave.drawIt();
  }
}
void player(Frog frog, float s){
frog.render();

if( keyPressed){
  frog.goLeft();
  frog.goRight();
  frog.goBottom();
  frog.goTop();
  s = millis();
 }else{
   canMove = true;
 }
 if( frog.startMovingWithRamp != ' '){
   frog.move();
 } 
}

void initNotSafe(ArrayList<Ramp> notSafe){
//hardCoded obstacles
/*
..........
    - -
   - - -
..........
   - -
-  - -  -
   - -
..........
*/
notSafe.add(new Ramp(0,0,0,0,' '));
notSafe.add(new Ramp(random(0,width),60,random(80,160),50,'l'));
notSafe.add(new Ramp(random(0,width),120,random(80,160),50,'r'));
notSafe.add(new Ramp(random(0,width),180,random(80,160),50,'l'));
notSafe.add(new Ramp(random(0,width),240,random(80,160),50,'r'));
notSafe.add(new Ramp(0,0,0,0,' '));
notSafe.add(new Ramp(random(0,width),340,random(80,160),50,'l'));
notSafe.add(new Ramp(random(0,width),390,random(80,160),50,'r'));
notSafe.add(new Ramp(random(0,width),450,random(80,160),50,'l'));
notSafe.add(new Ramp(random(0,width),510,random(80,160),50,'r'));
notSafe.add(new Ramp(random(0,width),565,random(80,160),50,'l'));
notSafe.add(new Ramp(0,0,0,0,' '));
}

void initSafe(){
  for( Ramp ramp : safe){
    ramp.drawIt();
  }
}
    
class Ramp{
    float x          = 0.0;
    float y          = 0.0;
    float rampWidth  = 0.0;
    float rampHeight = 0.0;
    char dir;
    public Ramp(float x, float y, float rampWidth, float rampHeight, char dir){
        this.x          = x;
        this.y          = y;
        this.rampWidth  = rampWidth;
        this.rampHeight = rampHeight;
        this.dir        = dir;
    }  
    public void drawIt(){
        rect(this.x,this.y,this.rampWidth,this.rampHeight);        
    }
    
    public void move(){
      if( this.dir == 'l' ){ 
        this.x -= 2.5;
        if( this.x < rampWidth*-1 ) this.x += width+rampWidth;
      }else{
        this.x += 2.5;
        if( this.x > width ) this.x = rampWidth*-1;
      }
    }
}
class Frog{
  
  float x, y;
  int yPosition; 
  char startMovingWithRamp ;
  
  public Frog(float x, float y){
    this.x = x;
    this.y = y;
    this.yPosition = 11; 
    startMovingWithRamp = ' ';
  }
  public void goLeft(){
    if( this.x >= 0 && this.startMovingWithRamp ==' ' && keyCode  == LEFT)          
  { this.x -= 20; } 
  }
  public void goRight(){
    if( this.x <= width-60 && this.startMovingWithRamp ==' ' && keyCode  == RIGHT)  
  { this.x += 20; } 
  }
  public void goBottom(){
    if( this.y <= height-45 && canMove  && keyCode  == DOWN )                                                   
  { this.yPosition += 1;
    checkIfRampExists(this.yPosition, false);
    canMove = false;
} 
  }
  public void goTop(){
    if( this.y >= 0 && canMove && keyCode  == UP)  {
    this.yPosition -= 1;
    checkIfRampExists(this.yPosition, true);
    canMove = false;    
  } 
  }
  public void render(){
    image(frogImage,this.x,this.y,55,50);    
  }
  
  public void checkIfRampExists(int y, boolean isUp){
    //this.x >= i.x && (this.x+55)<= (i.rampWidth+i.x)
    Ramp ramp = notSave.get(y);
    if( ramp.dir == ' '){
      if( isUp ){ this.y -= 60; }
      else      { this.y += 60; }
      this.startMovingWithRamp = ' ';
    }else{
      if( this.x >= ramp.x && (this.x+55)<= (ramp.rampWidth+ramp.x) ){
      this.startMovingWithRamp = ramp.dir;
      this.y = ramp.y;
    }else{
      noLoop();
    }
    } 
    
  }
  public void move(){
    if( this.startMovingWithRamp == 'l' ){ 
        this.x -= 2.5;
        if( this.x < (this.x+55)*-1 ) noLoop();
      }else{
        this.x += 2.5;
        if( this.x > width ) noLoop();
      }
  }

}
        
        
        
