World world;

void setup(){
  fullScreen(JAVA2D);
  smooth();
  world = new World(6f);
}

void draw(){
  background(0);
  world.Update(16);
  world.display();
  if(mousePressed){
    world.ps.ps.add(new Particle(mouseX, mouseY));
  }
}
