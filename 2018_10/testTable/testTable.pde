  
Table table;

void setup() {

  table = new Table();
  createTimetable();
  saveAs("newTimetable");
  
  println("end");
}

void saveAs(String name){
  saveTable(table, "data/" + name + ".csv");
}

void createTimetable(){
  table.addColumn("timeH");
  table.addColumn("timeM");
  for(int d = 0;d < 7;d++){
    table.addColumn(str(d));
    table.addColumn("toH" + str(d));
    table.addColumn("toM" + str(d));
  }
  
  TableRow[] rows = new TableRow[1440];
  for(int h = 0;h < 24;h++){
    for(int m = 0;m < 60;m++){
      rows[h*m+m] = table.addRow();
      rows[h*m+m].setInt("timeH", h);
      rows[h*m+m].setInt("timeM", m);
    }
  }
}