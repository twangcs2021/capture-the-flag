//this is the class for player
public class Player 
{ 
  private int team;
  private color c; //color of player
  private float xpos; // xposition
  private float ypos; // yposition
  private float xspeed = 5; //speed of player
  private float yspeed = 5; //speed of player
  private int diameter = 20; //diameter of player
  private int rad = diameter/2;
  private int xdir = 1; //x direction player is going
  private int ydir = 1; //y direction player is going
  private boolean isDead = false; //is player dead?
  private boolean FlagCaptured = false; //does player have flag?
  private float initialx; //start xposition
  private float initialy; //start yposition
  //private float passedTime;
  //private float savedTime;
  //private int totalTime = 3000;
  
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
    if(xpos > 800-rad){
      xpos = 800-rad;
    }
    else if(xpos < rad){
      xpos = rad;
    }
    if(ypos > 400-rad){
      ypos = 400-rad;
    }
    else if(ypos < rad){
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
    //int startTime = millis();
    xpos = initialx;
    ypos = initialy;
    
    //update flag position
    flags[(this.team+1)%2].isCaptured = false;
    isDead = false;
    /*while(isDead){
      if(millis() - startTime >= 3000){
        isDead = false;
      }
    }*/
    
    //passedTime = millis() - savedTime;
    /*if(passedTime > totalTime){
      
    }*/
    
  }
}
