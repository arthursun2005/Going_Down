int PARTICLE_FIXED = 1;
int PARTICLE_COLORMIXING = 2;
int PARTICLE_ZOMBIE = 3;

class ParticleGroup
{
  int Flag = 0;
  float repulsive = 16f;
  float pressure = 0.75f;
  float viscous = 0.2f;
  ParticleGroup(){}
  ParticleGroup(int f){
    Flag = f;
  }
};

ParticleGroup PARTICLEGROUP_NORMAL = new ParticleGroup();
