class Particle
{
  PVector p = new PVector();
  PVector v = new PVector();
  color c = color(255);
  ParticleGroup group;
  Particle(){}
  final void Step(float dt){
    p.x += v.x * dt;
    p.y += v.y * dt;
  }
};
