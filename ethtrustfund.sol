pragma solidity 0.8.16;

contract EthTrustFund {

  address public owner;
  
  struct Beneficiary {
    address payable walletAddress;
    string name;
    uint releaseTime;
    uint amount;
  }

  Beneficiary[] public beneficiaries; 

  constructor() {
    owner = msg.sender;
  }

  function addBeneficiary(
      address payable walletAddress,
      string calldata name,
      uint releaseTime
  ) external {
      require(msg.sender == owner, "You must be the owner to add a beneficiary.")
  
      beneficiaries.push(
        Beneficiary(walletAddress, name, releaseTime, 0)
      );
  }  
  
  function depositToBeneficiary(address walletAddress) external payable {
      for(uint i = 0; i < beneficiaries.length; i++) {
          if (beneficiaries[i].walletAddress == walletAddress)  {
              beneficiaries[i].amount += msg.value;
          }
      }
  }
  
  function contractBalance() external view returns (uint) {
      return address(this).balance;
  }
  
  function availableToWithdraw(address walletAddress) public view returns(bool) {
      (uint i, bool ok) = _getIndex(walletAddress);
      require(ok, "Beneficiary does not exist."0); 
      
      if (block.timestamp > beneficiaries[i].releaseTime) {
          return true;
      }
      
      return false;
  }
  
  function _getIndex(address walletAddress) private view returns(uint, bool) {
      for(uint i = 0; i < beneficiaries.length; i++) {
          if (beneficiaries[i].walletAddress == walletAddress) {
              return (i, true); 
      }
      
      return (type(uint).max, false);
  }
}



/// Get Contract Balance

/// Check If We Can Withdraw

/// Withdraw

/// Extra

/// Events

/// Modifiers
