/*
  Capture the Flag game!
*/

//import sound effects
import processing.sound.*;
SoundFile deadBoop;
SoundFile scoreDing;
SoundFile winTada;
SoundFile captureWhoosh;

//create all public variables
//the two players
public Player player1, player2;
//controls
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean aPressed = false;
boolean wPressed = false;
boolean dPressed = false;
boolean sPressed = false;

int w;
int h;
Flag [] flags = new Flag[2];
boolean gameOver = false;
boolean mainMenu = true;
boolean howToPage = false;
Flag flag1;
Flag flag2;
int wincounter = 0;
int obstacleMode = 1;

//array list of objects
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Player> players = new ArrayList<Player>();

//obstacle mode 1 stuff
Obstacle midtop = new Obstacle(350,70,100,100);
Obstacle midbot = new Obstacle(350,230,100,100);
Obstacle lefttop = new Obstacle(150,0,100,150);
Obstacle leftbot = new Obstacle(150,250,100,150);
Obstacle righttop = new Obstacle(550,0,100,150);
Obstacle rightbot = new Obstacle(550,250,100,150);

void setup()
{ 
  //width and height
  w = 800;
  h = 400;
  
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
  /*obstacles.add(leftbot);
  obstacles.add(righttop);
  obstacles.add(midbot);
  obstacles.add(midtop); 
  obstacles.add(lefttop); 
  obstacles.add(rightbot);*/
  
  //create flags
  flag1 = new Flag(40.0,180.0);
  flag2 = new Flag(760.0,180.0);
  flag1.c = player1.c;
  flag2.c = player2.c;
  flags[0] = flag1;
  flags[1] = flag2;
  
  //create sound effects
  deadBoop = new SoundFile(this, "pop.mp3");
  scoreDing = new SoundFile(this, "ding.wav");
  winTada = new SoundFile(this, "tada.mp3");
  captureWhoosh = new SoundFile(this, "whoosh.mp3");
  
  wincounter = 0;
}
 
void draw()
{ 
  //draw backgrounds - obstacles, background, flag
  drawBackground();
  
  //if in mainmenu
  if(mainMenu == true){
    startScreen();
  } 
  
  //if in howto page
  else if(howToPage == true){
    howTo();
  }
  
  //if someone wins- show winner and ask if play again
  else if(player1.score == 3 || player2.score == 3){ //first person to 3 wins
    gameOver = true;
    if(player1.score == 3){
      endScreen(player1);
    }
    else{
      endScreen(player2);
    }
  }
  
  //play game!
  else{
    //Depending on which key is pressed update the position
    //arrow keys
    //Draw the player
    player1.drawPlayer();
    player2.drawPlayer();
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
    if ( dist(player1.xpos, player1.ypos, player2.xpos, player2.ypos) <= player1.diameter){
      if(player1.xpos+player1.rad > 400){
        deadBoop.play();
        player1.dead();
      }
      if(player2.xpos-player2.rad < 400){
        deadBoop.play();
        player2.dead();
      }
    }
  }
  
  //if player scored update score and position
  if(player1.FlagCaptured == true && player1.xpos == player1.rad){
    scoreDing.play();
    player1.score ++;
    player1.dead();
    player2.dead();
  }
  if(player2.FlagCaptured == true && player2.xpos == 800-player2.rad){
    scoreDing.play();
    player2.score ++;
    player1.dead();
    player2.dead();
  }
}


