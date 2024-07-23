// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract NFTMarketplace {

    error NotOwner();
    error PriceMustBeAboveZero();
    error NotApprovedForMarketplace();
    error AlreadyListed(address nftAddress, uint tokenId);
    error NotListed(address nftAddress, uint tokenId);
    error PriceNotMet(address nftAddress, uint tokenId, uint price);

    event NFTListed(
        address indexed seller,
        address indexed nftAddress,
        uint indexed tokenId,
        uint price
    );

    event NFTCanceled(
        address indexed seller,
        address indexed nftAddress,
        uint indexed tokenId
    );

       event NFTBought(
        address indexed buyer,
        address indexed nftAddress,
        uint indexed tokenId,
        uint price
    );


    struct NFTInfo {
        uint price;
        address seller;
    }

    mapping(address seller => uint balance) private _sellersProceed;
    mapping(address nftAddress => mapping(uint tokenId => NFTInfo)) private _nftList;

    modifier notListed(address nftAddress, uint tokenId) {   //es para asegurarme que no esté listado
        if (_nftList[nftAddress][tokenId].price>0){
            revert AlreadyListed(nftAddress, tokenId);
        }
        _;
    }

       modifier isListed(address nftAddress, uint tokenId) {   //es para asegurarme que no esté listado
        if (_nftList[nftAddress][tokenId].price==0){
            revert NotListed(nftAddress, tokenId);
        }
        _;
    }

    modifier isOwner(address nftAddress, uint tokenId, address spender){
            if (spender != IERC721(nftAddress).ownerOf(tokenId)){
                revert NotOwner();
            } //se le pone entre parentesis nftAddress para poder acceder desnde el contrato de NftContract
            _;
    }

    function listNFT(address nftAddress, uint tokenId, uint price) 
    external 
    notListed(nftAddress, tokenId)
    isOwner(nftAddress, tokenId,msg.sender)
     {
        
        if (price <=0){
        revert PriceMustBeAboveZero();
    }

        if (IERC721(nftAddress).getApproved(tokenId) != address(this)){
            revert NotApprovedForMarketplace();
        }

        _nftList[nftAddress] [tokenId] = NFTInfo (price, msg.sender);
        emit NFTListed (msg.sender, nftAddress, tokenId, price );
    }

    function cancelNFT(address nftAddress, uint tokenId)
    external
    isOwner(nftAddress, tokenId, msg.sender)
    isListed(nftAddress, tokenId)
    {
    delete _nftList[nftAddress][tokenId]; //es un mapping anidado por eso tengo que poner dos claves para llegar al token. El price pasa a 0 y el seller a ox000
    emit NFTCanceled (msg.sender, nftAddress, tokenId);
    }

    function buyNFT(address nftAddress, uint tokenId)
        external
        payable 
        isListed(nftAddress, tokenId)
        {
        NFTInfo memory listedNFT = _nftList[nftAddress][tokenId];
        if (msg.value < listedNFT.price) {
            revert PriceNotMet (nftAddress, tokenId, listedNFT.price);
        }

            _sellersProceed[listedNFT.seller] += msg.value;
            delete _nftList[nftAddress][tokenId];
            IERC721(nftAddress).safeTransferFrom(listedNFT.seller, msg.sender, tokenId);
            emit NFTBought(msg.sender, nftAddress, tokenId, listedNFT.price);
            }

    function getNFTInfo (address nftAddress, uint tokenId) external view returns (NFTInfo memory){
        return _nftList [nftAddress][tokenId];
    }

    function getProceeds() external view returns(uint){
        return _sellersProceed[msg.sender];
    }
}


//buena practica es ponerle guion bajo a una variable privada
