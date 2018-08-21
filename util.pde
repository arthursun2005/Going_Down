int cAlpha(color a){
  return (a >> 24) & 0xff;
}
int cRed(color a){
  return (a >> 16) & 0xff;
}
int cGreen(color a){
  return (a >> 8) & 0xff;
}
int cBlue(color a){
  return a & 0xff;
}
color AddColor(color a, color b){
  int alpha = cAlpha(b);
  float a1 = alpha/255f;
  float a2 = 1f-a1;
  color r = color(
    cRed(a)*a2+cRed(b)*a1, 
    cGreen(a)*a2+cGreen(b)*a1, 
    cBlue(a)*a2+cBlue(b)*a1,
    cAlpha(a)*a2+alpha*a1
  );
  return r;
}
