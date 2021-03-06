pragma solidity ^0.5.0;

import "./PupperCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

contract PupperCoinSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
    constructor(
        uint256 rate,
        string memory name,
        string memory symbol,
        address payable wallet,
        uint256 open,
        uint256 close,
        uint256 goal,
        PupperCoin token_address
    )
        // Citation: https://ethereum.stackexchange.com/questions/30979/vm-exception-while-processing-transaction-invalid-opcode-when-deploying-cont
        RefundableCrowdsale(18)
        public
    {
        // constructor can stay empty
    }
}

contract PupperCoinSaleDeployer {

    address public sale_address;
    address public token_address;

    constructor(
        string memory name,
        string memory symbol,
        address payable wallet,
        uint256 open,
        uint256 close,
        uint256 goal
    ) 
        //RefundableCrowdsale(10) 
        public
    {
        PupperCoin token = new PupperCoin(name, symbol, 0);
        token_address = address(token);

        PupperCoinSale token_sale = new PupperCoinSale(1, "PupperCoin", "PUPP", sale_address, now, now + 24 weeks, 18, token_address);
        sale_address = address(token_sale);

        token.addMinter(sale_address);
        token.renounceMinter();
    }
}