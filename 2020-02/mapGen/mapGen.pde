import java.util.*; 

int MAX_SIZE = 10000;
ArrayList<PVector>nodes;
ArrayList<PVector>fNodes;

void setup(){
  int size = 0;
  nodes = new ArrayList<PVector>();
  fNodes = new ArrayList<PVector>();
  nodes.add(new PVector(0, 0, 15));
  for(PVector node:nodes){
    if(((int)node.z&1)==1){
      fNodes.add(new PVector(node.x, node.y-1, 4));
    }if(((int)node.z&2)==2){
      fNodes.add(new PVector(node.x+1, node.y, 8));
    }if(((int)node.z&4)==4){
      fNodes.add(new PVector(node.x, node.y+1, 1));
    }if(((int)node.z&8)==8){
      fNodes.add(new PVector(node.x-1, node.y, 2));
    }
  }
  
  int c = 0;
  
  while(fNodes.size()!=0){
    //println(""+c);
    ArrayList<PVector>toAdd = new ArrayList<PVector>();
    println(fNodes.size()+", "+size);
    for(PVector node:fNodes){
      //println(node);
      node.z=(int)random(16)|(int)node.z;
      if(random(1)<(MAX_SIZE-size)/(float)MAX_SIZE){
        if(((int)node.z&1)==1){
          //println("up");
          node.z=(int)node.z|1;
          toAdd.add(new PVector(node.x, node.y-1, 4));
          size++;
        }if(((int)node.z&2)==2){
          //println("right");
          node.z=(int)node.z|2;
          toAdd.add(new PVector(node.x+1, node.y, 8));
          size++;
        }if(((int)node.z&4)==4){
          //println("down");
          node.z=(int)node.z|4;
          toAdd.add(new PVector(node.x, node.y+1, 1));
          size++;
        }if(((int)node.z&8)==8){
          //println("left");
          node.z=(int)node.z|8;
          toAdd.add(new PVector(node.x-1, node.y, 2));
          size++;
        }
      }
      nodes.add(node);
    }
    fNodes = new ArrayList<PVector>();
    ArrayList<PVector>toRemove = new ArrayList<PVector>();
    c=0;
    for(PVector n1:toAdd){
      for(PVector n2:nodes){
        if((int)n1.x==(int)n2.x&&(int)n1.y==(int)n2.y){
          toRemove.add(n1);
          n2.z=(int)n2.z|(int)n1.z;
          c++;
        }
      }
      if(toRemove.contains(n1)){
        size--;
      }
    }
    toAdd.removeAll(toRemove);
    fNodes.addAll(toAdd);
  }
  //render/print
  int lx = 0;
  int ly = 0;
  int sx = (int)Double.POSITIVE_INFINITY;
  int sy = (int)Double.POSITIVE_INFINITY;
  for(PVector node:nodes){
    if(node.x>lx)
      lx = (int)node.x;
    if(node.y>ly)
      ly = (int)node.y;
    if(node.x<sx)
      sx = (int)node.x;
    if(node.y<sy)
      sy = (int)node.y;
  }
  int[][]map = new int[lx-sx+1][ly-sy+1];
  println("---");
  for(PVector node:nodes){
    map[(int)node.x-sx][(int)node.y-sy] = (int)node.z+1;
  }
  println("---");
  String text = "";
  for(int i = 0;i < map[0].length;i++){
    for(int j = 0;j < map.length;j++){
      switch(map[j][i]-1){
        case -1:
        text+=" ";
        break;
        case 0:
        text+="▪";
        break;
        case 1:
        text+="╨";
        break;
        case 2:
        text+="╞";
        break;
        case 3:
        text+="╚";
        break;
        case 4:
        text+="╥";
        break;
        case 5:
        text+="║";
        break;
        case 6:
        text+="╔";
        break;
        case 7:
        text+="╠";
        break;
        case 8:
        text+="╡";
        break;
        case 9:
        text+="╝";
        break;
        case 10:
        text+="═";
        break;
        case 11:
        text+="╩";
        break;
        case 12:
        text+="╗";
        break;
        case 13:
        text+="╣";
        break;
        case 14:
        text+="╦";
        break;
        case 15:
        text+="╬";
        break;
      }
    }
    text+="\n";
  }
  String[] tx = new String[1];
  tx[0]=text;
  saveStrings("map.txt",tx);
  println("Finished");
}






//▪╨╞╚╥║╔╠╡╝═╩╗╣╦╬
