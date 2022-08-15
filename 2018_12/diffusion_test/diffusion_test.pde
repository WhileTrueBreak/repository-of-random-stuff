int scl = 4;
Cell cell_grid[][] = new Cell[100][100];

void setup(){
  for(int y = 0;y < cell_grid.length;y++){
    for(int x = 0;x < cell_grid[y].length;x++){
      cell_grid[y][x] = new Cell(x*scl,y*scl,scl);
    }
  }
  for(int y = 0;y < 50;y++){
    for(int x = 0;x < 45;x++){
      cell_grid[y][x].value = 1;
    }
  }
  for(int y = 0;y < 50;y++){
    for(int x = 55;x < 100;x++){
      cell_grid[y][x].value = 1;
    }
  }
  size(400,400);
}

void draw(){
  background(255);
  for(int y = 0;y < cell_grid.length;y++){
    for(int x = 0;x < cell_grid[y].length;x++){
      cell_grid[y][x].render();
      cell_grid[y][x].diffuse(cell_grid);
    }
  }
  for(int y = 0;y < cell_grid.length;y++){
    for(int x = 0;x < cell_grid[y].length;x++){
      cell_grid[y][x].change();
    }
  }
} //<>//