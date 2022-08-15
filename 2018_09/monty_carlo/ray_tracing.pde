class tracing{
  tracing(){
    
  }
  void check(){
    for(rp p:points){
      if(!p.checked){
        ray r = new ray(new PVector(0,0),new PVector(p.pos.x,p.pos.y));
        for(lineS l:d.lines){
          if(lineLine(l.start,l.end,r.start,r.end)){
            r.interceptN++;
            p.checked = true;
          }
        }
        println("num of intercepts is " + r.interceptN);
        if(r.interceptN%2==1){
          p.in = true;
        }
      }
    }
  }
  boolean lineLine(PVector p1,PVector p2,PVector p3,PVector p4) {
    float uA = ((p4.x-p3.x)*(p1.y-p3.y) - (p4.y-p3.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    float uB = ((p2.x-p1.x)*(p1.y-p3.y) - (p2.y-p1.y)*(p1.x-p3.x)) / ((p4.y-p3.y)*(p2.x-p1.x) - (p4.x-p3.x)*(p2.y-p1.y));
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return true;
    }
    return false;
  }
}