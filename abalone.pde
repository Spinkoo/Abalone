import controlP5.*;


import java.util.*;
public LinkedList<Point> ballsSelected = new LinkedList<Point> ();
enum Directions {
  UPLEFT, UPRIGHT, DOWNLEFT, DOWNRIGHT, LLEFT, RRIGHT
};




private boolean isHoriz(Point a, Point b) {
 return a.x==b.x;
}
private boolean isDiag(Point a, Point b) {
  if (a.x==b.x+1 && a.y==b.y+1) return true;
  if (a.x==b.x-1 && a.y==b.y+1) return true;
  if (a.x==b.x-1 && a.y==b.y-1) return true;
  if (a.x==b.x+1 && a.y==b.y-1) return true;
  return false;
}
private boolean contain(ArrayList<Integer[][]> a, Integer[][]f) {
  for (int l=0; l<a.size(); l++) {  
    boolean b=true;

    for (int i=0; i<9; i++) {
      for (int j=0; j<17; j++) {
        if (a.get(l)[i][j]!=(f[i][j])) {
          b=false; 
          break;
        }
        if (j==16 && i==8 && a.get(l)[i][j]==(f[i][j])) return true;
      } 
      if (!b) break;
    }
  }
  return false;
}
private boolean compare(int[][] a, int[][]f) {
  if (a==null || f==null) return false;
  for (int i=0; i<9; i++) {
    for (int j=0; j<17; j++) {
      if (a[i][j] !=f[i][j]) {
        return false;
      }
    }
  }
  return true;
}
public void create(Integer[][]a, int[][]b) {
  for (int i=0; i<9; i++)for (int j=0; j<17; j++) {
    a[i][j]=b[i][j];
  }
}

public int[][] createcopy(int[][]b) {
  int [][] a= new int[9][17];
  for (int i=0; i<9; i++)for (int j=0; j<17; j++) {
    a[i][j]=b[i][j];
  }
  
  return a;
}

public ArrayList<Point> adjacents2points(int player, int[][] board, ArrayList<Point> listep) {

  int adverse= adverse(player);
  ArrayList<Point>liste1 = new ArrayList<Point>(); 
  ArrayList<Point>liste2 = new ArrayList<Point>();

  liste1 = adjacents(board, listep.get(0), Empty_Box);
  liste1.addAll( adjacents(board, listep.get(0), adverse));

  liste2 = adjacents(board, listep.get(1), Empty_Box);
  liste2.addAll(adjacents(board, listep.get(1), adverse));

  for (int i=0; i<liste2.size(); i++) {
    if (!liste1.contains(liste2.get(i))) liste1.add(liste2.get(i));
  }   
  return liste1;
}

public ArrayList<Point> adjacents4pointsDiago(int player, int[][] board, ArrayList<Point>listep) {



  ArrayList<Point>liste1 = new ArrayList<Point>(); 

  ArrayList<Point> temporary =  new ArrayList<Point>();


  for (int i=0; i<listep.size(); i++) {
    liste1 = adjacents(Empty_Box, board, listep.get(i));
    liste1.addAll(adjacents(player, board, listep.get(i)));


    for (Point e : liste1) {

      if (goalAlignedToAll(listep, e)) { 
        if (!listep.contains(e) && !temporary.contains(e)) {  
          temporary.add(e);
        }
      }
    }
  }





  return temporary;
}





boolean updated=false;

public ArrayList<Point> adjacents4pointsLaterale(int player, int[][] board, ArrayList<Point>listep) {



  ArrayList<Point>liste1 = new ArrayList<Point>(); 

  ArrayList<Point> temporary =  new ArrayList<Point>();


  for (int i=0; i<listep.size(); i++) {
    liste1 = adjacents(Empty_Box, board, listep.get(i));
    liste1.addAll(adjacents(player, board, listep.get(i)));


    for (Point e : liste1) {


      if (!listep.contains(e) && !temporary.contains(e)) {  
        temporary.add(e);
      }
    }
  }





  return temporary;
}











public ArrayList<Point> adjacents4pointsHorizo(int adverse, int[][] board, ArrayList<Point>listep) {




  ArrayList<Point>liste1 = new ArrayList<Point>(); 

  ArrayList<Point> temporary =  new ArrayList<Point>();

  for (int i=0; i<listep.size(); i++) {
    liste1 = adjacents(Empty_Box, board, listep.get(i));
    liste1.addAll(adjacents(adverse, board, listep.get(i)));


    for (Point e : liste1) {

      if (goalAlignedToAllVertical(e, listep)) { 
        if (!listep.contains(e) && !temporary.contains(e)) {  
          temporary.add(e);
        }
      }
    }
  }




  return temporary;
}



public ArrayList<ArrayList<Point>> adjacents3pointsDiago(int player, int[][] board, ArrayList<ArrayList<Point>>listep) {

  ArrayList<Point>liste1 = new ArrayList<Point>(); 
  ArrayList<Point>liste2 = new ArrayList<Point>();
  ArrayList<ArrayList<Point>> temporary =  new ArrayList<ArrayList<Point>>();


  for (int i=0; i<listep.size(); i++) {
    liste1 = adjacents(player, board, listep.get(i).get(0));



    for (Point e : liste1) {

      if (goalAlignedToAll(listep.get(i), e)) {    
        ArrayList<Point> tempArr =  new ArrayList<Point>();  
        tempArr.addAll(listep.get(i)); 

        if (tempArr.contains(e)) continue;  
        tempArr.add(e);   
        Collections.sort(tempArr, new Comparator<Point>() {

          public int compare(Point p1, Point p2) {
            if (p1.x> p2.x ) return 1;
            else if (p1.x < p2.x) return -1;
            else   if (p1.y> p2.y ) return 1;
            else if (p1.y < p2.y) return -1;
            return 0;
          }
        }
        );    
        if (!temporary.contains(tempArr)) {  
          temporary.add(tempArr);
        }
      }
    }
  }


  for (int i=0; i<listep.size(); i++) {
    liste2 = adjacents(player, board, listep.get(i).get(1));



    for (Point e : liste2) {

      if (goalAlignedToAll(listep.get(i), e)) {   
        ArrayList<Point> tempArr =  new ArrayList<Point>();  
        tempArr.addAll(listep.get(i));
        if (tempArr.contains(e)) continue;
        tempArr.add(e); 

        Collections.sort(tempArr, new Comparator<Point>() {

          public int compare(Point p1, Point p2) {
            if (p1.x> p2.x ) return 1;
            else if (p1.x < p2.x) return -1;
            else   if (p1.y> p2.y ) return 1;
            else if (p1.y < p2.y) return -1;
            return 0;
          }
        }
        );     
        if (!temporary.contains(tempArr)) {
          temporary.add(tempArr);
        }
      }
    }
  }


  return temporary;
}












