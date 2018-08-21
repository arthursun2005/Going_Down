import java.util.*;
class ParticleSystem
{
  final float R;
  final float D;
  ArrayList<Particle> ps = new ArrayList<Particle>();
  HashMap<String, ArrayList<Particle>> Map = new HashMap<String, ArrayList<Particle>>();
  HashSet<String> sMap = new HashSet<String>();
  ParticleSystem(float a){
    R = a;
    D = 2f * R;
  }
  final void Step(float dt){
    sMap.clear();
  }
};
