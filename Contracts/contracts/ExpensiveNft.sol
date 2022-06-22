// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ExpensiveNft is ERC721, Ownable {
    using Counters for Counters.Counter;
    address private signerAddress = 0x28037276963Ce8AAC3DD3fb46fDaF17F8532ea53;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("ExpensiveNft", "RICH") {}

    function safeMint(bytes memory _signature) external {
        require(_verifySignature(msg.sender, _signature), "Invalid signature");
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