public ArrayList<ArrayList<Point>> adjacents3pointsHorizo(int player, int[][] board, ArrayList<ArrayList<Point>>listep) {

  ArrayList<Point>liste1 = new ArrayList<Point>(); 
  ArrayList<Point>liste2 = new ArrayList<Point>();
  ArrayList<ArrayList<Point>> temporary =  new ArrayList<ArrayList<Point>>();


  for (int i=0; i<listep.size(); i++) {
    liste1 = adjacents(player, board, listep.get(i).get(0));



    for (Point e : liste1) {

      if (goalAlignedToAllVertical(e, listep.get(i))) {    
        ArrayList<Point> tempArr =  new ArrayList<Point>();  
        tempArr.addAll(listep.get(i)); 

        if (tempArr.contains(e)) continue;  
        tempArr.add(e);   
        Collections.sort(tempArr, new Comparator<Point>() {

          public int compare(Point p1, Point p2) {
            if (p1.x> p2.x ) return 1;
            else if (p1.x < p2.x) return -1;
            else   if (p1.y> p2.y ) return 1;
            else if (p1.y < p2.y) return -1;
            return 0;
          }
        }
        );    
        if (!temporary.contains(tempArr)) {  
          temporary.add(tempArr);
        }
      }
    }
  }


  for (int i=0; i<listep.size(); i++) {
    liste2 = adjacents(player, board, listep.get(i).get(1));



    for (Point e : liste2) {

      if (goalAlignedToAllVertical(e, listep.get(i))) {   
        ArrayList<Point> tempArr =  new ArrayList<Point>();  
        tempArr.addAll(listep.get(i));
        if (tempArr.contains(e)) continue;
        tempArr.add(e); 

        Collections.sort(tempArr, new Comparator<Point>() {

          public int compare(Point p1, Point p2) {
            if (p1.x> p2.x ) return 1;
            else if (p1.x < p2.x) return -1;
            else   if (p1.y> p2.y ) return 1;
            else if (p1.y < p2.y) return -1;
            return 0;
          }
        }
        );     
        if (!temporary.contains(tempArr)) {
          temporary.add(tempArr);
        }
      }
    }
  }




  return temporary;
}








public ArrayList<Point> adjacents(int[][]board, Point p, int player) {

  ArrayList<Point> liste = new ArrayList<Point>();
  i=p.x; 
  j=p.y;

  if (j+1 <17 && i+1 < 9 && (board[i+1][j+1]==player  )) liste.add(new Point(i+1, j+1));
  if (j-1 >=0 && i-1 >= 0 && board[i-1][j-1]==player) liste.add(new Point(i-1, j-1));
  if (j-1 >=0 && i+1 < 9 && board[i+1][j-1]==player) liste.add(new Point(i+1, j-1));
  if (j+1 <17 && i-1 >=0 && board[i-1][j+1]==player) liste.add(new Point(i-1, j+1));
  if (j+2 <17 && board[i][j+2]==player)   liste.add(new Point(i, j+2));
  if (j-2 >=0 && board[i][j-2]==player)   liste.add(new Point(i, j-2));

  return liste;
}


public ArrayList<Point> adjacents(int player, int[][]board, Point p) {

  ArrayList<Point> liste = new ArrayList<Point>();
  i=p.x; 
  j=p.y;

  if (j+1 <17 && i+1 < 9 && board[i+1][j+1]==player) liste.add(new Point(i+1, j+1));
  if (j-1 >=0 && i-1 >= 0 && board[i-1][j-1]==player) liste.add(new Point(i-1, j-1));
  if (j-1 >=0 && i+1 < 9 && board[i+1][j-1]==player) liste.add(new Point(i+1, j-1));
  if (j+1 <17 && i-1 >=0 && board[i-1][j+1]==player) liste.add(new Point(i-1, j+1));
  if (j+2 <17 && board[i][j+2]==player)   liste.add(new Point(i, j+2));
  if (j-2 >=0 && board[i][j-2]==player)   liste.add(new Point(i, j-2));

  return liste;
}



public ArrayList<Directions> func(int[][]board, int i, int j) {

  ArrayList<Directions> liste = new ArrayList<Directions>();

  if (j+1 <17 && i+1 < 9 && board[i+1][j+1]==Empty_Box) liste.add(Directions.DOWNRIGHT);
  if (j-1 >=0 && i-1 >= 0 && board[i-1][j-1]==Empty_Box) liste.add(Directions.UPLEFT);
  if (j-1 >=0 && i+1 < 9 && board[i+1][j-1]==Empty_Box) liste.add(Directions.DOWNLEFT);
  if (j+1 <17 && i-1 >=0 && board[i-1][j+1]==Empty_Box) liste.add(Directions.UPRIGHT);
  if (j+2 <17 && board[i][j+2]==Empty_Box)   liste.add(Directions.RRIGHT);
  if (j-2 >=0 && board[i][j-2]==Empty_Box)     liste.add(Directions.LLEFT);

  return liste;
}


