import java.util.*;
class ParticleSystem
{
  final float R;
  float T = 2.5f;
  final float k_D;
  final float k_DSQ;
  final float k_HEAT;
  final float k_ALPHA;
  float D;
  int SubSteps = 4;
  color[][] Heatmap;
  ArrayList<Particle> ps = new ArrayList<Particle>();
  HashMap<String, ArrayList<Particle>> Map = new HashMap<String, ArrayList<Particle>>();
  HashSet<String> sMap = new HashSet<String>();
  HashSet<String> iMap = new HashSet<String>();
  ParticleSystem(float a){
    R = a;
    k_D = R * 2f;
    k_DSQ = k_D*k_D;
    Heatmap = new color[height][width];
    k_HEAT = 1f/(R * R);
    k_ALPHA = k_HEAT * 1.0005;
  }
  final void calHeatmap(){
    loadPixels();
    for(int px=0;px<width;px+=5){
      for(int py=0;py<height;py+=5){
        int hx = floor(px/k_D);
        int hy = floor(py/k_D);
        float d = 0f;
        color now = pixels[px+py*width];
        color m = now;
        for(int x=hx-1;x<=hx+1;x++){
          for(int y=hy-1;y<=hy+1;y++){
            String hash = x + "|" + y;
            if(sMap.contains(hash)){
              for(Particle j : Map.get(hash)){
                float dx = j.p.x - px;
                float dy = j.p.y - py;
                d += 1/(dx*dx + dy*dy);
                m = AddColor(m, j.c);
              }
            }
          }
        }
        if(d >= k_HEAT){
          if(d < k_HEAT + k_ALPHA) Heatmap[py][px] = lerpColor(m, now, map(d,k_HEAT,k_ALPHA,1f,0f));
          else Heatmap[py][px] = m;
        }
      }
    }
    updatePixels();
  }
  final int[] readHash(String hash){
    String[] sl = hash.split("|");
    return new int[]{
      int(sl[0]), int(sl[1])
    };
  }
  final void Step(float dt){
    D = T * R;
    for(String s : sMap){
      ArrayList<Particle> as = Map.get(s);
      as.clear();
    }
    sMap.clear();
    for(Particle p : ps){
      int hx = floor(p.p.x/D);
      int hy = floor(p.p.y/D);
      String hash = hx + "|" + hy;
      if(!iMap.contains(hash)){
        Map.put(hash, new ArrayList<Particle>());
      }
      ArrayList<Particle> as = Map.get(hash);
      as.add(p);
      sMap.add(hash);
      iMap.add(hash);
    }
    for(int n=0;n<SubSteps;n++){
      for(Particle p : ps){
        int hx = floor(p.p.x/D);
        int hy = floor(p.p.y/D);
        float weight = 0f;
        for(int x=hx-1;x<=hx+1;x++){
          for(int y=hy-1;y<=hy+1;y++){
            String hash = x + "|" + y;
            if(sMap.contains(hash)){
              for(Particle j : Map.get(hash)){
                if(j == p) continue;
                PVector d = PVector.sub(j.p, p.p);
                float m = d.magSq();
                if(m < k_DSQ){
                  m = sqrt(m);
                  weight += 1f-m/k_D;
                }
              }
            }
          }
        }
        p.pressure = -max(0f, p.group.pressure*weight-1f);
      }
      for(Particle p : ps){
        int hx = floor(p.p.x/D);
        int hy = floor(p.p.y/D);
        p.f.set(0f, 0f);
        for(int x=hx-1;x<=hx+1;x++){
          for(int y=hy-1;y<=hy+1;y++){
            String hash = x + "|" + y;
            if(sMap.contains(hash)){
              for(Particle j : Map.get(hash)){
                if(j == p) continue;
                PVector d = PVector.sub(j.p, p.p);
                float m = d.magSq();
                if(m < k_DSQ){
                  m = sqrt(m);
                  float w = 1f-m/k_D;
                  float h = p.pressure + j.pressure;
                  PVector norm = d.normalize();
                  PVector dv = PVector.sub(j.v, p.v);
                  p.f.x += w * p.group.repulsive * h * norm.x * dt;
                  p.f.y += w * p.group.repulsive * h * norm.y * dt;
                  p.f.x += p.group.viscous * dv.x * dt;
                  p.f.y += p.group.viscous * dv.y * dt;
                }
              }
            }
          }
        }
      }
      for(Particle p : ps){
        p.v.x += p.f.x;
        p.v.y += p.f.y;
        p.p.x += p.v.x * dt;
        p.p.y += p.v.y * dt;
      }
    }
    //calHeatmap();
  }
  final void display(){
    for(Particle p : ps){
      noStroke();
      fill(p.c);
      ellipse(p.p.x, p.p.y, k_D, k_D);
    }
  }
  final void display2(){
    loadPixels();
    for(int px=0;px<width;px++){
      for(int py=0;py<height;py++){
        pixels[px+py*width] = Heatmap[py][px];
      }
    }
    updatePixels();
  }
};
