// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ExpensiveNft is ERC721, Ownable {
    using Counters for Counters.Counter;
    address private signerAddress;

    Counters.Counter private _tokenIdCounter;

    constructor(address _signerAddress) ERC721("ExpensiveNft", "RICH") {
        signerAddress = _signerAddress;
    }

    function safeMint() external {
        // check heree
        _safeMint();
    }

    function _safeMint() internal {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function _verifySignature(address _user, bytes memory _signature)
        internal
        view
        returns (bool)
    {
        return
            ECDSA.recover(keccak256(abi.encodePacked(_user)), _signature) ==
            signerAddress;
    }
}
