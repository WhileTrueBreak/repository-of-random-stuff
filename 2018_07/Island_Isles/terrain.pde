class terrain{
  ArrayList<entity> all = new ArrayList();
  ArrayList<grass> grasses = new ArrayList();
  ArrayList<bigTree> bigTrees = new ArrayList();
  ArrayList<smallTree> smallTrees = new ArrayList();
  ArrayList<pebble> pebbles = new ArrayList();
  
  float threshhold = 100;
  
  PVector shift = playerWorldCords.mult(-1);
  int[][] l1;
  PVector dimensions;
  terrain(int bw,int bh){
    dimensions = new PVector(bw,bh);
    l1 = new int[bw][bh];
  }
  void update(){
    shift = playerWorldCords.mult(-1);
  }
  void createLayers(){
    float scl = scale;
    //l1:1 = water
    //2 = grass
    //3 = sand
    //4 = dirt
    //l2:1 = grass
    //2 = trees
    //3 = dense trees
    //4 = pebbles
    //5 = stone
    //6 = boulder
    for(int h = 0;h< dimensions.x;h++){
      for(int w = 0;w < dimensions.y;w++){
        float l1d = 0.04;
        float nl1 = noise(w*l1d,h*l1d)*40;
        //l1 creating
        if(nl1<15){
          l1[h][w] = 0;
        }else if(nl1<17){
          l1[h][w] = 2;
        }else if(nl1<20){
          l1[h][w] = 3;
        }else{
          l1[h][w] = 1;
        }
      }
    }
    for(int h = 0;h< dimensions.x;h++){
      for(int w = 0;w < dimensions.y;w++){
        float l2d = 0.1;
        float l2d1 = 0.2;
        float nl21 = noise(w*l2d1,h*l2d1)*40;
        float nl2 = noise(w*l2d,h*l2d)*40;
        boolean onWater = l1[h][w] == 0;
        boolean onSand = l1[h][w] == 2;
        if(random(1)<0.01&&!onWater){
          //l2[h][w] = 5;
        }else if(random(1)<0.02&&!onWater){
          //l2[h][w] = 4;
        }else if(random(1)<0.04&&!onWater){
          pebbles.add(new pebble(w*scl,h*scl,scl));
        }else if(nl2<10&&!onWater&&!onSand){
          bigTrees.add(new bigTree(w*scl-scl*2/8,h*scl-scl,scl));
        }else if(nl2<15&&!onWater&&!onSand){
          smallTrees.add(new smallTree(w*scl-scl*1/8,h*scl-scl*2/3,scl));
        }else if(nl21<20&&!onWater&&!onSand){
          grasses.add(new grass(w*scl,h*scl,scl));
        }
      }
    }
  }
  void display1(){
    float scl = scale;
    for(int h = 0;h< dimensions.x;h++){
      for(int w = 0;w < dimensions.y;w++){
        if(w*scl+shift.copy().x+scl>0-threshhold&&h*scl+shift.copy().y+scl>0-threshhold&&w*scl+shift.copy().x<width+threshhold&&h*scl+shift.copy().y<height+threshhold){
          if(l1[h][w] == 0){
            shapel1Creator(0,w*scl+shift.copy().x,h*scl+shift.copy().y,scl,scl);
          }else if(l1[h][w] == 1){
            shapel1Creator(1,w*scl+shift.copy().x,h*scl+shift.copy().y,scl,scl);
          }else if(l1[h][w] == 2){
            shapel1Creator(2,w*scl+shift.copy().x,h*scl+shift.copy().y,scl,scl);
          }else if(l1[h][w] == 3){
            shapel1Creator(3,w*scl+shift.copy().x,h*scl+shift.copy().y,scl,scl);
          }
        }
      }
    }
    for(int i = 0;i<dimensions.y;i++){
      for(grass part:grasses){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl<=p.pos.y+scl*3/2+height/2+10&&round(part.pos.y/scl)==i){
            part.display(shift);
          }
        }
      }
      for(pebble part:pebbles){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl<=p.pos.y+scl*4/2+height/2+10&&round(part.pos.y/scl)==i){
            part.display(shift);
          }
        }
      }
      for(bigTree part:bigTrees){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl<=p.pos.y+scl*1/2+height/2+10&&round((part.pos.y)/scl)==i){
            part.display(shift);
          }
        }
      }
      for(smallTree part:smallTrees){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl<=p.pos.y+scl*5/7+height/2+10&&round((part.pos.y)/scl)==i){
            part.display(shift);
          }
        }
      }
    }
  }
  void display2(){
    float scl = scale;
    for(int i = 0;i<dimensions.y;i++){
      for(grass part:grasses){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl>=p.pos.y+scl*3/2+height/2&&round(part.pos.y/scl)==i){
            part.display(shift);
          }
        }
      }
      for(pebble part:pebbles){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl>=p.pos.y+scl*4/2+height/2&&round(part.pos.y/scl)==i){
            part.display(shift);
          }
        }
      }
      for(bigTree part:bigTrees){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl>=p.pos.y+scl*1/2+height/2&&round((part.pos.y)/scl)==i){
            part.display(shift);
          }
        }
      }
      for(smallTree part:smallTrees){
        if(part.pos.x+shift.x>0-threshhold&&part.pos.x+shift.x<width+threshhold&&part.pos.y+shift.y>0-threshhold&&part.pos.y+shift.y<height+threshhold){
          if(part.pos.y+scl>=p.pos.y+scl*5/7+height/2&&round((part.pos.y)/scl)==i){
            part.display(shift);
          }
        }
      }
    }
  }
  private void shapel1Creator(int id,float x,float y,float iw,float ih){
    noStroke();
    for(int h = 0;h< texturel1[id].length;h++){
      for(int w = 0;w < texturel1[id][0].length;w++){
        fill(texturel1ColorPalette[id][texturel1[id][h][w]]);
        rect(x+w*iw/8,y+h*ih/8,iw/8,ih/8);
        fill(0);
      }
    }
    textAlign(LEFT,TOP);
    textSize(iw);
    //text(id,x,y);
  }
  
}