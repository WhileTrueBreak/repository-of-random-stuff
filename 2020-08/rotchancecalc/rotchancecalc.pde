float ac = 0.0606;
float bc = 0.0606;
float cc = 0.0606;

int n = 200;

float his = 1;

void setup(){
  for(int i = 0;i<n;i++){
    print(str(i+1)+"-");
    switch(i%4){
      case 0:
      his*=(1-ac);
      break;
      case 1:
      his*=(1-ac);
      break;
      case 2:
      his*=(1-bc);
      break;
      case 3:
      his*=(1-cc);
      break;
    }
    println(str(float(floor((1-his)*10000))/100)+"%");
  }
}
