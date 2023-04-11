// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract ISupraRouterMock {

   struct request{
      address callingContract;
      string functionSig;
      uint8 rngCount;
      uint256 numConfirmations;
      uint256 clientSeed;
   }

   mapping(uint256 => request) requestMap;


   uint256 nonce;

   constructor(){
   }

   function generateRequest(string memory _functionSig , uint8 _rngCount, uint256 _numConfirmations, uint256 _clientSeed) external returns(uint256){
      requestMap[nonce] = request(msg.sender, _functionSig, _rngCount, _numConfirmations, _clientSeed);
      return nonce++;
   }

   function generateRequest(string memory _functionSig , uint8 _rngCount, uint256 _numConfirmations) external returns(uint256){
      //default seed of 123
      requestMap[nonce] = request(msg.sender, _functionSig, _rngCount, _numConfirmations, 0);
      return nonce++;
   }

   function fulfillRequest(uint256 fulfillNonce) external{

      uint256[] memory result = new uint256[](requestMap[fulfillNonce].rngCount);

      for(uint i=0; i< result.length;i++){
         result[i] = uint256(keccak256(abi.encode(fulfillNonce, i, requestMap[fulfillNonce].clientSeed)));
      }

      (bool success, /*bytes memory result*/) = requestMap[fulfillNonce].callingContract.call(abi.encodeWithSignature(requestMap[fulfillNonce].functionSig, fulfillNonce, result));
   }


}