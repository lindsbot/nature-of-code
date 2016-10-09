// Example 1.10: Accelerating towards the mouse

// Declare Mover object.
Mover mover;

Mover[] objects = new Mover[100];
void setup() {
  size(640,360);
  // Create Mover objects.
  for (int i = 0; i < 100; i++) {
    float x;
    float y;
    PVector location;
    x = random(0, width);
    y = random(0, height);
    location = new PVector(x,y);
    objects[i] = new Mover(location);
  }
}

void draw() {
  background(255);

  // Call functions on Mover object.
  for (int i = 0; i < objects.length; i++) {

    Mover mover = objects[i];

    mover.update();
    mover.checkEdges();
    mover.display();
  }
}

class Mover {

  PVector location;
  PVector velocity;
  // Acceleration is the key!
  PVector acceleration;
  // The variable topspeed will limit the magnitude of velocity.
  float topspeed;

  Mover(PVector loc) {
    location = loc;
    velocity = new PVector(0,0);
    acceleration = new PVector(-0.001,0.01);
    topspeed = 2.6;
  }

 void update() {

    PVector mouse = new PVector(mouseX,mouseY);

    // Step 1: Compute direction
    PVector dir = PVector.sub(mouse,location);

    // Step 2: Normalize
    dir.normalize();

    // Step 3: Scale
    dir.mult(0.5);

    // Step 4: Accelerate
    acceleration = dir;

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);

  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }

  void checkEdges() {
    if (location.x > width) {
      velocity.x = velocity.x * -1;
    } else if (location.x < 0) {
      velocity.x = velocity.x * -1;
    }

    if (location.y > height) {
      velocity.y = velocity.y * -1;
    } else if (location.y < 0) {
      velocity.y = velocity.y * -1;
    }
  }
}
