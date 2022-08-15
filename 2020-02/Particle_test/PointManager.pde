class PointManager{
  
  ArrayList<Point> points;
  
  public PointManager(){
    points = new ArrayList<Point>();
  }
  
  public void update(){
    ArrayList<Point> toRemove = new ArrayList<Point>();
    for(Point point:points){
      if(point.isDead()) toRemove.add(point);
      point.update();
    }
    points.removeAll(toRemove);
  }
  
  public void render(){
    for(int i = 0;i < points.size();i++){
      points.get(i).render();
      for(int j = i;j < points.size();j++){
        if(i==j)continue;
        float x1 = points.get(i).pos.x, y1 = points.get(i).pos.y, x2 = points.get(j).pos.x, y2 = points.get(j).pos.y;
        float dist = dist(x1, y1, x2, y2);
        if(dist>50) continue;
        float lMap = map(dist, 0, 50, 20, 1);
        for(float k = lMap;k >= 0 ;k--){
          strokeWeight(k/10);
          //map(dist, 30, 50, 255, 0)
          stroke(61, 196, 125, 255-255/lMap*(int)(k+1));
          line(x1, y1, x2, y2);
        }
      }
    }
  }
  
  public void addPoint(Point point){
    points.add(point);
  }
  
}
