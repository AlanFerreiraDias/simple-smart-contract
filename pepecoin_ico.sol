//Pepecoin ICO

//Version of compiler 
pragma solidity ^0.4.11;

contract pepecoin_ico {
    
    uint public max_pepecoins = 1000000;
    uint public usd_to_pepecoins = 1000;
    uint public total_pepecoins_bought = 0;
    
    //mapping from the investor address to its equity in pepecoins and USD
    mapping(address => uint) equity_pepecoins;
    mapping(address => uint) equity_usd;
    
    //Check if an investor can buy pepecoins
    modifier can_buy_pepecoins(uint usd_invested) {
        require (usd_invested * usd_to_pepecoins + total_pepecoins_bought <= max_pepecoins);
        _;
    }
    
    //getting the equity in pepecoins of an investor
    function equity_in_pepecoin(address investor) external constant returns(uint){
        return equity_pepecoins(investor);
    }
    
    //getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd(investor);
    }
    
    //Buying pepecoins
    function buy_pepecoins(address investor, uint usd_invested) external
    can_buy_pepecoins(usd_invested) {
        uint pepecoins_bought = usd_invested * usd_to_pepecoins;
        equity_pepecoins[investor] += pepecoins_bought;
        equity_usd[investor] = equity_pepecoins / usd_to_pepecoins;
        total_pepecoins_bought += pepecoins_bought;
    }
    
    //Sell pepecoins 
    function sell_pepecoins(address investor, uint pepecoins_sold) external {
        equity_pepecoins[investor] -= pepecoins_sold;
        equity_usd[investor] = equity_pepecoins / usd_to_pepecoins;
        total_pepecoins_bought -= pepecoins_sold;
    }
}