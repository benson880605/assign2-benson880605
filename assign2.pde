// Variable

PImage bg , cabbage , life  ;
PImage restartNormal , restartHovered , soil , soldier , startHovered , startNormal , title , gameOver ;
PImage groundHog , groundHogLeft , groundHogRight , groundHogDown ;

final int  GAME_START=1 , GAME_RUN=2 , GAME_OVER = 3;
int gameState;

int lifeCount = 2;

int groundHogX , groundHogY ;
int groundHogR , groundHogB ;
int groundHogSpeed = 5;

int soldierX = -80;
int soldierY = 160+80*floor(random(4));
int soldierSpeed = 5;
int soldierR , soldierB; //Right and Buttom

int cabbageX = 80*floor(random(8));
int cabbageY = 160+80*floor(random(4));
int cabbageR , cabbageB; //Right and Buttom

int buttonX = 248;
int buttonY = 360;
int buttonW = 144;
int buttonH = 60;

boolean down = false;
boolean left = false;
boolean right = false;
boolean idle = false;


void setup() {
  
	size(640, 480 );

  bg = loadImage("img/bg.jpg");
  gameOver = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  groundHog = loadImage("img/groundhogIdle.png");
  groundHogLeft = loadImage("img/groundhogLeft.png");
  groundHogRight = loadImage("img/groundhogRight.png");
  groundHogDown = loadImage("img/groundhogDown.png");

  gameState = GAME_START;
  
  groundHogX = width/2;
  groundHogY = 80;
  
  idle = true;
  
}

void draw() {
  
  switch(gameState){
    
// GameStart
    
    case GAME_START:
    image(title,0,0);
    image(startNormal,buttonX,buttonY);
    if(mouseX >= 248 && mouseX <= 248+buttonW && mouseY >= 360 && mouseY <= 360+buttonH){
      image(startHovered,buttonX,buttonY);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }
    break;
    
// GameRun
    
    case GAME_RUN:
    
  // PutImage
  
    image(bg,0,0);
    if(lifeCount == 0){
      gameState = GAME_OVER;
    }
    if(lifeCount == 1){
      image(life,10,10);
    }
    if(lifeCount == 2){
      image(life,10,10);
      image(life,80,10);
    }
    if(lifeCount == 3){
      image(life,10,10);
      image(life,80,10);
      image(life,150,10);
      cabbageX = -160;
    }
    image(soil,0,160);
    noStroke();
    fill(124, 204, 25);
    rect(0,145,width,15);
    fill(255, 255, 0);
    ellipse(width-50,50,130,130);    
    fill(253, 184, 19);
    ellipse(width-50,50,120,120);
    image(cabbage,cabbageX,cabbageY);
    if(idle){
      image(groundHog,groundHogX,groundHogY);
    }
    
  // SoldierRun
    
    image(soldier,soldierX,soldierY);
    soldierX += soldierSpeed;
    if(soldierX >= 640){soldierX = -80;}
  
  // EatCabbage
  
    groundHogR = groundHogX + 80;
    groundHogB = groundHogY + 80;
    cabbageR = cabbageX + 80;
    cabbageB = cabbageY + 80;
    if( groundHogX < cabbageR && groundHogR > cabbageX && groundHogY < cabbageB && groundHogB > cabbageY){
      lifeCount += 1;
    }
    
  // HurtBySoldier
    
    soldierR = soldierX+80;
    soldierB = soldierY+80;
    if( groundHogX < soldierR && groundHogR > soldierX && groundHogY < soldierB && groundHogB > soldierY){
      groundHogX = width/2;
      groundHogY = 80;
      lifeCount -= 1;
    }
    
  // ControlGroundHog
    
    if(down){
      image(groundHogDown,groundHogX,groundHogY);
      idle = false;
      left = false;
      right = false;
      groundHogY += groundHogSpeed;
      if(groundHogY == 160||groundHogY == 240||groundHogY == 320||groundHogY == 400){
        down = false;
        idle = true;
      }
    }
    if(left){
      image(groundHogLeft,groundHogX,groundHogY);
      idle = false;
      right = false;
      down = false;
      groundHogX -= groundHogSpeed;
      if(groundHogX == 0||groundHogX == 80||groundHogX == 160||groundHogX == 240||groundHogX == 320||groundHogX == 400||groundHogX == 480||groundHogX == 560){
        left = false;
        idle = true;
      }
    }
    if(right){
      image(groundHogRight,groundHogX,groundHogY);
      idle = false;
      left = false;
      down = false;
      groundHogX += groundHogSpeed;
      if(groundHogX == 0||groundHogX == 80||groundHogX == 160||groundHogX == 240||groundHogX == 320||groundHogX == 400||groundHogX == 480||groundHogX == 560){
        right = false;
        idle = true;
      }
    }
    break;
    
// gameOver
    
    case GAME_OVER:
    image(gameOver , 0 , 0);
    image(restartNormal,buttonX,buttonY);
    if(mouseX >= 248 && mouseX <= 248+buttonW && mouseY >= 360 && mouseY <= 360+buttonH){
      image(restartHovered,buttonX,buttonY);
    
    // reset
    
      if(mousePressed){
        soldierX = -80;
        soldierY = 160+80*floor(random(4));
        groundHogX = width/2;
        groundHogY = 80;
        cabbageX = 80*floor(random(8));
        cabbageY = 160+80*floor(random(4));
        lifeCount = 2;
        left = false;
        right = false;
        down = false ;
        idle = true;
        gameState = GAME_RUN;
      }
    }
    break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch( keyCode ){
      
      case DOWN:
      down = true;
      if(left){down = false;}  // Prevent bug
      if(right){down = false;}  // Prevent bug
      if(groundHogY >= 400){down = false;}
      break;
      
      case LEFT:
      left = true;
      if(down){left = false;}  // Prevent bug
      if(right){left = false;}  // Prevent bug
      if(groundHogX <= 0){left = false;}  // Prevent bug
      break;
      
      case RIGHT:
      right = true;
      if(down){right = false;}  // Prevent bug
      if(left){right = false;}  // Prevent bug
      if(groundHogX >= 560){right = false;}
      break;
        
    }
  }
}
