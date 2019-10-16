public class Mesure{
double Score;
Integer[][] board;
int player;
double h=0;
public Mesure(Integer[][] b,int p,double S){
Score=S; board=b; player=p;
}
public Mesure(){
Score=-1; board=null;
}

public Integer [][] getboard(){


return board;


}

public double getH(){

      return this.h;
}

public void setH(double h){

      this.h=h;
}

public void  evaluer(int Player){
  
  
  
  double l =((distancePointsCenter(adverse(Player))-distancePointsCenter2(adverse(Player))));
  l=l>0?0:l;
    h=distancePointsCenter(Player) - distancePointsCenter2(Player)-l;
    
   if(kicked(adverse(Player))){ 
   
   h+=12;} 
/*if(tour!=Player)   
   if(kicked(Player)){
   h-=30;
   }*/
  if(h<0)  h=0;

}


public void  evaluer2(int Player){
  
  
  
  double l =((distancePointsCenter(adverse(Player))-distancePointsCenter2(adverse(Player))));
  l=l>0?0:l*2;
    h=distancePointsCenter(Player) - distancePointsCenter2(Player)-l;
    
   if(kicked(adverse(Player))) h+=16;
  if(h<0)  h=0;

}

public double  distancePointsCenter(int player){
  
    double s=0;
    for(int i=0;i<9;i++)
      for(int j=0; j<17;j++){
      if(myBall(player,i,j)) s+=distancePointCenter(new Point(i,j));
      
      }
            
  return s;
}

public double  distancePointsCenter2(int player){
  
    double s=0;
    for(int i=0;i<9;i++)
      for(int j=0; j<17;j++){
      if(myBall2(player,board,i,j)) s+=distancePointCenter(new Point(i,j));
      
      }

            
  return s;
}


public double distancePointCenter(Point p){

    return Manhatan(p,Center);

}



public boolean myBall2(int player,Integer[][] obst, int x, int y) {
  
  return obst[x][y]==player;
}



public boolean  kicked(int player){
  int cmp1=0,cmp2=0;
    for(int i=0;i<9;i++)
      for(int j=0; j<17;j++){
      if(myBall2(player,board,i,j))  cmp1++;
      if(myBall(player,i,j)) cmp2++;
      
      }

            
  return cmp1!=cmp2;
}

}
