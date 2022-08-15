String str = "Children will come up with the most extraordinary things when they start using language Cute things hilarious things and sometimes baffling things that may start us wondering whether we should worry about their language development This article summarizes some of the knowledge we have about typical child language acquisition that is what you as a caregiver need not worry about The last sections give a few pointers about when to seek professional help concerning your child's language development and about resources on language acquisition";
ArrayList<Type> str_arr = new ArrayList();

PFont font;
float sdgreg;

void setup() {
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  String[] strs = str.split(" ");
  for (int i = 0; i < strs.length*20; i++) {
    float x = random(width*-0.5, width*1.5);
    float y = random(height*-0.5, height*1.5);
    float z = random(-width*50, width/2);
    str_arr.add(new Type(strs[i%strs.length], x, y, z));
  }
}

void draw() {
  background(0,0,0);
  for (int i = 0; i < str_arr.size(); i++) {
    str_arr.get(i).update();
    str_arr.get(i).display();
  }
}

class Type {
  
  String str;
  float x, y, z;
  
  Type(String str, float x, float y, float z) {
    this.str = str;
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void update() {
    this.z += 10;
    if(this.z > width/2){
      this.z = -width*50;
    }
  }

  void display() {
    push();
    translate(this.x, this.y, this.z);
    textAlign(CENTER, CENTER);
    //textFont(font);
    textSize(100);
    fill(100);
    text(this.str, 0, 0);
    pop();
  }
}
