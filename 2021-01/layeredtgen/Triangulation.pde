float cP = 5;

public class Triangle{
  
  public PVector v1, v2, v3;
  
  public Triangle(PVector v1, PVector v2, PVector v3){
    this.v1 = v1;
    this.v2 = v2;
    this.v3 = v3;
  }
}
public class Line{
  
  public PVector v1, v2;
  
  public Line(PVector v1, PVector v2){
    this.v1 = v1;
    this.v2 = v2;
  }
}

public ArrayList<Line> triangulate(ArrayList<PVector> points, Triangle triangle){
  ArrayList<Line> connections = new ArrayList<Line>();
  //get circumscribed circle
  PVector circle = circleFromPoints(triangle.v1.x, triangle.v1.y, triangle.v2.x, triangle.v2.y, triangle.v3.x, triangle.v3.y);
  //get points within the circle or triangle?
  ArrayList<PVector> internal = new ArrayList<PVector>();
  for(PVector point:points){
    //in circle
    //if(dist(circle.x, circle.y, point.x, point.y)<circle.z){
    //  internal.add(point);
    //}
    //in triangle
    if(PointInTriangle(point, triangle)){
      internal.add(point);
    }
  }
  //if no point exit
  if(internal.size()==0){
    connections.add(new Line(triangle.v1, triangle.v2));
    connections.add(new Line(triangle.v2, triangle.v3));
    connections.add(new Line(triangle.v3, triangle.v1));
    //strokeWeight(0.5);
    //stroke(255, 100);
    //noFill();
    //triangle(triangle.x1*cP+camOffset.x, triangle.y1*cP+camOffset.y, triangle.x2*cP+camOffset.x, triangle.y2*cP+camOffset.y, triangle.x3*cP+camOffset.x, triangle.y3*cP+camOffset.y);
    return connections;
  }
  //pick a point
  PVector next = internal.get(0);
  float closest = circle.z;
  for(PVector point:points){
    float dist = dist(circle.x, circle.y, point.x, point.y);
    if(dist<closest){
      next = point;
      closest = dist;
    }
  }
  //get triangles
  Triangle T1 = new Triangle(next, triangle.v1, triangle.v2);
  Triangle T2 = new Triangle(next, triangle.v2, triangle.v3);
  Triangle T3 = new Triangle(next, triangle.v3, triangle.v1);
  //recursion
  points.remove(next);
  connections.addAll(triangulate(points, T1));
  connections.addAll(triangulate(points, T2));
  connections.addAll(triangulate(points, T3));
  return connections;
}


public PVector circleFromPoints(float x1, float y1, float x2, float y2, float x3, float y3){
  float H1 = x1*x1+y1*y1;
  float H2 = x2*x2+y2*y2;
  float H3 = x3*x3+y3*y3;
  
  float A = x1*(y2-y3)-y1*(x2-x3)+x2*y3-x3*y2;
  float B = H1*(y3-y2)+H2*(y1-y3)+H3*(y2-y1);
  float C = H1*(x2-x3)+H2*(x3-x1)+H3*(x1-x2);
  //float D = H1*(x3*y2-x2*y3)+H2*(x1*y3-x3*y1)+H3*(x2*y1-x1*y2);
  
  float x = -B/(2*A);
  float y = -C/(2*A);
  float r = (float) Math.sqrt((x-x1)*(x-x1)+(y-y1)*(y-y1));
  
  return new PVector(x, y, r);
}

public float sign(float x1, float y1, float x2, float y2, float x3, float y3){
    return (x1-x3)*(y2-y3)-(x2-x3)*(y1-y3);
}

boolean PointInTriangle(PVector point, Triangle triangle){
    float d1, d2, d3;
    boolean has_neg, has_pos;

    d1 = sign(point.x, point.y, triangle.v1.x, triangle.v1.y, triangle.v2.x, triangle.v2.y);
    d2 = sign(point.x, point.y, triangle.v2.x, triangle.v2.y, triangle.v3.x, triangle.v3.y);
    d3 = sign(point.x, point.y, triangle.v3.x, triangle.v3.y, triangle.v1.x, triangle.v1.y);

    has_neg = (d1<0)||(d2<0)||(d3<0);
    has_pos = (d1>0)||(d2>0)||(d3>0);

    return !(has_neg&&has_pos);
}
