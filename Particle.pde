class Particle
{
  PVector p = new PVector();
  PVector v = new PVector();
  PVector f = new PVector();
  color c = color(255);
  float pressure;
  ParticleGroup group = PARTICLEGROUP_NORMAL;
  Particle(){}
  Particle(float x, float y){
    p.set(x,y);
  }
};