//draws the background of game  
void drawBackground(){
  
  //draws territory color
  fill(#8B1212); //red territory #6F0400
  rect(0,0,400,400);
  fill(#128B29); //green territory #013E32
  rect(400,0,400,400);
  
  drawObstacles();
  
  //create and draw touchdown zone
  fill(#D3D3D3);
  int r = player1.diameter;
  int h = 400;
  rect(0,0, r,h);
  rect(800-r,0,r,h);
  
  //Displays score
  textAlign(CENTER);
  textSize(32);
  fill(#FAFF00);
  text(player1.score, 200, 50);
  text(player2.score, 600, 50);
  
  //draws the flag
  flags[0].drawflag(player2);
  flags[1].drawflag(player1);
  
}

void drawObstacles(){
   //draws each obstacle by traversing arraylist
  for(int i = 0; i < obstacles.size(); i++){
    Obstacle o = obstacles.get(i);
    o.display();
  }
}

//Main menu screen
void startScreen(){
  
  //darker background
  fill(#000000,90);
  rect(0,0,w,h);
  
  //title
  textSize(60);
  fill(#FF6803);
  text("CAPTURE THE FLAG", 400, 140);
  fill(#FFD603);
  text("CAPTURE THE FLAG", 403, 142);
  textSize(30);
  
  //modify obstacle arraylist according too user's preference
  textSize(20);
  fill(#FCFEFF);
  text("Obstacle mode: " + obstacleMode, 300,310,200,50);
  Button [] obstacleButtons = new Button[3];
  Button obstacle3 = new Button(450,375,25,50,#FA5400,"3");
  Button obstacle2 = new Button(400,375,25,50,#FA5400,"2");
  Button obstacle1 = new Button(350,375,25,50,#FA5400,"1");
  
  obstacleButtons[0] = obstacle1;
  obstacleButtons[1] = obstacle2;
  obstacleButtons[2] = obstacle3;
  for(int i = 0; i < 3; i++){
    obstacleButtons[i].display();
  }
  if(obstacle1.Clicked){
    obstacleMode = 1;
  }
  if(obstacle2.Clicked){
    obstacleMode = 2;
  }
  if(obstacle3.Clicked){
    obstacleMode = 3;
  }
  
  Obstacle leftmid = new Obstacle(150,200,100,100);
  Obstacle rightmid = new Obstacle(550,100,100,100);
  Obstacle veryrightbot = new Obstacle(550,0,100,50);
  Obstacle veryleftbot = new Obstacle(150,350,100,50);
  Obstacle bigleftmid = new Obstacle(100,100,50,200);
  Obstacle bigrightmid = new Obstacle(650,100,50,200);
  
  obstacles.clear();
  obstacles.add(leftbot);
  obstacles.add(righttop); 
  obstacles.add(lefttop); 
  obstacles.add(rightbot);
  obstacles.add(midbot);
  obstacles.add(midtop);
  
  if(obstacleMode == 2){
    obstacles.remove(0);
    obstacles.remove(0);
    obstacles.add(leftmid);
    obstacles.add(rightmid);
    obstacles.add(veryleftbot);
    obstacles.add(veryrightbot);
  }
  else if(obstacleMode == 3){
    obstacles.remove(0);
    obstacles.remove(0);
    obstacles.remove(0);
    obstacles.remove(0);
    obstacles.add(bigleftmid);
    obstacles.add(bigrightmid);
  }
  
  textSize(30);
  //play button
  Button Play = new Button(400,200,200,50, #FFE600, "Play");
  Play.display();    
  if(Play.Clicked){
    mainMenu = false;
    howToPage = false;
    setup();
  }
  
  //how to play button
  Button howToPlayButton = new Button(400,265,200,50, #FF9100, "How to play");
  howToPlayButton.display();
  if(howToPlayButton.Clicked){
    mainMenu = false;
    howToPage = true;
  }
}

//how to play screen
void howTo(){
  
  //darker background
  fill(#000000,90);
  rect(0,0,w,h);
  
  //creating the instructions
  int rectx = 50;
  int recty = 50;
  int rectw = 700;
  int recth = 260;
  fill(#FFFFFF);
  rect(rectx, recty, rectw, recth);
  textSize(18);
  String instruct = "Welcome to Capture the Flag! This is a two player game, so go grab a sibling, a family member, anyone who is with you right now! ";
  instruct += "This game is like the physical Capture the Flag game and the ultimate goal of the game is to get 3 points first. ";
  instruct += "How you get points is by capturing the enemy's flag and bringing it to your touchdown zone, the gray area on your side. ";
  instruct += "One of you will be Red while the other, Green and you can control them with w,a,s,d and the arrow keys, respectively. ";
  instruct += "But watch out while trying to capture your enemy's flag, because if you're tagged in enemy territory- you get bonked back to your own. ";
  instruct += "I hope you have as much fun as my brother and I had testing it out!";
  fill(#000000);
  text(instruct,rectx, recty, rectw,recth);
  textSize(26);
  
  //back button to go back to main menu
  Button Back = new Button(400, recty+recth + 50,100,45,#FFC862, "Back");
  Back.display();
  if(Back.Clicked){
    howToPage = false;
    mainMenu = true;
    setup();
  }
 }

//end screen
void endScreen(Player p){
  
  //wincounter to make sure the sound doesn't play 1000 times and sound like a dying duck
  wincounter ++;
  if(wincounter == 1){
    winTada.play();
  }
  
  //show who won
  String teamcolor = "";
  if(p.team == 0){
    teamcolor = "Red";
  }
  else{
    teamcolor = "Green";
  }
  fill(#000000,90);
  rect(0,0,w,h);
  fill(p.c);
  String winMessage = teamcolor + " wins! :D";
  text(winMessage, 275,120,250,75);
  
  //play again button to reset game
  Button PlayAgain = new Button(400,200,200,50,#FFC862,"Play Again");
  PlayAgain.display();
  if(PlayAgain.Clicked){
    gameOver = false;
    setup();
  }
  
  //button to go back to main menu
  Button BackMainMenu = new Button(400, 325, 250, 50, p.c, "Back to Menu");
  BackMainMenu.display();
  if(BackMainMenu.Clicked){
    mainMenu = true;
    howToPage = false;
    setup();
  }
}

//methods for checking which key is pressed
/*------------------------------------------------------------*/
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
