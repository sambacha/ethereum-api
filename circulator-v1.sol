pragma solidity 0.5.4;

interface ERC721Partial {
    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
}

/// @notice Create transfers to artifically increase statistics
///  on https://etherscan.io/tokens-nft
contract ERC721Circulator {
    /// @notice Circule several times
    /// @param nftContract A contract implementing ERC-721
    /// @param owner The beneficial owner
    /// @param tokenId The token to circulate
    /// @param count Number of times to circulate
    function circulate(ERC721Partial nftContract, address owner, uint256 tokenId, uint256 count) external {
        uint256 remaining = count;
        while (remaining > 0) {
            nftContract.transferFrom(owner, owner, tokenId);
            remaining -= 1;
        }
    }
}