boolean loadSavedAxons = true;
boolean testNN = false;
  
int trainingCycles = 10000000;
int max_word_length = 15;
  
int index = 2;

int langCount = 4;

String[] letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};

String[] english;
String[] chinese;
String[] french;
String[] japanese;

String[] test;

Network n = new Network(max_word_length*26, 50, langCount);

void setup(){
  surface.setVisible(false);
  if(loadSavedAxons){
    println("Loading Axons...");
    println("");
    String[] weights_ih_s1 = loadStrings("Data/weights_ih.txt");
    String[] weights_ho_s1 = loadStrings("Data/weights_ho.txt");  
    String[] bias_h_s1 = loadStrings("Data/bias_h.txt");
    String[] bias_o_s1 = loadStrings("Data/bias_o.txt");
    
    float[][] weights_ih = new float[weights_ih_s1.length][weights_ih_s1[0].split(",").length];
    float[][] weights_ho = new float[weights_ho_s1.length][weights_ho_s1[0].split(",").length];
    float[][] bias_h = new float[bias_h_s1.length][bias_h_s1[0].split(",").length];
    float[][] bias_o = new float[bias_o_s1.length][bias_o_s1[0].split(",").length];
    
    for(int i = 0;i < weights_ih.length;i++){
      for(int j = 0;j < weights_ih[i].length;j++){
        weights_ih[i][j] = Float.parseFloat(weights_ih_s1[i].split(",")[j]);
      }
    }
    for(int i = 0;i < weights_ho.length;i++){
      for(int j = 0;j < weights_ho[i].length;j++){
        weights_ho[i][j] = Float.parseFloat(weights_ho_s1[i].split(",")[j]);
      }
    }
    for(int i = 0;i < bias_h.length;i++){
      for(int j = 0;j < bias_h[i].length;j++){
        bias_h[i][j] = Float.parseFloat(bias_h_s1[i].split(",")[j]);
      }
    }
    for(int i = 0;i < bias_o.length;i++){
      for(int j = 0;j < bias_o[i].length;j++){
        bias_o[i][j] = Float.parseFloat(bias_o_s1[i].split(",")[j]);
      }
    }
    
    if(n.weights_ih.values.length == weights_ih.length&&n.weights_ih.values[0].length == weights_ih[0].length){
      n.weights_ih.values = weights_ih;
    }if(n.weights_ho.values.length == weights_ho.length&&n.weights_ho.values[0].length == weights_ho[0].length){
      n.weights_ho.values = weights_ho;
    }if(n.bias_h.values.length == bias_h.length&&n.bias_h.values[0].length == bias_h[0].length){
      n.bias_h.values = bias_h;
    }if(n.bias_o.values.length == bias_o.length&&n.bias_o.values[0].length == bias_o[0].length){
      n.bias_o.values = bias_o;
    }
  }
  
  english = loadStrings("Data/english.txt");
  chinese = loadStrings("Data/chinese.txt"); 
  french = loadStrings("Data/french.txt"); 
  japanese = loadStrings("Data/japanese.txt"); 
  
  test = loadStrings("Data/test.txt");  
  
  for(int i = 0;i < english.length;i++){
    english[i] = split(english[i], ",")[0].toLowerCase();
  }
  for(int i = 0;i < chinese.length;i++){
    chinese[i] = split(chinese[i], ",")[0].toLowerCase();
  }
  for(int i = 0;i < french.length;i++){
    french[i] = split(french[i], ",")[0].toLowerCase();
  }
  for(int i = 0;i < japanese.length;i++){
    japanese[i] = split(japanese[i], ",")[0].toLowerCase();
  }
  
}
void draw(){
  //start training
  if(!loadSavedAxons){
    println("Training Started");
    println("____________________");
    for(int k = 0;k < trainingCycles;k++){
      //println(k);
      int lang = floor(random(langCount));
      String word = "";
      int min_word_length = 3;
      while(word.length() < min_word_length || word.length() > max_word_length){//checks if word is longer than n letters otherwise it will be to hard to predict
        switch(lang){
          case 0:
            index = floor(random(english.length));
            word = english[index];
          break;
          case 1:
            index = floor(random(chinese.length));
            word = chinese[index];
          break;
          case 2:
            index = floor(random(french.length));
            word = french[index];
          break;
          case 3:
            index = floor(random(japanese.length));
            word = japanese[index];
          break;
        }
      }
      
      if(k % (trainingCycles/20) == 0){
        print("=");
      }
      //println(word);
      
      //convert word to array
      
      float[] input = new float[max_word_length*26];
      float[] output = new float[4];
      
      for(int i = 0;i < word.length();i++){
        for(int j = 0;j < letters.length;j++){
          if(word.charAt(i) == letters[j].charAt(0)){
            input[i*letters.length+j] = 1;
          }
        }
      }
      
      output[lang] = 1;
      
      n.train(input, output);
    }
    println("");
    println("Training Finished!");
    println("");
    Matrix weights_ih = n.get_weights_ih();
    PrintWriter output_ih = createWriter("Data/weights_ih.txt");
    for(int i = 0;i < weights_ih.values.length;i++){
      String[] arr_line = new String[weights_ih.values[i].length];
      for(int j = 0;j < weights_ih.values[i].length;j++){
        arr_line[j] = str(weights_ih.values[i][j]);
      }
      String line  = String.join(",", arr_line);
      output_ih.println(line);
    }
    output_ih.flush();
    output_ih.close();
    Matrix weights_ho = n.get_weights_ho();
    PrintWriter output_ho = createWriter("Data/weights_ho.txt");
    for(int i = 0;i < weights_ho.values.length;i++){
      String[] arr_line = new String[weights_ho.values[i].length];
      for(int j = 0;j < weights_ho.values[i].length;j++){
        arr_line[j] = str(weights_ho.values[i][j]);
      }
      String line  = String.join(",", arr_line);
      output_ho.println(line);
    }
    output_ho.flush();
    output_ho.close();
    Matrix bias_h = n.get_bias_h();
    PrintWriter output_h = createWriter("Data/bias_h.txt");
    for(int i = 0;i < bias_h.values.length;i++){
      String[] arr_line = new String[bias_h.values[i].length];
      for(int j = 0;j < bias_h.values[i].length;j++){
        arr_line[j] = str(bias_h.values[i][j]);
      }
      String line  = String.join(",", arr_line);
      output_h.println(line);
    }
    output_h.flush();
    output_h.close();
    Matrix bias_o = n.get_bias_o();
    PrintWriter output_o = createWriter("Data/bias_o.txt");
    for(int i = 0;i < bias_o.values.length;i++){
      String[] arr_line = new String[bias_o.values[i].length];
      for(int j = 0;j < bias_o.values[i].length;j++){
        arr_line[j] = str(bias_o.values[i][j]);
      }
      String line  = String.join(",", arr_line);
      output_o.println(line);
    }
    output_o.flush();
    output_o.close();
    println("Axons saved...");
    println("");
  }
  //Testing
  if(testNN){
    println("Testing...");
    int count = 0;
    count += testing(english, 0);
    count += testing(chinese, 1);
    count += testing(french, 2);
    count += testing(japanese, 3);
    int wordNum = english.length+chinese.length+french.length+japanese.length;
    float percentage = count/(float)wordNum*100;
    println(percentage + "% with " + wordNum + " words\n");
  }
  //testing
  for(int k = 0;k < test.length;k++){
    String word = test[k].toLowerCase();
    float[] input = new float[max_word_length*26];
    print(word);
    for(int i = 0;i < 15-word.length();i++){
      print(" ");
    }
    print(" -- ");
    for(int i = 0;i < word.length();i++){
      for(int j = 0;j < letters.length;j++){
        if(word.charAt(i) == letters[j].charAt(0)){
          input[i*letters.length+j] = 1;
        }
      }
    }
    float[] out = n.feedforward(input);
    float highest = 0;
    int index = 0;
    for(int i = 0;i < out.length;i++){
      if(highest < out[i]){
        highest = out[i];
        index = i;
      }
    }
    float total = out[0]+out[1]+out[2]+out[3];
    switch(index){
      case(0):
        print("english");
        print(" -- ");
        print(floor(out[0]/total*100));
        println("%");
        break;
      case(1):
        print("chinese");
        print(" -- ");
        print(floor(out[1]/total*100));
        println("%");
        break;
      case(2):
        print("french");
        print(" -- ");
        print(floor(out[2]/total*100));
        println("%");
        break;
      case(3):
        print("japanese");
        print(" -- ");
        print(floor(out[3]/total*100));
        println("%");
        break;
    }
  }
  noLoop();
}

int testing(String[] words, int index){
  int count = 0;
  for(int k = 0;k < words.length;k++){
    if(words[k].length() > 15) continue;
    float[] input = new float[max_word_length*26];
    for(int i = 0;i < words[k].length();i++){
      for(int j = 0;j < letters.length;j++){
        if(words[k].charAt(i) == letters[j].charAt(0)){
          input[i*letters.length+j] = 1;
        }
      }
    }
    float[] output = n.feedforward(input);
    int maxAt = 0;
    for (int i = 0; i < output.length; i++)
        maxAt = output[i] > output[maxAt] ? i : maxAt;
    if(maxAt == index) count++;
  }
  return count;
}
