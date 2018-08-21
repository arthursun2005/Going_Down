class Particle
{
  PVector p = new PVector();
  PVector v = new PVector();
  PVector f = new PVector();
  color c = color(255);
  float pressure;
  ParticleGroup group;
  Particle(){}
  final void Step(float dt){
    v.add(f);
    p.x += v.x * dt;
    p.y += v.y * dt;
  }
};
