//this is the class for player
public class Player 
{ 
  private int team;
  private int score = 0;
  private color c; //color of player
  private float xpos; // xposition
  private float ypos; // yposition
  private float xspeed = 5; //speed of player
  private float yspeed = 5; //speed of player
  private int diameter = 20; //diameter of player
  private int rad = diameter/2; //radius of player
  private int xdir = 1; //x direction player is going
  private int ydir = 1; //y direction player is going
  private boolean isDead = false; //is player dead?
  private boolean FlagCaptured = false; //does player have flag?
  private float initialx; //start xposition
  private float initialy; //start yposition
  
  public Player(float x, float y, color cr){
    xpos = x;
    ypos = y;
    initialx = x;
    initialy = y;
    c = cr;
  }
  
  public void move(){ 
    //updates the position based on speed and direction
    xpos = xpos + (xspeed * xdir);
    ypos = ypos + (yspeed * ydir);
    
    //updates player goes out of bounds
    if(xpos > w-rad){
      xpos = w-rad;
    }
    if(xpos < rad){
      xpos = rad;
    }
    if(ypos > h-rad){
      ypos = h-rad;
    }
    if(ypos < rad){
      ypos = rad;
    }
    
    //updates if player runs into obstacle
    for(int i = 0; i < obstacles.size(); i++){
      Obstacle wall = obstacles.get(i);
      float topleftx = wall.xpos;
      float toplefty = wall.ypos;
      float botrightx = topleftx + wall.wid;
      float botrighty = toplefty + wall.heig;
      if(xpos+rad > topleftx && xpos-rad < botrightx && ypos+rad >toplefty && ypos-rad < botrighty){
        if(xdir == 1){
          xpos = topleftx - rad;
        }
        if(xdir == -1){
          xpos = botrightx + rad;
        }
        if(ydir == 1){
          ypos = toplefty - rad;
        }
        if(ydir == -1){
          ypos = botrighty + rad;
        }
      }
    }
 }
  
  public void drawPlayer() {
    noStroke();
    fill(c);
    ellipse(xpos, ypos, diameter, diameter);
  }
  
  public void dead(){
    
    //player is dead, update position
    isDead = true;
    xpos = initialx;
    ypos = initialy;
    
    //update flag position
    flags[(this.team+1)%2].isCaptured = false;
    this.FlagCaptured = false;
    isDead = false;
    
  }
}
