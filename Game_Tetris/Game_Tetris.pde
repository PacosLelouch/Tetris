int blockSize;
int wellWidth = 10;
float deviation = 0.001;
Tetris tetris;
void settings(){
  size(1200, 800, P2D);
  PJOGL.setIcon("ICON/icon.png");
}

void setup(){
  //surface.setIcon(loadImage("ICON/icon.png"));
  background(0, 0, 0);
  frameRate(30);
  blockSize = floor(height * 0.05);
  tetris = new Tetris(blockSize);
}

void draw(){
  tetris.drawBackground();
  tetris.drawBlocks();
  //drawGrid();
}

void drawGrid(){
  stroke(150, 150, 150, 100);
  for(int i = 0; i <= height / blockSize; i++){
    line(0, i * blockSize, width, i * blockSize);
  }
  for(int i = 0; i <= width / blockSize; i++){
    line(i * blockSize, 0, i * blockSize, height);
  }
}

void keyPressed(){
  switch(key){
    case 'P':
    case 'p':
      tetris.pauseOrResume();
      break;
    case ENTER:
      if(tetris.isOver()){
        tetris.restart(blockSize);
      }
      break;
    case ' ':
      if(!tetris.isPaused() && !tetris.isOver()){
        tetris.move(key);
      }
      break;
    default:
      break;
  }
  if(!tetris.isPaused() && !tetris.isOver()){
    switch(keyCode){
      case UP:
      case DOWN:
      case LEFT:
      case RIGHT:
        tetris.move(keyCode);
        break;
      default:
        break;
    }
  }
}

void translateToCoordinate(){
  translate(width * 0.5 - blockSize * (wellWidth / 2), height - blockSize * 2);
}