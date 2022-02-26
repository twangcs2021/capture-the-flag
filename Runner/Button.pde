public class Button{
  private int xpos;
  private int ypos;
  private int w;
  private int h;
  private String m;
  private boolean Clicked = false;
  private color fillc;
  private color filltext = 50;
  
  public Button(int x, int y, int wid, int hei, color fill, String message){
     xpos = x;
     ypos = y;
     w = wid;
     h = hei;
     m = message;
     fillc = fill;
  }
  
  //shows button and updates the properties of button
  public void display(){
    
    //display button
    fill(fillc);
    rectMode(CENTER);
    rect(xpos,ypos,w,h);
    fill(filltext);
    textAlign(CENTER);
    text(m,xpos,ypos,w,h);
    
    //check if mouse is clicked
    if(mouseX <= xpos+w/2 && mouseX >= xpos-w/2 && mouseY <= ypos + h/2 && mouseY >= ypos - h/2){
      fill(#FFFFFF);
      rect(xpos,ypos,w,h);
      fill(#000000);
      text(m,xpos,ypos,w,h);
      if(mousePressed){
        Clicked = true;
      }
    }
    else{
      fill(fillc);
      rect(xpos,ypos,w,h);
      fill(50);
      text(m,xpos,ypos,w,h);
    }
    
    //to not mess up all my rectangles bc i was stupid and just used corner ver entire time
    rectMode(CORNER);
  }
}
