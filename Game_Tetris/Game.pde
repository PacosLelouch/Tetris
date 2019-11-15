class Game{
  public Game(){
    this.init(0);
  }
  public Game(int score){
    this.init(score);
  }
  public void pauseOrResume(){
    this.paused = !this.paused;
  }
  public void gameOver(){
    this.over = true;
  }
  public void restart(){
    this.init(0);
  }
  public void restart(int score){
    this.init(score);
  }
  public boolean isOver(){
    return this.over;
  }
  public boolean isPaused(){
    return this.paused;
  }
  public void getScore(int score){
    this.score += score;
  }
  public void loseScore(int score){
    this.score -= score;
  }
  public void drawBackground(){
    this.showScore();
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
  }
  protected void showScore(){
    pushMatrix();
    textAlign(RIGHT, TOP);
    fill(255, 255, 255);
    textSize(width * 0.04);
    text("Score: " + this.score, width * 0.99, height * 0.01);
    popMatrix();
  }
  protected void init(int score){
    this.score = score;
    this.over = false;
    this.paused = false;
  }
  protected int score;
  protected boolean over;
  protected boolean paused;
};