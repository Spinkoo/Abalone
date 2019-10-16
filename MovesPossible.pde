public class   Move{
  private Directions d;
  public ArrayList<Point> Points=new ArrayList();
  private boolean pushable=false;
  public Point goall;
 public Move(Directions d, ArrayList<Point> Points, boolean pushable, Point goal) {


    this.d=d;
    this.Points =  Points;
    this.pushable = pushable;
    this.goall = goal;
  }
}
public class MovesPossible {

  ArrayList<Move> Moves=new ArrayList();


  

  public ArrayList<Integer[][]> MovesPossibles(int Player, int[][]board) {
    ArrayList<Integer[][]> configs=new ArrayList();

    //for each ball(s) add a move to Moves
    int adverse = adverse(Player);
    Integer [][] tempboard=new Integer[9][17];
    create(tempboard, board);
    configs.add(tempboard);
    for (int i=0; i<board.length; i++) { 
      for (int j=0; j<board[i].length; j++) { 
        if (board[i][j] == Player) { 
          ballsSelected.clear();
          ballsSelected.add(new Point(i, j));
          ArrayList<Directions> liste = new ArrayList<Directions>();
          liste = func(board, i, j);
          for (Directions  m : liste ) {
            Point goal;

            switch (m) {
            case RRIGHT  :  
              goal = new Point(i, j+2);  
              break;
            case LLEFT   :  
              goal = new Point(i, j-2); 
              break;
            case UPLEFT  : 
              goal = new Point(i-1, j-1); 
              break;
            case UPRIGHT  :  
              goal = new Point(i-1, j+1); 
              break;
            case DOWNRIGHT:  
              goal = new Point(i+1, j+1); 
              break;
            case DOWNLEFT : 
              goal = new Point(i+1, j-1); 
              break;
            default : 
              goal = new Point (-1, -1);
            }
            ArrayList<Point> l = new ArrayList<Point>();
            l.add(new Point(i, j));
            Move m1 = new Move(m, l, false, goal);
            Moves.add(m1);
          }
        }
      }
    }


    ballsSelected.clear();
    int [][]board2=new int[9][17];

    for (Move e : Moves) {
      for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
      Integer [][] temp=new Integer[9][17];
      board2=moveTo(Player, board2, e.Points.get(0), e.goall);
      create(temp, board2);
      configs.add(temp);
    }


    ArrayList<ArrayList<Point>> cache = new ArrayList<ArrayList<Point>>();

    ArrayList<Point> temp = new ArrayList<Point>();
    for (int i=0; i<board.length; i++) { 
      for (int j=0; j<board[i].length; j++) { 
        if (board[i][j] == Player) { 

          Point p1 = new Point(i, j);




          ArrayList<Point> adj = adjacents(Player, board, p1);



          for (int l=0; l<adj.size(); l++) {
            temp = new ArrayList<Point>();
            temp.add(p1);
            temp.add(adj.get(l));
            Collections.sort(temp, new Comparator<Point>() {

              public int compare(Point p1, Point p2) {
                if (p1.x> p2.x ) return 1;
                else if (p1.x < p2.x) return -1;
                else   if (p1.y> p2.y ) return 1;
                else if (p1.y < p2.y) return -1;
                return 0;
              }
            }
            );                               
            if ( !cache.contains(temp) ) { 
              cache.add(temp);
            }
          }
        }
      }
    }



    for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
    for (ArrayList<Point> p : cache) {
      ballsSelected.clear();
      ballsSelected.addAll(p);

      ArrayList<Point> adjacents2point = adjacents2points(Player, board, p);
      for (Point e : adjacents2point) {
        int[][]temps=null;
        int [][]t;
        Integer[][]a=new Integer[9][17];
        t=temps;

        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 

        if (relatedPoint(e) && board[e.x][e.y]!=adverse  && goalAlignedToAll(e)  ) { 
          temps=moveDiago(Player, board2, e); 
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
        t=temps; 

        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 

        for (int i =0; i<2; i++) {
          ballsSelected.get(i).setLeaderTrue(); 
          if (relatedPoint(e) && board[e.x][e.y]!=adverse  && goalAlignedToFirstSelected(e) && relatedPoint(e)) {
            ; 
            a=new Integer[9][17];
            temps=moveL(Player, board2, e);
            if (temps!=null)if (!compare(temps, t)) {
              create(a, temps);
              if (!contain(configs, a)) {
                configs.add(a);
              }
            }
          }   
          ballsSelected.get(i).setLeaderFalse();
        }


        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
        if ( relatedPoint(e) && board[e.x][e.y]!=adverse && goalAlignedToAllVertical(e)&&isHoriz(p.get(0), p.get(1)) ) {
          t=temps;
          a=new Integer[9][17];
          temps=moveHoriz(Player, board2, e);
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
        t=temps;

        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 

        t=temps;
        if (board2[e.x][e.y]==adverse &&((isDiag(p.get(0), p.get(1)) && goalAlignedToAll(e)) ||  (( goalAlignedToAllVertical(e)) &&isHoriz(p.get(0), p.get(1))))) {
          a=new Integer[9][17];
          temps=movesWithPush(Player, board2, e);
          if (temps!=null)if (!compare(temps, board)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
      }
    }

    //3





    board2=new int[9][17];
    ArrayList<ArrayList<Point>> tmps=adjacents3pointsDiago(Player, board, cache);

    for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
    for (ArrayList<Point> p : tmps) {
      ballsSelected.clear();
      ballsSelected.addAll(p);

      ArrayList<Point> goals =adjacents4pointsDiago(adverse, board2, p);
      for (Point e : goals) { 
        int[][]temps=null;
        int [][]t;
        Integer[][]a=new Integer[9][17];
        t=temps;
        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 


        if (relatedPoint(e) && board[e.x][e.y]!=adverse    ) { 
          temps=moveDiago(Player, board2, e); 
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
        t=temps; 


        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 




        if (board2[e.x][e.y]==adverse && goalAlignedToAll(e)) { 
          a=new Integer[9][17];
          temps=movesWithPush(Player, board2, e);
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
      }
    }








    board2=new int[9][17];
    ArrayList<ArrayList<Point>> tmpss=adjacents3pointsHorizo(Player, board, cache);

    for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
    for (ArrayList<Point> p : tmpss) {
      ballsSelected.clear();
      ballsSelected.addAll(p);

      ArrayList<Point> goals =adjacents4pointsHorizo(adverse, board2, p);
      for (Point e : goals) {
        int[][]temps=null;
        int [][]t;
        Integer[][]a=new Integer[9][17];
        t=temps;
        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 


        if ( board[e.x][e.y]!=adverse    ) { 
          temps=moveHoriz(Player, board2, e); 
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
        t=temps; 


        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 





        if (board2[e.x][e.y]==adverse) { 
          a=new Integer[9][17];


          temps=movesWithPush(Player, board2, e);
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {
              configs.add(a);
            }
          }
        }
      }
    }







    board2=new int[9][17];
    ArrayList<ArrayList<Point>> tmpssss=adjacents3pointsDiago(Player, board, cache);
    for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
    for (ArrayList<Point> p : tmpssss) {
      ballsSelected.clear();
      ballsSelected.addAll(p);

      ArrayList<Point> goals =adjacents4pointsLaterale(adverse, board2, p);
      for (Point e : goals) {
        int[][]temps=null;
        int [][]t;
        Integer[][]a=new Integer[9][17];
        t=temps;
        for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 







        if ( board[e.x][e.y]!=adverse  ) { 
          temps=moveL(Player, board2, e); 
          if (temps!=null)if (!compare(temps, t)) {
            create(a, temps);
            if (!contain(configs, a)) {


              configs.add(a);
            }
          }
        }
        t=temps;
      }
    }

    board2=new int[9][17];
    tmpssss=adjacents3pointsHorizo(Player, board, cache);
    for (int i=0; i<9; i++)for (int j=0; j<17; j++) board2[i][j]=board[i][j]; 
    for (ArrayList<Point> p : tmpssss) {
      ballsSelected.clear();
      ballsSelected.addAll(p);

      ArrayList<Point> goals =adjacents4pointsLaterale(adverse, board2, p);
      for (Point e : goals) {
        int[][]temps=null;
        int [][]t;
        Integer[][]a=new Integer[9][17];
        t=temps;



        for (int i =0; i<3; i++) {

          ballsSelected.get(i).setLeaderTrue(); 

          if ( board[e.x][e.y]!=adverse && goalAlignedToFirstSelected(e) ) {
            temps=moveL(Player, board2, e); 
            if (temps!=null)if (!compare(temps, t)) {
              create(a, temps);
              if (!contain(configs, a)) {

                configs.add(a);
              }
              ballsSelected.get(i).setLeaderFalse();
            }
          }
        }
        t=temps;
      }
    }


    configs.remove(0);








    ballsSelected.clear();















    return configs;
  }


}
