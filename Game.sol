pragma solidity ^0.4.24;
contract Game{
    int reward;
    mapping(int=>mapping(int=>int)) board;
    int turn;
    int count;
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
        turn=0;
        count=0;
    }
    function check_state(int r1,int c1,int r2,int c2,int r3,int c3) returns (int)
    {
        if(board[r1][c1]==board[r2][c2] && board[r2][c2]==board[r3][c3])
            return board[r1][c1];
        else
        return -1;
        
    }
    function register(int f)
    {
        if(count==0)
        {
            address ad=msg.sender;
            p1.addr=ad;
            p1.fee=f;
            p1.balance=0;
            count++;
            p1.turn=1;
        }
        else if(count==1&&msg.sender!=p1.addr)
        {
            p2.addr=msg.sender;
            p2.fee=f;
            p2.balance=0;
            count++;
            p2.turn=2;
            count++;
        }
    }
    function check_winner()
    {
        
    }
    function play(int row,int col)
    {
        if(count==2&&row>=0&&row<3&&col>=0&&col<3&&board[row][col]==-1)
        {
            address a=msg.sender;
            if(p1.addr==a&&turn==1)
            {
                board[row][col]=0;//0
                check_winner();
            }
            else if(p2.addr==a&&turn==2)
            {
                board[row][col]=1;//X
                check_winner();
            }
        }
    }
}c
