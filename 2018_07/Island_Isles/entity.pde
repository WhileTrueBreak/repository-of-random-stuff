class entity{
  float BASE_HEALTH = 100;
  boolean pickable = false;
  protected void shapel2Creator(int id,float x,float y,float iw,float ih,int bit){
    noStroke();
    smooth();
    for(int h = 0;h< texturel2[id].length;h++){
      for(int w = 0;w < texturel2[id][0].length;w++){
        fill(texturel2ColorPalette[id][texturel2[id][h][w]]);
        rect(x+w*iw/bit,y+h*ih/bit,iw/bit,ih/bit);
      }
    }
    textAlign(LEFT,TOP);
    textSize(iw);
    //text(id,x,y);
  }
}