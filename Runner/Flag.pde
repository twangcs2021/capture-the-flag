//class for flags
public class Flag{
  private float xpos;
  private float ypos;
  private float h = 40;
  private float w = h*2/3;
  private float initialxpos;
  private float initialypos;
  private boolean isCaptured = false;
  private color c;
  
  public Flag(Float xpos, Float ypos){
    this.xpos = xpos;
    this.ypos = ypos;
    initialxpos = xpos;
    initialypos = ypos;
  }
  public void drawflag(Player p){
    
    //player still alive and captures flag update flagcaptured status
    if(p.isDead == false && p.xpos < this.xpos + this.w && p.xpos > this.xpos && p.ypos > this.ypos && p.ypos < this.ypos + this.h){
      isCaptured = true;
    }
    
    //if captured then act captured update pos
    if(isCaptured){
      this.xpos = p.xpos + p.rad - 3;
      this.ypos = p.ypos - p.rad*3 -3;
    }
    //if not captured then initial pos
    else if(!isCaptured){
      this.xpos = initialxpos;
      this.ypos = initialypos;
    }
    
    //draw the flag
    noStroke();
    fill(c);
    rect(xpos, ypos, w, h/2);
    stroke(#FFFFFF);
    line(xpos,ypos, xpos, ypos+h);
  }
  
}
