class Blocks{ // TGM basic ars
  public Blocks(){
    this.c = #000000;
    this.now = 0;
  }
  public color c(){
    return this.c;
  }
  public void drawUsingBlocks(int blockSize){
    pushMatrix();
    translateToCoordinate();
    for(int i = 0; i < currentPoints.length; i++){
      stroke(25, 25, 25);
      fill(this.c);
      rect((currentPoints[i].x + offset.x) * blockSize, -(currentPoints[i].y + offset.y) * blockSize, blockSize, blockSize);
    }
    popMatrix();
  }
  public void drawNextBlocks(int posX, int posY, int blockSize){
    pushMatrix();
    translate(posX, posY);
    for(int i = 0; i < currentPoints.length; i++){
      stroke(25, 25, 25);
      fill(this.c);
      rect(currentPoints[i].x * blockSize, -currentPoints[i].y * blockSize, blockSize, blockSize);
    }
    popMatrix();
  }
  public void rotate(boolean clockwise){ // UP
    tetris.validRotationComfortableVersion(currentPoints, offset, clockwise);
  }
  public void previousRotate(){
    for(int i = 0; i < currentPoints.length; i++){
      currentPoints[i].rotate(HALF_PI);
    }
    if(!tetris.validMove()){
      for(int i = 0; i < currentPoints.length; i++){
        currentPoints[i].rotate(-HALF_PI);
      }
    }
  }
  public void left(){ // LEFT
    offset.x--;
    if(!tetris.validMove()){
      println("invalid left");
      offset.x++;
    }
  }
  public void right(){ // RIGHT
    offset.x++;
    if(!tetris.validMove()){
      println("invalid right");
      offset.x--;
    }
  }
  public void accalerate(){ // DOWN, blocks move to filled
    this.down();
  }
  public void down(){
    if(tetris.isLanded()){
      return;
    }
    offset.y--;
  }
  public PVector points(int i){
    return new PVector(this.currentPoints[i].x + this.offset.x, this.currentPoints[i].y + this.offset.y);
  }
  public void nextState(){
    this.now = (this.now + 1) % this.state.length;
    this.currentPoints = this.state[this.now];
  }
  public void previousState(){
    this.now = (this.now - 1 + this.state.length) % this.state.length;
    this.currentPoints = this.state[this.now];
  }
  public void setPoints(PVector[] memory){
    for(int i = 0; i < this.currentPoints.length; i++){
      this.currentPoints[i].set(memory[i].x, memory[i].y);
    }
  }
  protected void getPoints(){
    this.now = floor(random(0, this.state.length));
    this.currentPoints = this.state[this.now];
    this.offset = new PVector(wellWidth / 2, 20);
  }
  
  protected int now;
  protected PVector state[][];
  protected PVector currentPoints[]; // Point at left top
  protected PVector offset; // coordinate
  protected color c;
};

class I extends Blocks{
  public I(){
    this.c = #61F7C6;
    this.state = new PVector[][]{
      {new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0), new PVector(2, 0)},
      {new PVector(1, 1), new PVector(1, 0), new PVector(1, -1), new PVector(1, -2)}
    };
    //this.currentPoints = new PVector[]{new PVector(-2, 0), new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0)};
    this.getPoints();
  }
};

class J extends Blocks{
  public J(){
    this.c = #4486D3;
    this.state = new PVector[][]{
      {new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0), new PVector(1, -1)},
      {new PVector(0, 1), new PVector(0, 0), new PVector(0, -1), new PVector(-1, -1)},
      {new PVector(1, -1), new PVector(0, -1), new PVector(-1, -1), new PVector(-1, 0)},
      {new PVector(0, -1), new PVector(0, 0), new PVector(0, 1), new PVector(1, 1)}
    };
    //this.currentPoints = new PVector[]{new PVector(-1, 1), new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0)};
    this.getPoints();
  }
};

class L extends Blocks{
  public L(){
    this.c = #E5CE5A;
    this.state = new PVector[][]{
      {new PVector(-1, -1), new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0)},
      {new PVector(-1, 1), new PVector(0, 1), new PVector(0, 0), new PVector(0, -1)},
      {new PVector(1, 0), new PVector(1, -1), new PVector(0, -1), new PVector(-1, -1)},
      {new PVector(1, -1), new PVector(0, -1), new PVector(0, 0), new PVector(0, 1)}
    };
    //this.currentPoints = new PVector[]{new PVector(1, 1), new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0)};
    this.getPoints();
  }
};

class O extends Blocks{
  public O(){
    this.c = #F0FA83;
    this.state = new PVector[][]{
      {new PVector(-1, 1), new PVector(-1, 0), new PVector(0, 0), new PVector(0, 1)}
    };
    //this.currentPoints = new PVector[]{new PVector(-1, 1), new PVector(-1, 0), new PVector(0, 0), new PVector(0, 1)};
    this.getPoints();
  }
  /*public void rotate(){
  }*/
};

class S extends Blocks{
  public S(){
    this.c = #B2EA85;
    this.state = new PVector[][]{
      {new PVector(-1, -1), new PVector(0, -1), new PVector(0, 0), new PVector(1, 0)},
      {new PVector(-1, 1), new PVector(-1, 0), new PVector(0, 0), new PVector(0, -1)}
    };
    //this.currentPoints = new PVector[]{new PVector(-1, 0), new PVector(0, 0), new PVector(0, 1), new PVector(1, 1)};
    this.getPoints();
  }
};

class T extends Blocks{
  public T(){
    this.c = #B049D6;
    this.state = new PVector[][]{
      {new PVector(-1, 0), new PVector(0, 0), new PVector(0, -1), new PVector(1, 0)},
      {new PVector(0, 1), new PVector(0, 0), new PVector(-1, 0), new PVector(0, -1)},
      {new PVector(1, -1), new PVector(0, -1), new PVector(0, 0), new PVector(-1, -1)},
      {new PVector(0, -1), new PVector(0, 0), new PVector(1, 0), new PVector(0, 1)}
    };
    //this.currentPoints = new PVector[]{new PVector(-1, 0), new PVector(0, 0), new PVector(1, 0), new PVector(0, 1)};
    this.getPoints();
  }
};

class Z extends Blocks{
  public Z(){
    this.c = #F01D1D;
    this.state = new PVector[][]{
      {new PVector(-1, 0), new PVector(0, 0), new PVector(0, -1), new PVector(1, -1)},
      {new PVector(1, 1), new PVector(1, 0), new PVector(0, 0), new PVector(0, -1)}
    };
    //this.currentPoints = new PVector[]{new PVector(-1, 1), new PVector(0, 1), new PVector(0, 0), new PVector(1, 0)};
    this.getPoints();
  }
};