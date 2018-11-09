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
    function register(int f)
    {
        if(count==0)
        {
            address ad=msg.sender;
            player p1;
            p1.addr=ad;
            p1.fee=f;
            p1.balance=0;
            count++;
            p1.turn=1;
        }
        else if(count==1)
        {
            address ad=msg.sender;
            player p1;
            p1.addr=ad;
            p1.fee=f;
            p1.balance=0;
            count++;
            p1.turn=1;
        }
}
