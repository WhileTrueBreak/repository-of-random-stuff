int ncount = 10;
int nums[] = new int[ncount];
int buffer[] = new int[ncount];
int count[] = new int[10];

void setup(){
  for(int i = 0;i < ncount;i++){
    nums[i] =  (int)random(0, 999);
  }
  for(int j = 0;j < ncount;j++){
    print(nums[j]+" ");
  }
  println();
  exit();
  for(int i = 0;i < 3;i++){
    int place = (int)Math.pow(10,i);
    for(int j = 0;j < ncount;j++){
      int digit = nums[j]/place%10;
      count[digit]++;
    }
    for(int j = 1;j < 10;j++){
      count[j] += count[j-1];
    }
    for(int j = ncount-1;j >= 0;j--){
      int digit = nums[j]/place%10;
      buffer[--count[digit]] = nums[j];
    }
    for(int j = 0;j < ncount;j++){
      nums[j] = buffer[j];
    }
    for(int j = 0;j < ncount;j++){
      print(nums[j]+" ");
    }
    println();
    count = new int[10];
  }
  
}
