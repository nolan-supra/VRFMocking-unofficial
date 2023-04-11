// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Interaction.sol";
import "../src/ISupraRouterMock.sol";

contract InteractionTest is Test {

    Interaction public interaction;
    ISupraRouterMock public supra;

    function setUp() public {
        supra = new ISupraRouterMock();
        interaction = new Interaction(address(supra));
    }

    function testVRF() public {
       
    
        console.log("Address of SupraRouter: %s",address(supra));
        console.log("Address of Interaction: %s", address(interaction));


        //Calls the getRNGForUser function to request a number
        //This would be nonce of 0
        interaction.getRNGForUser(5, 'test');

        //Fulfills the request for nonce
        supra.fulfillRequest(0);

    }


}


