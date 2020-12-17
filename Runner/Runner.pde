/*
  Capture the Flag game!

  NOTES:
  1.flag movement
  2.player win
  3.work on how to make player dead --idea, remove player in arraylist when dead and then add back in??
  4.implement safe zone
*/

public Player player1, player2;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean aPressed = false;
boolean wPressed = false;
boolean dPressed = false;
boolean sPressed = false;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Player> players = new ArrayList<Player>();
Flag [] flags = new Flag[2];

Flag flag1;
Flag flag2;

void setup()
{
  //width and height
  int w = 800;
  int h = 400;
  
  //create canvas
  size(800, 400);
  fill(255, 204);
  
  //Create players
  player1 = new Player(80,200,#FF0000); //Create Red player #E71D36
  player1.team = 0;
  player2 = new Player(720,200,#00FF39); //Create Green player #2EC4B6
  player2.team = 1;
  players.add(player1);
  players.add(player2);
  
  //create obstacles
  Obstacle midtop = new Obstacle(350,70,100,100);
  Obstacle midbot = new Obstacle(350,230,100,100);
  Obstacle lefttop = new Obstacle(150,0,100,150);
  Obstacle leftbot = new Obstacle(150,300,100,100);
  Obstacle righttop = new Obstacle(550,0,100,100);
  Obstacle rightbot = new Obstacle(550,250,100,150);
  obstacles.add(midtop);
  obstacles.add(midbot);
  obstacles.add(lefttop);
  obstacles.add(leftbot);
  obstacles.add(righttop);
  obstacles.add(rightbot);
  
  //create flags
  flag1 = new Flag(35.0,180.0);
  flag2 = new Flag(765.0,180.0);
  flag1.c = player1.c;
  flag2.c = player2.c;
  
  flags[0] = flag1;
  flags[1] = flag2;
}
 
void draw()
{ 
  //draw backgrounds - obstacles, background, flag
  drawBackground();
  
  //Draw the player
  player1.drawPlayer();
  player2.drawPlayer();
  
  //Depending on which key is pressed update the position
  //arrow keys
  if(upPressed){
    player2.ydir = -1;
    player2.xdir = 0;
    player2.move();
  }
  if(downPressed){
    player2.ydir = 1;
    player2.xdir = 0;
    player2.move();
  }
  if (leftPressed) {
    player2.xdir = -1;
    player2.ydir = 0;
    player2.move();
  }
  if(rightPressed){
    player2.xdir = 1;
    player2.ydir = 0;
    player2.move();
  }
  //wasd keys
  if(wPressed){
    player1.ydir = -1;
    player1.xdir = 0;
    player1.move();
  }
  if(sPressed){
    player1.ydir = 1;
    player1.xdir = 0;
    player1.move();
  }
  if (aPressed) {
    player1.xdir = -1;
    player1.ydir = 0;
    player1.move();
  }
  if(dPressed){
    player1.xdir = 1;
    player1.ydir = 0;
    player1.move();
  }
  
  //updates if player touched the other player in enemy territory
  //if so, dead
  if ( dist(player1.xpos, player1.ypos, player2.xpos, player2.ypos) <= 20) {
    if(player1.xpos > 400){
      player1.dead();
    }
    if(player2.xpos < 400){
      player2.dead();
    }
  }
  
}

//draws the background of game  
void drawBackground(){
  
  //draws territory color
  fill(#8B1212); //red territory #6F0400
  rect(0,0,400,400);
  fill(#128B29); //green territory #013E32
  rect(400,0,400,400);
  
  //draws each obstacle
  for(int i = 0; i < obstacles.size(); i++){
    Obstacle o = obstacles.get(i);
    o.display();
  }
  fill(#B9B9B9);
  
  //create and draw safe zone
  int r = 100;
  int h = 200;
  rect(0,100, r,h);
  rect(700,100,r,h);
  
  //draws the flag
  flags[0].drawflag(player2);
  flags[1].drawflag(player1);
  
}

//methods for checking which key is pressed
void keyPressed(){
  
  if (keyCode == UP) {
    upPressed = true;
  }
  else if (keyCode == DOWN) {
    downPressed = true;
  }
  else if (keyCode == LEFT) {
    leftPressed = true;
  }
  else if (keyCode == RIGHT) {
    rightPressed = true;
  }
  
  if (key =='d') {
    dPressed = true;
  }
  else if (key =='a') {
    aPressed = true;
  }
  else if (key =='w') {
    wPressed = true;
  }
  else if (key =='s') {
    sPressed = true;
  }
  
}
void keyReleased(){
  
  if (keyCode == UP) {
    upPressed = false;
  }
  else if (keyCode == DOWN) {
    downPressed = false;
  }
  else if (keyCode == LEFT) {
    leftPressed = false;
  }
  else if (keyCode == RIGHT) {
    rightPressed = false;
  }
  
  if (key =='d') {
    dPressed = false;
  }
  else if (key =='a') {
    aPressed = false;
  }
  else if (key =='w') {
    wPressed = false;
  }
  else if (key =='s') {
    sPressed = false;
  }
  
}
