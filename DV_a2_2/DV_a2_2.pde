import processing.svg.*;
Table table;
int num_city = 20;
int num_temp = 9;
int num_dir = 48;

void setup(){
  size(1400, 1000,SVG, "minard-data.svg");
  background(255); 
  table = loadTable("minard-data.csv", "header");
}

void draw(){

  PFont f = createFont("Arial",18);
  textFont(f, 15);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Minard-data", 700, 50);
  
  drwaRoute();
  drawCity();
  drawTemperature();
  print("done");
}


float newLon(float lon){
  //min Lon=24 max=37.6
  return (lon - 24) * 90 + 80;
}

float newLat(float lat){
 // min Lat=53.9 max=55.8
  return -((lat - 53.9) *180) + 500;  // the origional point is in the left_top corner
}

void drwaRoute(){
  
  stroke(236,2, 3);
  fill(236, 2, 3,128);
  for(int i = 1; i < num_dir; i++){
    if(table.getRow(i-1).getString("DIR").equals("R")){
      strokeWeight(table.getRow(i-1).getFloat("SURV")/7000);
      line(newLon(table.getRow(i-1).getFloat("LONP")), newLat(table.getRow(i-1).getFloat("LATP")), 
      newLon(table.getRow(i).getFloat("LONP")), newLat(table.getRow(i).getFloat("LATP")));
    }
  }
  quad(1180,450,1180,475,1250,475,1250,450);  text("return",1272, 460);
  
  stroke(137,190, 178);
  fill(137, 190, 178,128);
  for(int i = 1; i < num_dir; i++){
    if(table.getRow(i-1).getString("DIR").equals("A")){
      strokeWeight(table.getRow(i-1).getFloat("SURV")/7000);
      line(newLon(table.getRow(i-1).getFloat("LONP")), newLat(table.getRow(i-1).getFloat("LATP")), 
      newLon(table.getRow(i).getFloat("LONP")), newLat(table.getRow(i).getFloat("LATP")));
    }
  }
  quad(1180,500,1180,525,1250,525,1250,500);  text("attack",1272, 510);
}

void drawCity(){
  PFont f = createFont("Arial",16,true);
  textFont(f, 12);
  fill(0);
  for(int i = 0; i < num_city; i++){ 
    text(table.getRow(i).getString("CITY"), 
    newLon(table.getRow(i).getFloat("LONC")),newLat(table.getRow(i).getFloat("LATC")));  
  }
}

void drawTemperature(){
  
  stroke(0);
  strokeWeight(1);
  fill(0);

  //draw 5+1 lines
  for(int i = 0; i < 5; i++){
    line(80, 700 + (i * 50), 1304, 700 + (i * 50));
    if(i<4){
      text(i * -10,1314, 700 + (i * 50));
      text(i * -10 -5,1314, 700 + (i * 50)+25);
    }
  }
  line(1304, 700, 1304,900);
  
  //draw temp values  50dp ====  10C
  for(int i = 1; i < num_temp; i++){
    strokeWeight(4);
    text( table.getRow(i).getString("MON") + " " + table.getRow(i).getInt("DAY"), 
    newLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 710);
    stroke(200,0,0);//red line
    line(newLon(table.getRow(i - 1).getFloat("LONT")),-(table.getRow(i - 1).getFloat("TEMP") * 5) + 700, 
    newLon(table.getRow(i).getFloat("LONT")),-(table.getRow(i).getFloat("TEMP") * 5) + 700);
  }
}