//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

  //Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x; 
  int y;
  // Add a constructor with parameters to initialize each variable.
  Segment(int x1, int y1) {

    this.x = x1;
    this.y = y1;
  }
}
int v =1;
int a =2;


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here


ArrayList<Segment> tail = new ArrayList<Segment>();


Segment head;

int foodX;
int foodY;
           
int direction = UP;
int food = 0;
//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//

void setup() {
  size(500, 500);
  dropFood();
  frameRate(20);
  head = new Segment(250, 250);
}

void dropFood() {
  //Set the food in a new random location

  foodX = ((int)random(50)*10);
  foodY = ((int)random(50)*10);
  

}

//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(#74EA0E);
  drawFood();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#FF0000);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#0038FC);
  rect(head.x, head.y, 10, 10);
  manageTail();
}

//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail
  for(int i = 0; i< tail.size(); i++){
   rect(tail.get(i).x +10,tail.get(i).y ,10,10); 
  }
  print (tail.size());
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  tail.add(new Segment(head.x + 10,head.y ));
  tail.remove(0);
 
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for(int i = 0; i< tail.size(); i++){
    
  
if(head.x == tail.get(i).x && head.y == tail.get(i).y){
  
  food =1;
 tail = new ArrayList<Segment>();
    tail.add(new Segment(head.x,head.y));
}
  }
}

  //*
  // ***** CONTROL METHODS *****
  //These methods are used to change what is happening to the snake
  //*

  void keyPressed() {
    //Set the direction of the snake according to the arrow keys pressed
    if (key == CODED) {

      if (keyCode == RIGHT && direction != LEFT) {
        direction = RIGHT;
        move();
      }

      if (keyCode == LEFT && direction != RIGHT) {
        direction = LEFT;
        move();
      } 


      if (keyCode == UP && direction != DOWN) {
        direction = UP;
        move();
      }

      if (keyCode == DOWN && direction != UP) {
        direction = DOWN;
        move();
      }
    }
  }


  void move() {
    //Change the location of the Snake head based on the direction it is moving.


    switch(direction) {
    case UP:
      head.y -=1;
      println("This is head.y " + head.y);
      break;
    case DOWN:
      head.y +=1;
      break;
    case LEFT:
      head.x -=1;
      break;
    case RIGHT:
      head.x +=1;
      break;
    }
    checkBoundaries();
  }
  void checkBoundaries() {
    //If the snake leaves the frame, make it reappear on the other side
    if (head.x < 0) {
      head.x = 500;
    }

    if (head.x > 500) {
      head.x = 0;
    }


    if (head.y < 0) {
      head.y = 500;
    }


    if (head.x > 500) {
      head.x = 0;
    }
  }


  void eat() {
    //When the snake eats the food, its tail should grow and more food appear
    if (head.x == foodX && head.y == foodY){
        food +=1;
        dropFood();
   tail.add(new Segment(head.x + 10,head.y));
    }
    
    
 
    
  }
