public class Bot {
 int currplayer;
 int level;
 int heuristiq;
 ArrayList<Mesure> Mesures=new ArrayList();
public Bot(int Player,int level,int heur){
currplayer=Player; this.level=level; heuristiq=heur;
}


void Play(){
  if(tour==currplayer){
    Integer [][]mo=new Integer[9][17];
      for(int i=0;i<9;i++)for(int j=0;j<17;j++) mo[i][j]= obst[i][j];
    Arbre arb=new Arbre();
       MovesPossible   e=new MovesPossible();  
        Mesures.clear();
        CreateMesures(e.MovesPossibles(currplayer,obst));
    
   int i=0;
   double max=-8888;
   int posmax=0;
   double temp=-1;
   ArrayList possiblesplays=new ArrayList();
   for(Mesure m:Mesures){
    if(Mesures.size()>43){
      temp=arb.alphaBeta((currplayer),m,999999999,level-1,level,heuristiq);
      delay(3);
    }
    else /*if(Mesures.size()>30)*/
          temp=arb.alphaBeta((currplayer),m,999999999,level,level+1,heuristiq);
    /*else if(Mesures.size()>10)
        temp=arb.alphaBeta((currplayer),m,999999999,level+1,level+2,heuristiq);
    else 
        temp=arb.alphaBeta((currplayer),m,999999999,level+2,level+3,heuristiq);*/

     if(temp==max)
       possiblesplays.add(i);
      else if(temp>max){ 
        possiblesplays.clear();
        possiblesplays.add(i);
        max=temp;
        } 
  
    
     i++;
   }
 
    posmax= ((int)((10*Math.random())%possiblesplays.size()));
    for( i=0;i<9;i++)for(int j=0;j<17;j++) obst[i][j]= Mesures.get((int)possiblesplays.get(posmax)).board[i][j];
       Scored(Mesures.get(posmax).board);

    tour=adverse(tour);
}
}

void CreateMesures(ArrayList<Integer[][]> m){
for(Integer[][] me:m){
Mesures.add(new Mesure(me,currplayer,0));
}
}












void Scored(Integer[][] a){
  int cmp1=0,cmp2=0;
    for(int i=0;i<9;i++)
      for(int j=0; j<17;j++){
      if(myBall2(adverse(currplayer),a,i,j))  cmp1++;
      if(myBall(adverse(currplayer),i,j)) cmp2++;
      
      }

            
  if(cmp1!=cmp2){  if(tour==PLAYER_0) Score++;
     else Score2++; 
  }
}

public boolean myBall2(int player,Integer[][] obst, int x, int y) {
  
  return obst[x][y]==player;
}


}