public class Point {


  private int x;
  private int y;
  private float d;
  private boolean leader;

  public Point (int x, int y) {
    this.x=x;
    this.y=y;
    this.d=0;

    this.leader = false;
  }


  public Point (int x, int y, boolean b) {
    this.x=x;
    this.y=y;
    this.d=0;

    this.leader = b;
  }



  boolean equals(Object arg) {
    if (arg instanceof Point) { 
      Point tem=(Point)arg;
      return this.x==tem.x && this.y==tem.y ;
    }
    return false;
  }


  public void setD(float d) {
    this.d=d;
  }
  public void setX(int x) {
    this.x=x;
  }
  public void setY(int y) {
    this.y=y;
  }
  public int getX() {
    return this.x;
  }
  public float getD() {
    return this.d;
  }
  public int getY() {
    return this.y;
  }
  public boolean isleader() {
    return this.leader;
  } 
  public void setLeaderTrue() {
    this.leader = true;
  }
  public void setLeaderFalse() {
    this.leader = false;
  }

  public String toString() {
    return "--->"+this.x+","+this.y+"<---"+"-"+this.d;
  }
}





public static final int  PLAYER_0=2;
public static final int  PLAYER_1=3;
public static final int  Empty_Box=1;
public int choix=1;
public String Mode="Player vs Player";
int[][] previous=new int[9][17];



