//class for obstacles
public class Obstacle{
  private float xpos;
  private float ypos;
  private float wid;
  private float heig;
  
  public Obstacle(float x, float y, float w, float h){
    xpos = x;
    ypos = y;
    wid = w;
    heig = h;
  }
  
  public void display(){
    fill(#030303);
    rect(xpos,ypos,wid,heig);
  }
}
