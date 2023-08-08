// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract DesignMarketplace {
    struct Prototype{
        uint256 id;
        uint256 price;
        address author;
        address[] buyers;
        string title;
    }

    Prototype[] prototypes;
    mapping(uint256 => string) private prototypeDownloadURLs;

    // events
    event PrototypeListed(uint256 indexed id, string title, uint256 price);
    event PrototypeSold(uint256 indexed id, address buyer);
    modifier isAuthor(uint256 _id) {
        require(
            msg.sender == prototypes[_id].author,
            "You are not the author of this prototype"
        );
        _;
    }

    modifier isNotAuthor(uint256 _id) {
        require(
            msg.sender != prototypes[_id].author,
            "You are the author of this prototype"
        );
        _;
    }

    modifier prototypeExists(uint256 _id) {
        require(prototypes.length >= _id, "The prototype does not exist");
        _;
    }
    modifier isBuyer(uint256 _id) {
        require(prototypes[_id].buyers.length > 0, "The prototype has no buyers");

        bool userIsBuyer = false;
        for (uint256 x = 0; x < prototypes[_id].buyers.length; x++) {
            if (prototypes[_id].buyers[x] == msg.sender) {
                console.log("Found buyer: ", prototypes[_id].buyers[x]);
                userIsBuyer = true;
            }
        }
        require(userIsBuyer, "You do not own this prototype.");
        _;
    }

    modifier isNotBuyer(uint256 _id) {
        require(prototypes[_id].buyers.length > 0, "The prototype has no buyers");

        bool userIsNotBuyer = true;
        for (uint256 x = 0; x < prototypes[_id].buyers.length; x++) {
            if (prototypes[_id].buyers[x] == msg.sender) {
                console.log("Found buyer: ", prototypes[_id].buyers[x]);
                userIsNotBuyer = false;
            }
        }
        require(userIsNotBuyer, "You already own this prototype");
        _;
    }

    function listPrototype(
        string memory _title,
        uint256 _price,
        string memory _arweaveURI
    ) public {
        Prototype memory prototype;

        prototype.id = prototypes.length;
        prototype.price = _price;
        prototype.author = msg.sender;
        prototype.title = _title;
        address[] memory buyers = new address[](1);
        buyers[0] = msg.sender;
        prototype.buyers = buyers;

        prototypes.push(prototype);

        console.log("Listing file with id", prototype.id);
        prototypeDownloadURLs[prototype.id] = _arweaveURI;

        emit PrototypeListed(prototype.id, _title, _price);
    }

    function buyPrototype(uint256 _id)
        external
        payable
        prototypeExists(_id)
        isNotAuthor(_id)
        isNotBuyer(_id)
    {
        require(msg.value >= prototypes[_id].price, "Not enough funds");

        address payable receiver = payable(prototypes[_id].author);
        (bool sent, ) = receiver.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

        prototypes[_id].buyers.push(msg.sender);

        emit PrototypeSold(_id, msg.sender);
    }

    function getPrototypes() public view returns (Prototype[] memory) {
        return prototypes;
    }

    function getOwnedPrototypes() public view returns (Prototype[] memory) {
        uint256 resCount = 0;

        for (uint256 i = 0; i < prototypes.length; i++) {
            if (prototypes[i].author == msg.sender) {
                resCount++;
            }
        }
        Prototype[] memory ownedPrototypes = new Prototype[](resCount);
        for (uint256 x = 0; x < prototypes.length; x++) {
            if (prototypes[x].author == msg.sender) {
                ownedPrototypes[x] = prototypes[x];
            }
        }
        return ownedPrototypes;
    }

    function getDownloadLink(uint256 _id)
        public
        view
        prototypeExists(_id)
        isBuyer(_id)
        returns (string memory)
    {
        return prototypeDownloadURLs[_id];
    }

    function getBoughtPrototypes() public view returns (Prototype[] memory) {
        uint64 resCount = 0;

        for (uint256 i = 0; i < prototypes.length; i++) {
            if (prototypes[i].buyers.length > 0) {
                for (uint256 x = 0; x < prototypes[i].buyers.length; x++) {
                    if (prototypes[i].buyers[x] == msg.sender) {
                        resCount++;
                    }
                }
            }
        }

        require(resCount > 0, "You bought no prototypes");

        Prototype[] memory boughtPrototypes = new Prototype[](resCount);

        for (uint256 j = 0; j < prototypes.length; j++) {
            if (prototypes[j].buyers.length > 0) {
                for (uint256 v = 0; v < prototypes[j].buyers.length; v++) {
                    if (prototypes[j].buyers[v] == msg.sender) {
                        boughtPrototypes[j] = prototypes[j];
                    }
                }
            }
        }
        return boughtPrototypes;
    }
}
