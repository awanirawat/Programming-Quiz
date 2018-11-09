pragma solidity ^0.4.24;
contract Game{
    mapping(int=>mapping(int=>int)) board;
    int  public turn;
    int  public count;
    int total_fee;
    address host;
    int public winner;
    struct player
    {
        address addr;
        int balance;
        int fee;
        int turn;
    }
    player p1;
    player p2;
    //player wins 2/3 of the total fee paid
    function Game()
    {
        for(int i=0;i<3;i++)
        {
            for(int j=0;j<3;j++)
                board[i][j]=-1;
        }
        turn=1;
        count=0;
        host=msg.sender;winner=0;
    }
    function check_state(int r1,int c1,int r2,int c2,int r3,int c3) returns (int)
    {
        if(board[r1][c1]!=-1&&board[r2][c2]!=-1&&board[r1][c1]==board[r2][c2] && board[r2][c2]==board[r3][c3])
            return board[r1][c1];
        else
        return -1;
        
    }
    function register(int f)
    {
        if(count==0&&msg.sender!=host)
        {
            address ad=msg.sender;
            p1.addr=ad;
            p1.fee=f;
            p1.balance=0;
            count++;
            p1.turn=1;
            total_fee+=f;
        }
        else if(count==1&&msg.sender!=p1.addr&&msg.sender!=host)
        {
            p2.addr=msg.sender;
            p2.fee=f;
            p2.balance=0;
            p2.turn=2;
            total_fee+=f;
            count++;
        }
    }
    function check_winner() returns(int)
    {
      int res=check_state(0,0,1,1,2,2);
      if(res!=-1)return res;
      res=check_state(0,2,1,1,2,0); 
      if(res!=-1)return res;
      res=check_state(0,0,0,1,0,2);
      if(res!=-1)return res;
      res=check_state(1,0,1,1,1,2);
      if(res!=-1)return res;
      res=check_state(2,0,2,1,2,2);
      if(res!=-1)return res;
      res=check_state(0,0,1,0,2,0);
      if(res!=-1)return res;
      res=check_state(0,1,1,1,2,1);
      if(res!=-1)return res;
      res=check_state(0,2,1,2,2,2);
      if(res!=-1)return res;
      return -1;
      
    }
    function add_reward(address addr)
    {
        if(p1.addr==addr)
            p1.balance=(2*total_fee)/3;
        else if(p2.addr==addr)
            p2.balance=(2*total_fee)/3;

    }
    function boardfull() public returns(bool)
    {
        for(int i=0;i<3;i++)
        {
            for(int j=0;j<3;j++)
            {
                if(board[i][j]==-1)
                return false;
            }
        }
        return true;
    }
    function play(int row,int col)
    {
        if(winner==0&&count==2&&row>=0&&row<3&&col>=0&&col<3&&board[row][col]==-1)
        {
            address a=msg.sender;
            if(p1.addr==a&&turn==1)
            {
                board[row][col]=0;//0
                int res=check_winner();
                if(res==board[row][col])
                {
                    add_reward(a);
                    winner=1;
                }
                turn=2;
            }
            else if(p2.addr==a&&turn==2)
            {
                board[row][col]=1;//X
                res=check_winner();
                if(res==board[row][col])
                {
                    add_reward(a);
                    winner=2;
                }
                turn=1;
            }
        }
        if(boardfull()&&winner==0)
            turn=0;
    
        
    }
}
