int PARTICLE_FIXED = (1 << 0);
int PARTICLE_COLORMIXING = (1 << 1);
int PARTICLE_ZOMBIE = (1 << 2);

class ParticleGroup
{
  int Flag = 0;
  float repulsive = 0.16f;
  float pressure = 0.75f;
  float viscous = 0.2f;
  ParticleGroup(){}
  ParticleGroup(int f){
    Flag = f;
  }
  final boolean hasFlag(int f){
    return (Flag & f) != 0;
  }
  final boolean hasAnyFlags(int[] f){
    for(int i=0;i<f.length;i++){
      if(hasFlag(f[i])){
        return true;
      }
    }
    return false;
  }
  final boolean hasAllFlags(int[] f){
    for(int i=0;i<f.length;i++){
      if(!hasFlag(f[i])){
        return false;
      }
    }
    return true;
  }
};

ParticleGroup PARTICLEGROUP_NORMAL = new ParticleGroup();
