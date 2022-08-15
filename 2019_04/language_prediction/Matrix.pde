static class Matrix{
  
  int rows;
  int cols;
  
  float[][] values;
  
  Matrix(int rows, int cols){
    
    this.rows = rows;
    this.cols = cols;
    
    //inits 2d array
    values = new float[rows][cols];
    
    //init all to 0
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] = 0;
      }
    }
    
  }
  
  //prints matrix in readable form
  void print_matrix(){
    for(int i = 0;i < rows;i++){
      print("[");
      for(int j = 0;j < cols;j++){
        if(j != 0)print(", ");
        print(values[i][j]);
      }
      println("]");
    }
  }
  
  //randomizes the Matrix
  void randomize(int min, int max){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] = (float)(Math.random()*(max-min)+min);
      }
    }
  }
  
  //adds a Matrix
  void add_matrix(Matrix n){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] += n.values[i][j];
      }
    }
  }
  
  //adds a number to all values
  void add_number(int n){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] += n;
      }
    }
  }
  
  //multiplies the number to all the values
  void multiply_number(float n){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] *= n;
      }
    }
  }
  
  //multiplies the number to all the values
  void multiply_matrix(Matrix m){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] *= m.values[i][j];
      }
    }
  }
  
  void map_sigmoid(){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] = sigmoid(values[i][j]);
      }
    }
  }
  
  void map_dsigmoid(){
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        values[i][j] = dsigmoid(values[i][j]);
      }
    }
  }
  
  float[] to_array(){
    float[] arr = new float[0];
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        arr = append(arr, values[i][j]);
      }
    }
    return arr;
  }
  
  Matrix copy_matrix(){
    Matrix m = new Matrix(rows, cols);
    for(int i = 0;i < rows;i++){
      for(int j = 0;j < cols;j++){
        m.values[i][j] = values[i][j];
      }
    }
    return m;
  }
  
  /////STATIC FUNCTIONS/////
  
  //dot product of the Matrixes
  static Matrix dot_product(Matrix m1, Matrix m2){
    Matrix m = new Matrix(m1.values.length, m2.values[0].length);
    for(int i = 0;i < m.rows;i++){
      for(int j = 0;j < m.cols;j++){
        float tmp = 0;
        for(int k = 0;k < m1.cols;k++){
          tmp += m1.values[i][k]*m2.values[k][j];
        }
        m.values[i][j] = tmp;
      }
    }
    return m;
  }
  
  static Matrix sub_matrix(Matrix m1, Matrix m2){
    if(m1.rows != m2.rows || m1.cols != m2.cols){
      return null;
    }
    Matrix m = new Matrix(m1.rows, m1.cols);
    for(int i = 0;i < m1.rows;i++){
      for(int j = 0;j < m1.cols;j++){
        m.values[i][j] = m1.values[i][j] - m2.values[i][j];
      }
    }
    return m;
  }
  
  //flips the Matrix around
  static Matrix transpose(Matrix m1){
    Matrix m = new Matrix(m1.cols, m1.rows);
    for(int i = 0;i < m1.rows;i++){
      for(int j = 0;j < m1.cols;j++){
        m.values[j][i] = m1.values[i][j];
      }
    }
    return m;
  }
  
  static Matrix from_array(float[] a){
    Matrix m = new Matrix(a.length, 1);
    for(int i = 0;i < a.length;i++){
      m.values[i][0] = a[i];
    }
    return m;
  }
  
}
