class Line
{
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  Line(){}
  Line(float a, float b, float c, float d){
    p1.set(a,b);
    p2.set(c,d);
  }
  Line(PVector a, PVector b){
    p1.set(a);
    p2.set(b);
  }
  final PVector Diff(){
    return PVector.sub(p2,p1);
  }
  final PVector Center(){
    return (PVector.add(p2,p1).div(2f));
  }
  final void RotateAround(float a, PVector p){
    p1.sub(p);
    p2.sub(p);
    p1.rotate(a);
    p2.rotate(a);
    p1.add(p);
    p2.add(p);
  }
};
