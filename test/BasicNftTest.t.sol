// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public nft;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs/QmPzTS4dHERdw1u8TXj75z1SumwjYisEUW9KWWQjQRCmC3?filename=INU.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        nft = deployer.run();
    }

    function testNameIsCorrect() public {
        bytes memory expectedName = "Doggie";
        bytes memory actualName = abi.encodePacked(nft.name());
        assertEq(expectedName, actualName);
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        nft.mintNft(PUG);

        assert(nft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(nft.tokenURI(0)))
        );
    }
}