public static final int  w= 450;
public static final int  h = 850;
public static  int  i, j;
public static  int r, g, b;
ArrayList<int[][]> allPlays=new ArrayList();
Bot bot1;
Bot bot2;
public final Point Center= new Point(4,8);
public static int [][]obst={
  {0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0}, 
  {0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0}, 
  {0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 2, 0, 1, 0, 1, 0, 0}, 
  {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, 
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1}, 
  {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, 
  {0, 0, 1, 0, 1, 0, 3, 0, 3, 0, 3, 0, 1, 0, 1, 0, 0}, 
  {0, 0, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 0, 0}, 
  {0, 0, 0, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 0, 0, 0}
};



public static final  int [][]initmatrice={
  {0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 0}, 
  {0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0}, 
  {0, 0, 1, 0, 1, 0, 2, 0, 2, 0, 2, 0, 1, 0, 1, 0, 0}, 
  {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, 
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1}, 
  {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}, 
  {0, 0, 1, 0, 1, 0, 3, 0, 3, 0, 3, 0, 1, 0, 1, 0, 0}, 
  {0, 0, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 0, 0}, 
  {0, 0, 0, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 0, 0, 0}
}; 
PImage background;


ControlP5 gui;
void setup() {
  
   background= loadImage("board.png");;
  size(1184, 645);
 loadPixels();
 
 
 
 background(0);
 PFont p = createFont("Verdana",10); 
 ControlFont font = new ControlFont(p);
 //Create the new GUI
gui = new ControlP5(this);

gui.setColorBackground( #4c4c50 );
gui.setColorForeground(#969696);
gui.setColorActive(#4a4c4c);
//Add a Button
gui.addButton("Cpu1 vs Cpu2")
   //Set the position of the button : (X,Y)
   .setPosition(130,540)
   //Set the size of the button : (X,Y)
   .setSize(100,90)
   //Set the pre-defined Value of the button : (int)
   .setValue(0)
   .setFont(font)
   //set the way it is activated : RELEASE the mouseboutton or PRESS it
   .activateBy(ControlP5.PRESSED);
   ;

gui.addButton("Player vs Cpu1")
   //Set the position of the button : (X,Y)
   .setPosition(530,540)
   //Set the size of the button : (X,Y)
   .setSize(100,90)
   //Set the pre-defined Value of the button : (int)
   .setValue(1)
   .setFont(font)
   //set the way it is activated : RELEASE the mouseboutton or PRESS it
   .activateBy(ControlP5.PRESSED);
   ;
gui.addButton("Player vs Cpu2")
   //Set the position of the button : (X,Y)
   .setPosition(330,540)
   //Set the size of the button : (X,Y)
   .setSize(100,90)
   //Set the pre-defined Value of the button : (int)
   .setValue(2)
   .setFont(font)
   //set the way it is activated : RELEASE the mouseboutton or PRESS it
   .activateBy(ControlP5.PRESSED);
   ;
  
gui.addButton("Player vs Player")
   //Set the position of the button : (X,Y)
   .setPosition(730,540)
   //Set the size of the button : (X,Y)
   .setSize(100,90)
   //Set the pre-defined Value of the button : (int)
   .setValue(3)
   .setFont(font)
   //set the way it is activated : RELEASE the mouseboutton or PRESS it
   .activateBy(ControlP5.PRESSED);
   ;



}

public void controlEvent(ControlEvent theEvent) {
//Is called whenever a GUI Event happened

if(theEvent.isController()) { 
  
        Score=0;
        Score2=0;
        
        tour=2;
    obst=createcopy(initmatrice);
  if(theEvent.getController().getName()=="Player vs Player") {
         Mode="Player vs Player";
        choix=1;
  }

   if(theEvent.getController().getName()=="Player vs Cpu1") {
     Mode="Player vs Cpu1";
      choix=2;
      bot1=new Bot(PLAYER_1,2,3);
      
      
  
  }

  if(theEvent.getController().getName()=="Player vs Cpu2") {
    Mode="Player vs Cpu2";
    choix=3;
      bot2=new Bot(PLAYER_1,2,2);
  
  }
  
 if(theEvent.getController().getName()=="Cpu1 vs Cpu2") {
   Mode="Cpu1 vs Cpu2";
  
      choix=4;
      bot1=new Bot(PLAYER_1,2,3);
      bot2=new Bot(PLAYER_0,2,2);
  
  }





}


}


public int Score=0;
public int Score2=0;

public Point goal;
public boolean advGoalBox = false;
public int tour=PLAYER_0;

public boolean moved=false;

public boolean myBall(int player, int x, int y) {
  
  
  return obst[x][y]==player;
  
}

public boolean adverseBall(int x, int y) {

  return obst[x][y]==adverse(tour);
}

public int adverse(int Player) {

  if (Player == PLAYER_1 ) return PLAYER_0;
  else return PLAYER_1;
}



public boolean emptyBox(int x, int y) {

  return obst[x][y]==Empty_Box;
}

public boolean emptyBox(Point p) {

  return obst[p.getX()][p.getY()]==Empty_Box;
}

public void target(int x, int y) {
  if (emptyBox(x, y))
    goal= new Point(x, y);
  else if (adverseBall(x, y)) {
    advGoalBox= true;  
    goal= new Point(x, y);
  }
}


public void finTour() {

  ballsSelected.clear();
}


public void addToBallsSelectedList(Point p) {

  if (!ballsSelected.contains(p)) { 
    if ( ballsSelected.size() < 3)
      ballsSelected.add(p);
    else {finTour();
  }}
  /* first ball deside  */
  if (ballsSelectedListHasOne())  ballsSelected.get(0).setLeaderTrue();
}

public boolean ballsSelectedListHasOne() {
  return  ballsSelected.size() ==1;
}
void mousePressed() {
  if( -1+mouseY/50<9 && -1+mouseX/50 < 17 &&  -1+mouseY/50 >=0 && -1+mouseX/50 >=0){
  if(choix !=4) {
  if (mouseButton == RIGHT ) {
    if (myBall(tour,-1+mouseY/50, -1+mouseX/50)) {addToBallsSelectedList(new Point(-1+mouseY/50, -1+mouseX/50));}
  } else if (mouseButton == LEFT ) {

    if (!ballsSelected.isEmpty()) {  
      /* init gaol*/
      target(-1+mouseY/50, -1+mouseX/50);
      allPlays.add(createcopy(obst));
      moves(); 
      finTour();
      
  }  
  
  
}}}}


public void moves() {
  if(goal==null) {finTour();return;}
  /* advgoalbox true when goal is a ball adverse
   false when goal is empty box */
  if (advGoalBox) {  
    movesWithPush();
  } else if (obst[goal.getX()][goal.getY()]==Empty_Box ) {  
    movesWithoutPush();
  }

  if (moved) tour=adverse(tour);
  else allPlays.remove(allPlays.size()-1);
  moved= false;
  advGoalBox= false;   
  finTour();
  
}
Integer[][] copyBoard(){
Integer [][] f=new Integer[9][17];
for(int i=0;i<9;i++)for(int j=0;j<17;j++){
f[i][j]=obst[i][j];
} return f;
}
Integer[][] copyBoard(Integer[][] a){
Integer [][] f=new Integer[9][17];
for(int i=0;i<9;i++)for(int j=0;j<17;j++){
f[i][j]=a[i][j];
} return f;
}
void goBack(){
for(int i=0;i<9;i++)for(int j=0;j<17;j++) obst[i][j]=previous[i][j];

}
void savePrevious(){
for(int i=0;i<9;i++)for(int j=0;j<17;j++) previous[i][j]=obst[i][j];

}


public void movesWithPush() {
  if ( (relatedPoint() && goalAlignedToAll()) && CanIPush()== null  ) {  
  } else if ( relatedPoint() && goalAlignedToAll() && CanIPush().equals(new Point(-1, -1))  ) {  /* move my balls */
     if(tour==PLAYER_0) Score++;
     else Score2++;
    moveDiago();  
    
  } else if ( relatedPoint() && goalAlignedToAll() && CanIPush()!= null  ) {   
    /* move balls adverse */    moveTo(goal, CanIPush(), adverse(tour));
    /* move my balls */    moveDiago();
  } else if ( goalAlignedToAllVertical() && relatedPoint() &&  CanIPush()== null   ) {  
    
  } else if ( goalAlignedToAllVertical() && relatedPoint() &&  CanIPush().equals(new Point(-1, -1))    ) {     /* move my balls */
if(tour==PLAYER_0) Score++;
     else Score2++;    moveHoriz();  
    
  } else if ( goalAlignedToAllVertical() && relatedPoint() && CanIPush()!= null  ) {   
    moveTo(goal, CanIPush(), adverse(tour)); 
    moveHoriz();
  }
}
// CanIpush
// return null if cant push
// return (-1,-1) if push with elimination of one ball
// return Ponitof emptyBOX IF Push chithout elimination
public int[][] movesWithPush(int player, int[][] board, Point goal) {

  if ( (relatedPoint(goal) && goalAlignedToAll(goal) && CanIPush(board, goal)== null  )) {  
    
  } else if ( relatedPoint(goal) && goalAlignedToAll(goal) && CanIPush(board, goal).equals(new Point(-1, -1))  ) {  /* move my balls */
    board=moveHoriz(player, board, goal);  
   
  } else if ( relatedPoint(goal) && goalAlignedToAll(goal) && CanIPush(board, goal)!= null  ) {   

    /* move balls adverse */    board= moveTo(adverse(player), board, goal, CanIPush(board, goal));
    /* move my balls */    board= moveDiago(player, board, goal);
  } else if ( goalAlignedToAllVertical(goal) && relatedPoint(goal) &&  CanIPush(board, goal)== null   ) {  
    
  } else if ( goalAlignedToAllVertical(goal) && relatedPoint(goal) && CanIPush(board, goal).equals(new Point(-1, -1))    ) {     /* move my balls */
    board=moveHoriz(player, board, goal);  
    
  } else if ( goalAlignedToAllVertical(goal) && relatedPoint(goal) && CanIPush(board, goal)!= null  ) {  
  
    board=moveTo(adverse(player), board, goal, CanIPush(board, goal));
    board= moveHoriz(player, board, goal);
  }

  return board;
}
public Point CanIPush() {
  // cant push with 1 ball
  if (ballsSelectedListHasOne() ) return null;
  Point p =null;

  //select ball la plus proche du goal 
  for (Point m : ballsSelected )
  {       
    if (m.getD()==2) p = new  Point(m.getX(), m.getY());
  }

  if (p!=null) {  
    //find direction

    if ( p.getX()+1 == goal.getX() && p.getY()+1 == goal.getY()) {  
      return search(1, 1);
    } else if (p.getX()-1 == goal.getX() && p.getY()-1 == goal.getY()) { 
      return search(-1, -1);
    } else if (p.getX()+1 == goal.getX() && p.getY()-1 == goal.getY())  return search(1, -1);
    else if (p.getX()-1 == goal.getX() && p.getY()+1 == goal.getY()) return search(-1, 1);
    else if (p.getX() == goal.getX() && p.getY()-2 == goal.getY()) { 
      return search(0, -2);
    } else if (p.getX() == goal.getX() && p.getY()+2 == goal.getY()) {  
      return   search(0, 2);
    }
  }

  return null;
}


public Point CanIPush(int[][]board, Point goal) {
  // cant push with 1 ball
  if (ballsSelectedListHasOne() ) return null;
  Point p =null;

  //select ball la plus proche du goal 
  for (Point m : ballsSelected )
  {       
    if (Manhatan(m, goal)==2) p = new  Point(m.getX(), m.getY());
  }

  if (p!=null) {  
    //find direction

    if ( p.getX()+1 == goal.getX() && p.getY()+1 == goal.getY()) {  
      return search(board, 1, 1, goal);
    } else if (p.getX()-1 == goal.getX() && p.getY()-1 == goal.getY()) { 
      return search(board, -1, -1, goal);
    } else if (p.getX()+1 == goal.getX() && p.getY()-1 == goal.getY())  return search(board, 1, -1, goal);
    else if (p.getX()-1 == goal.getX() && p.getY()+1 == goal.getY()) return search(board, -1, 1, goal);
    else if (p.getX() == goal.getX() && p.getY()-2 == goal.getY()) { 
      return search(board, 0, -2, goal);
    } else if (p.getX() == goal.getX() && p.getY()+2 == goal.getY()) {  
      return   search(board, 0, 2, goal);
    }
  }

  return null;
}

public Point search(int x, int y) {

  boolean ican = true ;
  int nbrBalladv =1;
  int Ycurrent=goal.getY();
  int Xcurrent=goal.getX();
  boolean boxEmpty=false;
  Point Pempty=null;
  Xcurrent = Xcurrent+x;
  Ycurrent = Ycurrent+y;
  while ( nbrBalladv != 3 && !boxEmpty && ican &&  Ycurrent<17 && Xcurrent < 9 && Xcurrent > -1 && Ycurrent > -1 ) {

    if (obst[Xcurrent][Ycurrent] == adverse(tour)) nbrBalladv++;
    else if (obst[Xcurrent][Ycurrent] == tour) ican= false;
    else if (obst[Xcurrent][Ycurrent] == Empty_Box) { 
      Pempty = new Point(Xcurrent, Ycurrent);  
      boxEmpty=true;
    }

    Xcurrent = Xcurrent+x;
    Ycurrent = Ycurrent+y;
  }
  if (ican && nbrBalladv != 3 ) {
    if ( ballsSelected.size() > nbrBalladv  ) {

      if ( boxEmpty ) { 
        return Pempty;
      } else if (!boxEmpty) {   
        return new Point(-1, -1);
      }
    } else return null;
  }
  return null;
}

public Point search(int[][] board, int x, int y, Point goal) {

  boolean ican = true ;
  int nbrBalladv =1;
  int Ycurrent=goal.getY();
  int Xcurrent=goal.getX();
  boolean boxEmpty=false;
  Point Pempty=null;
  Xcurrent = Xcurrent+x;
  Ycurrent = Ycurrent+y;
  while ( nbrBalladv != 3 && !boxEmpty && ican &&  Ycurrent<17 && Xcurrent < 9 && Xcurrent > -1 && Ycurrent > -1 ) {

    if (board[Xcurrent][Ycurrent] == adverse(tour)) nbrBalladv++;
    else if (board[Xcurrent][Ycurrent] == tour) ican= false;
    else if (board[Xcurrent][Ycurrent] == Empty_Box) { 
      Pempty = new Point(Xcurrent, Ycurrent);  
      boxEmpty=true;
    }

    Xcurrent = Xcurrent+x;
    Ycurrent = Ycurrent+y;
  }
  if (ican && nbrBalladv != 3 ) {
    if ( ballsSelected.size() > nbrBalladv  ) {

      if ( boxEmpty ) { 
        return Pempty;
      } else if (!boxEmpty) {   
        return new Point(-1, -1);
      }
    } else return null;
  }
  return null;
}


public void movesWithoutPush() { 
  //sans pousser les blocs adv    
  if (  relatedPoint() && goalAlignedToAll() ) {  
    
    moveDiago();
  } else if ( relatedPoint()  && goalAlignedToFirstSelected() ) {  
   
    moveL();
  } else if (relatedPoint() && goalAlignedToAllVertical()   ) {  
     
    moveHoriz();
  }
}





public void moveTo(Point p1, Point p2) {

  obst[p1.getX()][p1.getY()] = Empty_Box;
  obst[p2.getX()][p2.getY()] = tour;
}





public int[][] moveTo(int player, int[][]board, Point p1, Point p2) {

  if (p1.getX()>=0 && p1.getX()<9 && p1.getY()>=0 && p1.getY()<17 &&p2.getX()>=0 &&p2.getX()<9 && p2.getY()>=0 &&p2.getY()<17 )
  {  
    board[p1.getX()][p1.getY()] = Empty_Box;
    board[p2.getX()][p2.getY()] = player;
  }
  return board;
}








public void moveTo(Point p1, Point p2, int j) {

  obst[p1.getX()][p1.getY()] = Empty_Box;
  obst[p2.getX()][p2.getY()] = j;
}

public boolean relatedPoint() {


  if (ballsSelectedListHasOne()) return true;


  for (Point j : ballsSelected) {

    j.setD(Manhatan(j, goal));
  }

  Collections.sort(ballsSelected, new Comparator<Point>() {

    public int compare(Point p1, Point p2) {
      if (p1.getD() > p2.getD() ) return 1;
      else if (p1.getD() < p2.getD()) return -1;
      return 0;
    }
  }
  );

  if (ballsSelected.isEmpty()) return false;
  float m= ballsSelected.get(0).getD();
  boolean b =false;
  for (Point p : ballsSelected) { 
    if (m!=p.getD()) b =true;
  }
  if (!b) { 
    Collections.sort(ballsSelected, new Comparator<Point>() {

      public int compare(Point p1, Point p2) {
        if (p1.getX() > p2.getX() ) return 1;
        else if (p1.getX() < p2.getX()) return -1;
        return 0;
      }
    }
    );
  }


  for (int i=0; i<ballsSelected.size()-1; i++) {

    if (Manhatan(ballsSelected.get(i), ballsSelected.get(i+1)) != 2) return false;
  }

  return true;
}

public boolean relatedPoint(Point goal) {


  if (ballsSelectedListHasOne()) return true;


  for (Point j : ballsSelected) {

    j.setD(Manhatan(j, goal));
  }

  Collections.sort(ballsSelected, new Comparator<Point>() {

    public int compare(Point p1, Point p2) {
      if (p1.getD() > p2.getD() ) return 1;
      else if (p1.getD() < p2.getD()) return -1;
      return 0;
    }
  }
  );

  if (ballsSelected.isEmpty()) return false;
  float m= ballsSelected.get(0).getD();
  boolean b =false;
  for (Point p : ballsSelected) { 
    if (m!=p.getD()) b =true;
  }
  if (!b) { 
    Collections.sort(ballsSelected, new Comparator<Point>() {

      public int compare(Point p1, Point p2) {
        if (p1.getX() > p2.getX() ) return 1;
        else if (p1.getX() < p2.getX()) return -1;
        return 0;
      }
    }
    );
  }


  for (int i=0; i<ballsSelected.size()-1; i++) {

    if (Manhatan(ballsSelected.get(i), ballsSelected.get(i+1)) != 2) return false;
  }

  return true;
}
public boolean relatesPointss(ArrayList<Point> list) {



  for (int i=0; i<list.size()-1; i++) {

    if (Manhatan(list.get(i), list.get(i+1)) != 2) return false;
  }

  return true;
}


public boolean goalAlignedToAll() {

  if (ballsSelected.size() ==2) {

    if (ballsSelected.get(0).getD() == 2 &&  ballsSelected.get(1).getD() == 2 ) return false;
  }
  for (int i =0; i<=ballsSelected.size()-1; i++) {

    if (abs(goal.getX()-ballsSelected.get(i).getX()) != abs(goal.getY()- ballsSelected.get(i).getY())  ||
      abs(goal.getY()- ballsSelected.get(i).getY()) == 0 || abs(goal.getX()-ballsSelected.get(i).getX()) ==0) return false;
  }


  return true;
}
boolean pop=false;
public boolean goalAlignedToAll(Point goal) {

  if (ballsSelected.size() ==2) {

    if (Manhatan(ballsSelected.get(0), goal) == 2 &&  Manhatan(ballsSelected.get(1), goal)==2 ) return false;
  }
  for (int i =0; i<=ballsSelected.size()-1; i++) {

    if ((abs(goal.getX()-ballsSelected.get(i).getX()) != abs(goal.getY()- ballsSelected.get(i).getY())  ||
      abs(goal.getY()- ballsSelected.get(i).getY()) == 0 || abs(goal.getX()-ballsSelected.get(i).getX()) ==0)) return false;
  }


  return true;
}


public boolean goalAlignedToAll(ArrayList<Point>ballsSelected, Point goal) {

  if (ballsSelected.size() ==2) {

    if (Manhatan(ballsSelected.get(0), goal) == 2 &&  Manhatan(ballsSelected.get(1), goal)==2 ) return false;
  }
  for (int i =0; i<=ballsSelected.size()-1; i++) {

    if ((abs(goal.getX()-ballsSelected.get(i).getX()) != abs(goal.getY()- ballsSelected.get(i).getY())  ||
      abs(goal.getY()- ballsSelected.get(i).getY()) == 0 || abs(goal.getX()-ballsSelected.get(i).getX()) ==0)) return false;
  }


  return true;
}

public boolean goalAlignedToAllVertical() {

  if (ballsSelected.size() ==2) {

    if (ballsSelected.get(0).getD() == 2 &&  ballsSelected.get(1).getD() == 2 ) return false;
  }
  for (int i =0; i<=ballsSelected.size()-1; i++) {

    if (!(abs(goal.getX()-ballsSelected.get(i).getX()) != abs(goal.getY()- ballsSelected.get(i).getY())  &&
      abs(goal.getX()-ballsSelected.get(i).getX()) ==0)) return false;
  }


  return true;
}
public boolean goalAlignedToAllVertical(Point goal) {

  if (ballsSelected.size() ==2) {

    if (Manhatan(ballsSelected.get(0), goal) == 2 &&  Manhatan(ballsSelected.get(1), goal) == 2 ) return false;
  }
  for (int i =0; i<=ballsSelected.size()-1; i++) {

    if (!(abs(goal.getX()-ballsSelected.get(i).getX()) != abs(goal.getY()- ballsSelected.get(i).getY())  &&
      abs(goal.getX()-ballsSelected.get(i).getX()) ==0)) return false;
  }


  return true;
}



public boolean goalAlignedToAllVertical(Point goal, ArrayList<Point> aa) {

  if (aa.size() ==2) {

    if (Manhatan(aa.get(0), goal) == 2 &&  Manhatan(aa.get(1), goal) == 2 ) return false;
  }
  for (int i =0; i<=aa.size()-1; i++) {

    if (!(abs(goal.getX()-aa.get(i).getX()) != abs(goal.getY()- aa.get(i).getY())  &&
      abs(goal.getX()-aa.get(i).getX()) ==0)) {
      return false;
    }
  }


  return true;
}











public boolean goalAlignedToFirstSelected() {
  for (Point m : ballsSelected) {
    if (m.isleader())  
    {      
      if (abs(goal.getX()-m.getX()) == abs(goal.getY()- m.getY()) && Manhatan(m, goal)==2 ) {
        return true;
      }
    }
  }

  return false;
}
public boolean goalAlignedToFirstSelected(Point goal) {
  for (Point m : ballsSelected) {
    if (m.isleader())  
    {      
      if (abs(goal.getX()-m.getX()) == abs(goal.getY()- m.getY()) && Manhatan(m, goal)==2 ) {
        return true;
      }
    }
  }

  return false;
}



public boolean goalAlignedToFirstSelected(ArrayList<Point>ballsSelected, Point goal) {
  for (Point m : ballsSelected) {
    if (m.isleader())  
    {      
      if (abs(goal.getX()-m.getX()) == abs(goal.getY()- m.getY()) && Manhatan(m, goal)==2 ) {
        return true;
      }
    }
  }

  return false;
}







public void moveL() {

  Point pp = ballsSelected.get(0);
  
  for(int i=1; i< ballsSelected.size();i++){
  if(pp.getY()==ballsSelected.get(i).getY()){ moved=false; return;}
  
  
  }
  
    Point p=null;
  for(Point e:ballsSelected){
  if(e.isleader()){p=e;}
  }
  if (goal.getX()-p.getX() > 0 && goal.getY()- p.getY() > 0) {   
    if (spaceLibreForOthers(1, 1)){ moveGroupe(1, 1); 
    moved=true;
    }else moved=false;
  } else if (goal.getX()-p.getX() < 0 && goal.getY()- p.getY() <0) {   
    if (spaceLibreForOthers(-1, -1)){ moveGroupe(-1, -1); 
    moved=true;
    }else moved=false;
  } else if (goal.getX()-p.getX() > 0 && goal.getY()- p.getY()<0) {   
    if (spaceLibreForOthers(1, -1)){ moveGroupe(1, -1);
    moved=true;
  }else moved=false;
  } else if (goal.getX()-p.getX() < 0 && goal.getY()- p.getY() >0) {   
    if (spaceLibreForOthers(-1, 1)){ moveGroupe(-1, 1); 
     moved=true;
     }else moved=false;
  } else  {moved=false;}
  
  
  
  
  
}




public int[][] moveL(int player, int[][] board2, Point goall) {
  
  
  Point pp = ballsSelected.get(0);
  
  for(int i=1; i< ballsSelected.size();i++){
  if(pp.getY()==ballsSelected.get(i).getY()){ moved=false; return board2;}
  
  
  }
  
  
  
  
  int  [][]board=new int[9][17];
  for (int i=0; i<9; i++)for (int j=0; j<17; j++) {
    board[i][j]=board2[i][j];
  }
  //   println("mov laterale");
  Point p = ballsSelected.get(0);   
  if (goall.getX()-p.getX() > 0 && goall.getY()- p.getY() > 0) {  
    if (spaceLibreForOthers(board, 1, 1)) { 
      return moveGroupe(player, board, 1, 1);
    }
  } else if (goall.getX()-p.getX() < 0 && goall.getY()- p.getY() <0) {  
    if (spaceLibreForOthers(board, -1, -1)) { 
      return moveGroupe(player, board, -1, -1);
    }
  } else if (goall.getX()-p.getX() > 0 && goall.getY()- p.getY()<0) {   
    if (spaceLibreForOthers(board, 1, -1)) {  
      return moveGroupe(player, board, 1, -1);
    }
  } else if (goall.getX()-p.getX() < 0 && goall.getY()- p.getY() >0) {   
    if (spaceLibreForOthers(board, -1, 1)) {  
      return moveGroupe(player, board, -1, 1);
    }
  }
  return board;
}


public void moveHoriz() {
  //   println("mov horiz");

  float max=Manhatan(goal, ballsSelected.get(0));
  Point pmax= ballsSelected.get(0);
  for (Point p : ballsSelected) {

    if (max < Manhatan(goal, p) ) { 
      max =Manhatan(goal, p); 
      pmax= p;
    }
  }
  if (max == ballsSelected.size()*2 ) {
    moveTo(pmax, goal);  
    moved=true;
  } else moved=false;
}


public int[][] moveHoriz(int player, int[][] board2, Point goal) {
  //   println("mov horiz");
  int [][]board=new int[9][17];      
  for (int i=0; i<9; i++)for (int j=0; j<17; j++) {
    board[i][j]=board2[i][j];
  }
  float max=Manhatan(goal, ballsSelected.get(0));
  Point pmax= ballsSelected.get(0);
  for (Point p : ballsSelected) {

    if (max < Manhatan(goal, p) ) { 
      max =Manhatan(goal, p); 
      pmax= p;
    }
  }
  if (max == ballsSelected.size()*2 )
    return moveTo(player, board, pmax, goal);
  //   else println("far");

  return board2;
}

public boolean spaceLibreForOthers(int x, int y) {

  for (int i=1; i<ballsSelected.size(); i++) {
    if (obst[ballsSelected.get(i).getX()+x][ballsSelected.get(i).getY()+y] != Empty_Box) { 
      return false ;
    }
  }
  return true;
}



public boolean spaceLibreForOthers(int[][] board, int x, int y) {
  for (int i=0; i<ballsSelected.size(); i++) {
    if (!(ballsSelected.get(i).getX()+x >8 || ballsSelected.get(i).getX()+x<0 || ballsSelected.get(i).getY()+y>16 || ballsSelected.get(i).getY()+y<0))
      if (board[ballsSelected.get(i).getX()+x][ballsSelected.get(i).getY()+y] != Empty_Box) {
        return false ;
      }
  }

  return true;
}

public void moveGroupe(int x, int y) {


  for (Point j : ballsSelected) {
    moveTo(j, new Point(j.getX()+x, j.getY()+y));
  }
}


public int[][] moveGroupe(int player, int[][] board, int x, int y) {


  for (Point j : ballsSelected) {
    board = moveTo(player, board, j, new Point(j.getX()+x, j.getY()+y));
  }

  return board;
}


float Manhatan(Point p1, Point p2) {
  return abs(p1.getX()-p2.getX())+abs(p1.getY()-p2.getY());
}

public void moveDiago() {

  // println("mov diagonale");
  float max=Manhatan(goal, ballsSelected.get(0));
  Point pmax= ballsSelected.get(0);
  for (Point p : ballsSelected) {

    if (max < Manhatan(goal, p) ) { 
      max =Manhatan(goal, p); 
      pmax= p;
    }
  }
  if (max == ballsSelected.size()*2 ) {
    moveTo(pmax, goal);
    moved=true;
  } else moved=false;
}

public int[][] moveDiago(int player, int[][]board2, Point goal) {
  int [][]board=new int[9][17];      
  for (int i=0; i<9; i++)for (int j=0; j<17; j++) {
    board[i][j]=board2[i][j];
  }

  // println("mov diagonale");
  float max=0;
  Point pmax= new Point(-1, -1);
  for (Point p : ballsSelected) {

    if (max < Manhatan(goal, p) ) { 
      max =Manhatan(goal, p); 
      pmax.setX(p.getX()); 
      pmax.setY(p.getY());
    }
  }
  if (max == ballsSelected.size()*2 ) {

    board = moveTo(player, board, pmax, goal);
    return board;
  }

  return board2;
}


public void playe(){

if(choix==2){

   if(tour!=PLAYER_0)  { 
   if(!updated) updated=true;
   else{
   bot1.Play();updated=false;}}
  

}

if(choix==3){
    if(tour!=PLAYER_0) {
       if(!updated) updated=true;
   else{bot2.Play(); updated=false;}
    }
}

if(choix==4){
    if(tour==bot2.currplayer)   bot2.Play();
    else bot1.Play();
}


}


import   javax.swing.*;
import static javax.swing.JOptionPane.*;
void draw() {

         
  
  
            updatePixels();
            
              if(pop){
                if(Score==6)
        {  
          
                 
      final ImageIcon icon = new ImageIcon("C:\\Users\\zigbo\\Desktop\\abalone\\data\\Capture2.png");
       showMessageDialog(null, "                White Wins", 
    "GameOver", INFORMATION_MESSAGE,icon);
    Score=0; Score2=0;
    choix=1; 
       pop=false;
         obst=createcopy(initmatrice);
}
       if(Score2==6){
                 final ImageIcon icon = new ImageIcon("C:\\Users\\zigbo\\Desktop\\abalone\\data\\Capture.png");
       showMessageDialog(null, "                 Red Wins", 
    "GameOver", INFORMATION_MESSAGE,icon);
         pop=true;
            Score=0; Score2=0;
choix=1; pop=false;
    obst=createcopy(initmatrice);

        
        }
        Mode="Player vs Player";
        }            
             background(background);
             
             if(tour==2)fill(255, 255, 255);
             else fill(255, 0, 0);
             
            PFont  turn = createFont("Georgia", 19);
              textFont(turn);
              
             if(choix==1 || choix==4) text((tour==2?"White's":" Red's") +" turn", 1034, 289); 
               else   text("Your turn", 1034, 289); 
               
                    textFont(turn);
             
             
             
             
             fill(150, 150, 150);
            PFont  mo = createFont("Georgia", 19);
              textFont(mo);
              
              text(Mode, 1030, 539); 
               
                    textFont(mo);
             
             
                  fill(255, 0, 0);
            PFont  mono = createFont("Georgia", 50);
              textFont(mono);
              text(Score2+"", 1018, 105); 
               fill(255, 255, 255);
                            textFont(mono);

               text(Score+"", 1125, 105); 
                 if(Score==6)
        {  
          
                 


    choix=1; pop=true;
        }

        if(Score2==6){
              
         pop=true;
           
choix=1;
        
        }
                
           for(int i=0;i<9;i++) {for(int j=0;j<17;j++){ if(obst[i][j]!=0){      ellipse(j*50 +72.9, i*50+75 , 52,52);} fill(color(0, 0, 0));   }
           fill(color(0, 0, 0));  
         }
        for(int i=0;i<9;i++) {for(int j=0;j<17;j++){ if(obst[i][j]==PLAYER_0 || obst[i][j]==PLAYER_1){
          if(ballsSelected.contains(new Point(i,j))){
          fill(color(80, 180, 0));}
      else{
        fill(color(obst[i][j]==PLAYER_0?255:192, obst[i][j]==PLAYER_0?255:0,obst[i][j]==PLAYER_0?255:0));
      }
      
      ellipse(j*50 +72.9, i*50 +75, 52, 52);
        } } }
      
      
     
  if( !(Score ==6 || Score2==6))playe();



  stroke(1);
//  if(tour!=PLAYER_0) {bot1.Play(); }
}
