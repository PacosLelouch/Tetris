class Tetris extends Game{
  public Tetris(){
    this.init(0, 0);
  }
  public Tetris(int blockSize){
    this.init(0, blockSize);
  }
  public Tetris(int blockSize, int score){
    this.init(score, blockSize);
  }
  
  public void restart(){
    this.init(0, 0);
  }
  public void restart(int blockSize){
    this.init(0, blockSize);
  }
  public void restart(int blockSize, int score){
    this.init(score, blockSize);
  }
  
  public void move(int direction){ // and space
    switch(direction){
      case LEFT:
        this.thisBlocks.left();
        break;
      case RIGHT:
        this.thisBlocks.right();
        break;
      case UP:
        this.thisBlocks.rotate(true);
        break;
      case DOWN:
        this.thisBlocks.rotate(false);
        break;
      case ' ':
        this.thisBlocks.accalerate();
        break;
      default:
        break;
    }
  }
  
  public void drawBackground(){
    pushMatrix();
    background(0, 0, 0);
    translate(width * 0.5, height);
    rotate(PI);
    stroke(25, 25, 25);
    fill(200, 200, 200);
    for(int i = 0; i <= wellWidth / 2; i++){
      rect(i * blockSize, 0, blockSize, blockSize);
      rect(-i * blockSize, 0, -blockSize, blockSize);
    }
    for(int i = 0; i < height / blockSize; i++){
      rect((wellWidth / 2) * blockSize, (i + 1) * blockSize, blockSize, blockSize);
      rect(-(wellWidth / 2) * blockSize, (i + 1) * blockSize, -blockSize, blockSize);
    }
    popMatrix();
    this.showScore();
    this.showNext();
    this.showInstructions();
  }
  
  public void drawBlocks(){
    for(int i = 0; i < wellWidth; i++){
      for(int j = 0; j < height/blockSize - 1; j++){
        this.drawABlock(i, j, filled[i][j]);
      }
    }
    this.thisBlocks.drawUsingBlocks(blockSize);
    if(this.over){
      textAlign(CENTER, CENTER);
      textSize(blockSize);
      fill(255, 255, 255);
      text("GAME OVER", width * 0.5, height * 0.5);
    }
    else if(this.paused){
      textAlign(CENTER, CENTER);
      textSize(blockSize);
      fill(255, 255, 255);
      text("PAUSE", width * 0.5, height * 0.5);
    }
    else if(frameCount%10 == 0){
      this.thisBlocks.down();
    }
  }
  
  public void validRotationComfortableVersion(PVector[] points, PVector offset, boolean clockwise){ // improve experience
    PVector memory[] = {new PVector(points[0].x, points[0].y), new PVector(points[1].x, points[1].y), new PVector(points[2].x, points[2].y), new PVector(points[3].x, points[3].y)};
    PVector offsetMemory = new PVector(offset.x, offset.y);
    println("rotation 2.0ver");
    //this.myPreviousRotation(points);
    if(clockwise)this.thisBlocks.nextState();
    else this.thisBlocks.previousState();
    for(int c = 0; c < 2; c++)for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation);
      if(x < 0){
        offset.x++;
        break;
        //this.thisBlocks.right();
      }
    }
    for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      if(x <= wellWidth - 1 && y >= 0 && this.filled[x][y] != 0){
        offset.x++;
        break;
        //this.thisBlocks.right();
      }
    }
    for(int c = 0; c < 2; c++)for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation);
      if(x > wellWidth - 1){
        offset.x--;
        break;
        //this.thisBlocks.left();
      }
    }
    for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      if(y >= 0 && this.filled[x][y] != 0){
        offset.x--;
        break;
        //this.thisBlocks.left();
      }
    }
    for(int i = 0; i < 4; i++){
      int y = floor(this.thisBlocks.points(i).y + deviation);
      if(y < 0){
        offset.y++;
        break;
      }
    }
    for(int c = 0; c < 2; c++)for(int i = 0; i < 4; i++){
      int count = 2;
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      if(x < 0 || x > wellWidth - 1 || y < 0 || filled[x][y] != 0){
        while(count-- > 0){
          int ok = 0;
          this.thisBlocks.right();
          for(int j = 0; j < 4; j++){
            int x1 = floor(this.thisBlocks.points(i).x + deviation), y1 = floor(this.thisBlocks.points(i).y + deviation);
            if(x1 > 0 && x1 < wellWidth - 1 && y1 > 0 & filled[x1][y1] == 0){
              ok++;
            }
            else break;
          }
          if(ok >= 4){
            break;
          }
        }
      }
    }
    for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      if(x < 0 || x > wellWidth - 1 || y < 0 || filled[x][y] != 0){
        this.thisBlocks.setPoints(memory);
        offset.set(offsetMemory);
        println("invalid rotation");
        break;
      }
    }
  }
  
  public boolean validMove(){
    boolean valid = true;
    for(int i = 0; i < 4; i++){
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      if(x < 0 || x > wellWidth - 1 || y < 0 || filled[x][y] != 0){
          valid = false;
      }
    }
    return valid;
  }
  
  public boolean isLanded(){
    for(int i = 0; i < 4; i++){
      //println("x = " + this.thisBlocks.points(i).x);
      //println("y = " + this.thisBlocks.points(i).y);
      //if(floor(this.thisBlocks.points(i).y + deviation) - 1 > 0)println("below = " + this.filled[floor(this.thisBlocks.points(i).x + deviation)][floor(this.thisBlocks.points(i).y + deviation) - 1]);
      if(floor(this.thisBlocks.points(i).y + deviation) == 0 || this.filled[floor(this.thisBlocks.points(i).x + deviation)][floor(this.thisBlocks.points(i).y + deviation) - 1] != 0){
        //println("");
        for(int j = 0; j < 4; j++){
          //println("x" + j + " = " + this.thisBlocks.points(j).x + deviation);
          //println("y" + j + " = " + this.thisBlocks.points(j).y + deviation);
        }
        this.blockLanded();
        return true;
      }
    }
    //println("");
    return false;
  }
  
  protected void blockLanded(){
    ArrayList<Integer> contain = new ArrayList<Integer>();
    ArrayList<Integer> clear = new ArrayList<Integer>();
    for(int i = 0; i < 4; i++){
      if(floor(this.thisBlocks.points(i).y + deviation) >= height/blockSize - 1){
        this.gameOver();
      }
      int x = floor(this.thisBlocks.points(i).x + deviation), y = floor(this.thisBlocks.points(i).y + deviation);
      //println("landed x" + i + " = " + x);
      //println("landed y" + i + " = " + x);
      if(!contain.contains(y))contain.add(y);
      this.filled[x][y] = this.thisBlocks.c();
    }
    for(int i = 0; i < contain.size(); i++){
      int count = 0, y = contain.get(i);
      for(int x = 0; x < wellWidth; x++){
        if(filled[x][y] != 0){
          count++;
        }
      }
      if(count == wellWidth && !clear.contains(y)){
        clear.add(y);
      }
    }
    this.getScoreByClear(clear.size());
    this.clearBlocks(clear);
    //println("");
    this.thisBlocks = this.nextBlocks;
    this.nextBlocks = this.nextBlocks2;
    this.nextBlocks2 = this.getRandomBlocks();
  }
  
  protected void init(int score, int blockSize){
    surface.setTitle("Tetris");
    this.blockSize = blockSize;
    super.init(score);
    filled = new int[wellWidth][height/blockSize + 3];
    this.thisBlocks = this.getRandomBlocks();
    this.nextBlocks = this.getRandomBlocks();
    this.nextBlocks2 = this.getRandomBlocks();
    //println("bound = " + int(height/blockSize + 3));
  }
  
  protected void getScoreByClear(int size){
    super.getScore(size * (size + 1) / 2);
  }
  
  protected void clearBlocks(ArrayList<Integer> clear){
    java.util.Collections.sort(clear);
    for(int i = 0; i < clear.size(); i++){
      for(int y = clear.get(i) - i; y < filled[0].length - 1; y++){
        for(int x = 0; x < wellWidth; x++){
          filled[x][y] = filled[x][y + 1];
        }
      }
      for(int x = 0; x < wellWidth; x++){
        filled[x][filled[0].length - 1] = 0;
      }
    }
  }
  
  protected void showScore(){
    pushMatrix();
    textAlign(LEFT, TOP);
    fill(255, 255, 255);
    textSize(this.blockSize * 0.6);
    text("Score: " + this.score, width * 0.99 - blockSize * 5, height * 0.01);
    popMatrix();
  }
  
  protected void showNext(){
    textAlign(LEFT, TOP);
    fill(255, 255, 255);
    textSize(this.blockSize * 0.6);
    text("Next: ", width * 0.99 - blockSize * 5, height * 0.01 + blockSize * 2);
    text("After Next: ", width * 0.99 - blockSize * 5, height * 0.01 + blockSize * 8);
    this.nextBlocks.drawNextBlocks(width - blockSize * 4, blockSize * 5, blockSize);
    this.nextBlocks2.drawNextBlocks(width - blockSize * 4, blockSize * 11, blockSize);
  }
  
  protected void showInstructions(){
    pushMatrix();
    textAlign(CENTER, TOP);
    fill(255, 255, 255);
    textSize(this.blockSize * 1.2);
    text("TETRIS", width * 0.5 - blockSize * (wellWidth + 0.5), height * 0.01);
    textAlign(LEFT, TOP);
    textSize(this.blockSize * 0.6);
    text("INSTRUCTIONS", width * 0.5 - blockSize * (wellWidth + 4), height * 0.11);
    text("↑: Clockwise Rotation", width * 0.5 - blockSize * (wellWidth + 4), height * 0.16);
    text("↓: Anticlockwise Rotation", width * 0.5 - blockSize * (wellWidth + 4), height * 0.21);
    text("←: Left Move", width * 0.5 - blockSize * (wellWidth + 4), height * 0.26);
    text("→: Right Move", width * 0.5 - blockSize * (wellWidth + 4), height * 0.31);
    text("Space: Accaleration", width * 0.5 - blockSize * (wellWidth + 4), height * 0.36);
    text("p: Pause or Resume", width * 0.5 - blockSize * (wellWidth + 4), height * 0.41);
    text("Enter: Restart When Over", width * 0.5 - blockSize * (wellWidth + 4), height * 0.46);
    
    text("BLOCK CLEAR BONUS", width * 0.5 - blockSize * (wellWidth + 4), height * 0.56);
    text("1:1  2:3  3:6  4:10", width * 0.5 - blockSize * (wellWidth + 4), height * 0.61);
    popMatrix();
  }
  
  protected Blocks getRandomBlocks(){
    switch(floor(random(0, 7))){
      case 0:
        return new I();
      case 1:
        return new J();
      case 2:
        return new L();
      case 3:
        return new O();
      case 4:
        return new S();
      case 5:
        return new T();
      case 6:
        return new Z();
      default:
        return new Blocks();
    }
  }
  
  protected void myPreviousRotation(PVector[] points){
    for(int i = 0; i < 4; i++){
      points[i].rotate(HALF_PI);
    }
  }
  
  protected void drawABlock(int x, int y, int c){
    pushMatrix();
    translateToCoordinate();
    stroke(0, 0, 0);
    //stroke(25, 25, 25);
    fill(color(c));
    rect(x * blockSize, -y * blockSize, blockSize, blockSize);
    popMatrix();
  }
  
  int filled[][]; // color, 0 means no block
  
  protected int blockSize;
  protected Blocks thisBlocks;
  protected Blocks nextBlocks;
  protected Blocks nextBlocks2;
};