import processing.svg.*;
import java.util.*;
import java.util.List;
import java.util.Map;
Table table;

void setup(){
  size(1400,1000,SVG, "nightingale-data.svg");
  background(255);
  table = loadTable("nightingale-data.csv", "header");
}

void draw(){
  
  PFont f = createFont("Arial",18,true);
  textFont(f, 15);
  textAlign(CENTER, CENTER);
  fill(0);
  text("Nightingale-data(death)", 700, 50);

  for(int i = 0; i < 12; i++){
    float angle = i*2*PI/12;
    int disease = table.getRow(i).getInt("Zymotic diseases");
    int wound = table.getRow(i).getInt("Wounds & injuries");
    int others = table.getRow(i).getInt("All other causes");
    rank_draw(disease,wound,others, angle);
    fill(0);
    text(table.getRow(i).getString("Month"), 
    500 + 350*cos(angle + PI/12), 600 + 350*sin(angle + PI/12));
  }
  fill(137, 190, 178);
  quad(900,130,900,155,950,155,950,130);  text("disease",980, 140);
  fill(128, 0, 0);
  quad(900,165,900,190,950,190,950,165);  text("wound",980, 175);
  fill(255,192,203);
  quad(900,200,900,225,950,225,950,200);  text("others",980, 210); 
  // second copy(be zoomed, repositioned and rotated differently)
  translate(1400, 350);
  rotate(PI/2);
  scale(0.5);
  for(int i = 0; i < 12; i++){
    float angle = i*2*PI/12;
    int disease = table.getRow(i).getInt("Zymotic diseases");
    int wound = table.getRow(i).getInt("Wounds & injuries");
    int others = table.getRow(i).getInt("All other causes");   
    rank_draw(disease,wound,others, angle);
    fill(0);
    text(table.getRow(i).getString("Month"), 
    500 + 350*cos(angle + PI/12), 600 + 350*sin(angle + PI/12));
  }
 
  print("done");
}

void rank_draw(int disease,int wound,int others,float angle){
   //rank
   Map unsortMap=new HashMap();
   unsortMap.put("disease", disease);
   unsortMap.put("wound", wound);
   unsortMap.put("others", others);
   List<Map.Entry<String, Integer>> list = new ArrayList<Map.Entry<String, Integer>>(unsortMap.entrySet());
   list.sort(new Comparator<Map.Entry<String, Integer>>() {
     @Override
     public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
         return o2.getValue().compareTo(o1.getValue());
     }
   });  
   //draw
   for (int i = 0; i < list.size(); i++) {
     String category=list.get(i).getKey();
     int value=list.get(i).getValue();
     switch(category){
       case "disease": fill(137, 190, 178);    break;
       case "wound":   fill(128, 0, 0);        break;
       case "others":  fill(255,192,203);      break;
     }
     arc(500, 600, 20*sqrt(value), 20*sqrt(value), angle, angle + 2*PI/12);
   }
}
