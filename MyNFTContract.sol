// SPDX-License-Identifier: MIT

pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFTContract is ERC721, ERC721URIStorage, Ownable {

    constructor (address initialOwner)
            ERC721 ("MyNFTContract","MNC")
            Ownable(initialOwner)
            {}

            function mint (address to, uint tokenId, string memory uri) public onlyOwner{
                _safeMint(to,tokenId);
                _setTokenURI(tokenId,uri);
            }

            function tokenURI (uint256 tokenId) public view override (ERC721, ERC721URIStorage) returns (string memory){
                return super.tokenURI(tokenId);
            }

            function supportsInterface(bytes4 interfaceId) public view override (ERC721, ERC721URIStorage) returns (bool){
                return super.supportsInterface(interfaceId);
            }
}
