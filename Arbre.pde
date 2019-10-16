public class Arbre{
public  double  alphaBeta(int player,Mesure mesure, double beta,int d,int level, int param)
{  double m=0;
  int [][] board=new int[9][17];
  MovesPossible e;
  if (d==0)
  {
    
    if((level%2)==0){
             if(param==3){     
                   mesure.evaluer(adverse(player));
                       return -1*mesure.getH();
   
               }else{     
                           mesure.evaluer2(adverse(player));
                                    return -1*mesure.getH();                 
 
 }
 
 
     }else{
   
   
        if(param==3){     
                   mesure.evaluer((player));
                         return mesure.getH();
         }else{     
                 mesure.evaluer2((player));
                       return mesure.getH();                 
          }
   
   
   
   
   
   }
  }
  else
  {   
    
    for(int i=0;i<9;i++)for(int j=0;j<17;j++) board[i][j]= mesure.getboard()[i][j];
       e=new MovesPossible();  
          
          
      
      
      ArrayList<Integer[][]> movestab =  e.MovesPossibles(player,board);
    Mesure me;
    double  t;
     m=-9999;
    int i=0; 
    
    while(i<movestab.size() && (m<beta))
    { 
      
            me= new Mesure(movestab.get(i),player,0);
          t = -alphaBeta(adverse(player),me, -1*m,d-1,level,param);
           if(t>m){m=t;   }
       i++;
                
    }  
  }  

  return m;   
}

}
