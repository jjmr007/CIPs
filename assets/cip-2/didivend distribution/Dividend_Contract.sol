// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

abstract contract TokenB{
    
    function totalSupply() public view virtual returns (uint256);
    function balanceOf(address _owner) public view virtual returns (uint256 balance);

}

abstract contract TokenA{
    
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function transfer(address _to, uint256 _value) public virtual returns (bool success);
}

contract Dividend {
    
    using SafeMath for uint;
    bool internal FlaG;
    address public paYer;
    struct ToBurn {
        
        uint256 userBlock;
        uint256 lastBalance;
        uint256 dividend_Burnable;
        
    }
    
    uint256 public Total_A;
    uint256 internal Total_B;
    uint256 public Total_tB;
    uint256 internal sTart;
    mapping (address => ToBurn) internal _uSerDividends;
    
    
    TokenA public _TokenA;
    TokenB public _TokenB;
    
    constructor (address _a, address _b, address _paYer) public {
        
        // the only address allowed to supply payments to this contract
        // for USDC platform in ropsten this address is usually 0x75C0c372da875a4Fc78E8A37f58618a6D18904e8
        // but this parameter shudl be assesed by the Circle's team to help the client request
        paYer = _paYer;
        
        sTart = block.number;
        _TokenA = TokenA(_a);
        _TokenB = TokenB(_b);
        
        Total_B = _TokenB.totalSupply();
        
    }
    
    modifier OnlypaYer() {
        
        require (
            
            msg.sender == paYer,
            "Sender not authorized."
            
            );
        _;

    }
    
    function Payment (uint256 _aMount) OnlypaYer public {
        
        _TokenA.transferFrom(paYer, address(this), _aMount);
        Total_A = Total_A.add(_aMount);
        
    }
    
    modifier OnlyB() {
        
        require (
            
            msg.sender == address(_TokenB),
            "Sender not authorized."
            
            );
        _;
        
    }
    
    function TransferOwner(address _from, address _to, uint256 _aMount) OnlyB public {
        
        // pending to check the proper logics of this function
        
        uint256 Delta;
        if (_uSerDividends[_from].userBlock == 0) {
            Delta = block.number.sub(sTart);
        } else {
            Delta = block.number.sub(_uSerDividends[_from].userBlock);
        }
        _uSerDividends[_from].userBlock = block.number;
        _uSerDividends[_from].dividend_Burnable = _uSerDividends[_from].dividend_Burnable.add(Delta.mul(_uSerDividends[_from].lastBalance));
        _uSerDividends[_from].lastBalance = _TokenB.balanceOf(_from).sub(_aMount);
        
        if (_uSerDividends[_to].userBlock == 0) {
            Delta = block.number.sub(sTart);
        } else {
            Delta = block.number.sub(_uSerDividends[_to].userBlock);
        }
        _uSerDividends[_to].userBlock = block.number;
        _uSerDividends[_to].dividend_Burnable = _uSerDividends[_to].dividend_Burnable.add(Delta.mul(_uSerDividends[_to].lastBalance));
        _uSerDividends[_to].lastBalance = _TokenB.balanceOf(_to).add(_aMount);

    }
    
    modifier OnlyFalse() {
        
        require (
            
            FlaG == false,
            "Not Re-Entrance Allowed."
            
            );
        _;
        
    }
    
    function isContract(address _Alpha) private view returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_Alpha)
        }
        return codeSize > 0;
    }
    
    function CollectDividends(address _Alpha) OnlyFalse public {
        
        require (tx.origin == msg.sender || (isContract(_Alpha) && _Alpha != 0x0000000000000000000000000000000000000000));
        FlaG = true;
        if (!isContract(_Alpha)) {
        require(_Alpha == msg.sender); }
        uint256 _N = block.number.sub(sTart).mul(Total_B);
        uint256 Delta;
        if (_uSerDividends[_Alpha].userBlock == 0) {
            Delta = block.number.sub(sTart);
        } else {
            Delta = block.number.sub(_uSerDividends[_Alpha].userBlock);
        }
        _uSerDividends[_Alpha].userBlock = block.number;
        _uSerDividends[_Alpha].dividend_Burnable = _uSerDividends[_Alpha].dividend_Burnable.add(Delta.mul(_uSerDividends[_Alpha].lastBalance));
        uint256 paYment; 
        require(_N.sub(Total_tB)>=0);
        if (_N.sub(Total_tB)>0) {
        paYment = Total_A.mul(_uSerDividends[_Alpha].dividend_Burnable).div(_N.sub(Total_tB));  
        Total_tB = Total_tB.add(_uSerDividends[_Alpha].dividend_Burnable);
        }
        else {
            paYment = 0;
            sTart = block.number;
        }
        Total_A = Total_A.sub(paYment);
        _uSerDividends[_Alpha].dividend_Burnable = 0;
        _TokenA.transfer(_Alpha, paYment);
        FlaG = false;

    }
    
    function ConsultDividend(address _Alpha) public view returns (uint256) {
        
        uint256 _N = block.number.sub(sTart).mul(Total_B);
        uint256 paYment; 
        if (_N.sub(Total_tB)>0) {
        paYment = Total_A.mul(_uSerDividends[_Alpha].dividend_Burnable).div(_N.sub(Total_tB));  
        }
        else {
            paYment = 0;
        }
        return paYment;
        
    }

}