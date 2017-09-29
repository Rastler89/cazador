//Vars
float[] food = new float[2];
float[] player={200,200};
float[] e1={95,95};
float[] e2={95,295};
float[] e3={295,95};
float[] e4={295,295};
float[] e5={105,95,0};
float[] e6={285,295,0};
float[] e7={295,105,0};
float[] e8={95,285,0};
float[] e9={195,195,1};
float[] e10={195,195,-1};
float[] e11={195,195,-1};
float[] e12={195,195,1};
float[][] enemy = {e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12 };
int energy=200;
int count=0;
int move=3;
int score=0;
int maxScore=0;
float vel=1;
int level=1;
boolean pause=true;
boolean gameover=true;
boolean gameoverSound=true;
//Constants
final float[][] enemyConstant = enemy;
//Core
void setup() {
  background(0);
  size(550,400);
  food = RandomFood();
}
void draw() {
  background(0);
  fill(255,0,0);
  rect(food[0],food[1],10,10);
  fill(0,255,0);
  rect(player[0],player[1],10,10);
  fill(255);
  rect(400,-1,10,401);
  LevelUp();
  text("Level: "+level,420,20);
  text("Score: "+score,420,40);
  text("Energia: ",420,80);
  fill(255,255,0);
  rect(420,90,energy/2,10);
  fill(153,153,153);
  drawEnemys(4);
  startGame();
}

// Functions
float[] RandomFood() {
  float[] food = new float[2];
  food[0]=random(0,400)-1;
  food[1]=random(0,400)-1;
  return food;
}
void drawEnemys(int loop) {
  for(int i=0; i<loop; i++){
    rect(enemy[i][0],enemy[i][1],10,10);
  }
}
void startGame() {
  if(!pause) {
    movements();
  } else {
    if(gameover) {
      if(gameoverSound) {
        gameoverSound=!gameoverSound;
      }
      text(" G A M E     O V E R ",150,200);
    } else {
      text("PAUSA",180,200);
    }
  }
  process();
}
void process() {
  
  if(feed()){
    score=score+1;
    food=RandomFood();
    if(score%10==0 && score!=0) {
      vel=vel+0.25;
      level=level+1;
    }
    while(fooder(e1)||fooder(e2)||fooder(e3)||fooder(e4)) {
      food=RandomFood();
    }
  }
  collisioner(4);
}
boolean feed() {
  if(player[0]+8 < food[0]) {
    return false;
  }
  if (player[1]+8 < food[1]) {
    return false;
  }
  if (player[0]>food[0]+8) {
    return false;
  }
  if (player[1]>food[1]+8) {
    return false;
  }
  return true;
}
void movements() {
  accel();
  if (move==1) {
    player[0]=player[0]+vel;
  } else if (move==2) {
    player[0]=player[0]-vel;
  } else if (move==3) {
    player[1]=player[1]-vel;
  } else if (move==4) {
    player[1]=player[1]+vel;
  }
  direction();
  limits();
}
void accel() {
  if(keyCode==18 && keyPressed) {
    if(energy>5) {
      vel=4;
      energy=energy-5;
    } else {
      vel=1+(level-1)*0.25;
    }
  } else {
    vel=1+(level-1)*0.25;
    if(energy<200) {
     energy=energy+1;
    }
  }
}
void direction() {
  if(keyPressed) {
    if(keyCode==40 || key=='s') {
      move=4;
    } else if(keyCode==38 || key=='w') {
      move=3;
    } else if(keyCode==39 || key=='d') {
      move=1;
    } else if(keyCode==37 || key=='a') {
      move=2;
    }
  }
}
void limits() {
  if (player[0]>400) {
    player[0]=1;
  }else if (player[0]<0) {
    player[0]=399;
  } else if (player[1]>400) {
    player[1]=1;
  } else if (player[1]<0) {
    player[1]=399;
  }
}
void keyPressed() {
  if(keyCode==10 || keyCode==32) {
      pause = !pause;
      if (gameover) {
        gameover=!gameover;
        gameoverSound=!gameoverSound;
      }
   }
}
void collisioner(int loop) {
  for(int i=0; i<loop; i++){
    collision(enemy[i]);
  }
}
boolean fooder(float[] e) {
  if (food[0]+9 < e[0]) {
    return false;
  }
  if (food[1]+9 < e[1]) {
    return false;
  }
  if (food[0]>e[0]+9) {
    return false;
  }
  if (food[1]>e[1]+9) {
    return false;
  }
  return true;
}
void collision(float[] e) {
  if(coll(e)) {
    reset();
  }
}
boolean coll(float[] e) {
  if (player[0]+8 < e[0]) {
    return false;
  }
  if (player[1]+8 < e[1]) {
    return false;
  }
  if (player[0]>e[0]+8) {
    return false;
  }
  if (player[1]>e[1]+8) {
    return false;
  }
  return true;
}
void reset() {
  score=0;
  player[0]=200;
  player[1]=200;
  gameover=true;
  pause=true;
  level=1;
  enemy=enemyConstant;
  vel=1;
  energy=200;
}
void LevelUp() {
  if(level>1) {
    invoke(enemy[4]);
    if(level>2) {
      invoke(enemy[5]);
      if(level>3) {
        invoke(enemy[6]);
        if(level>4) {
          invoke(enemy[7]);
          if(level>5 && !pause) {
            moveEnemyX(enemy[4]);
            moveEnemyX(enemy[5]);
            moveEnemyY(enemy[6]);
            moveEnemyY(enemy[7]);
            if(level>6) {
              invoke(enemy[8]);
              invoke(enemy[9]);
              invoke(enemy[10]);
              invoke(enemy[11]);
              if(level>7 && !pause) {
                moveEnemyY(enemy[8]);
                moveEnemyY(enemy[9]);
                moveEnemyX(enemy[10]);
                moveEnemyX(enemy[11]);
                if(level>8) {
                  fill(153,153,153);
                  float[] central = {190,190,20,20};
                  rect(central[0], central[1], central[2], central[3]);
                  foodEnemy(central);
                  DeadZone(185,205);
                }
              }
            }
          }
        }
      }
    }
    routeEnemy1(enemy[4]); routeEnemy1(enemy[5]); routeEnemy1(enemy[6]); routeEnemy1(enemy[7]);
    routeEnemy2(enemy[8]); routeEnemy2(enemy[9]); routeEnemy2(enemy[10]); routeEnemy2(enemy[11]);
  }
}
void routeEnemy1(float[] e) {
  if (e[0]==285||e[1]==285) {
    e[2]=-1;
  }
  if (e[0]==105||e[1]==105) {
    e[2]=1;
  }
}
void routeEnemy2(float[] e) {
   if (e[0]>390 || e[1]>390) {
     e[2]=-1;
   }
   if (e[0]<1 || e[1]<1) {
     e[2]=1;
   }
}
void invoke(float[] e) {
  drawEnemy(e);
  collision(e);
  foodEnemy(e);
}
void drawEnemy(float[] e) {
  rect(e[0],e[1],10,10);
}
void moveEnemyX(float[] e) {
 e[0]=e[0]+e[2]; 
}
void moveEnemyY(float[] e) {
  e[1]=e[1]+e[2];
}
void foodEnemy(float[] e) {
  if(fooder(e)) {
    food=RandomFood();
  }
}
void DeadZone(int min, int max) {
  if ((player[0]>min-10&&player[0]<max) && (player[1]>min-10&&player[1]<max)) {
    if (score>maxScore) {
      maxScore=score;
    }
      reset();
  }
}