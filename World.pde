class World
{
  PVector gravity = new PVector();
  long lastStep = millis();
  int leftOvers = 0;
  ParticleSystem ps;
  World(float r){
    ps = new ParticleSystem(r);
  }
  final void Update(int deltaTime){
    long now = millis();
    int elapsed = int(now-lastStep) + leftOvers;
    int its = floor(elapsed/deltaTime);
    for(int n=0;n<its;n++){
      Step(deltaTime);
    }
    leftOvers = elapsed - its*deltaTime;
    lastStep = now;
  }
  final void Step(float dt){
    ps.Step(dt);
  }
  final void display(){
    ps.display();
  }
};
