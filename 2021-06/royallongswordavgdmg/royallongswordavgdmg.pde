
float basedmg = 10;
float basecritrate = 0.1;
float basecritdmg = 0.1;
float addcritrate = 0.05;
int limit = 5;

int counter = 0;
float totaldmg = 0;

int hits = 1000000;

void setup(){
  size(1000, 500);
  background(0);
  
  strokeWeight(1);
  stroke(255);
  
  for(int n = 0;n < 10;n++){
    counter = 0;
    totaldmg = 0;
    for(int i = 0;i < hits;i++){
      float totalcritrate = basecritrate + addcritrate*counter;
      if(random(1) < totalcritrate){
          counter = 0;
          totaldmg += basedmg*(basecritdmg);
      }else{
          if(counter < limit)
              counter++;
          totaldmg+=0;
      }
      point((width/(float)hits)*(float)i, totaldmg/(i+1)*500);
    }
    println(totaldmg/((float)hits));
  }
}
